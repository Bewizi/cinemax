import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_button.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_radius.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:cinemax/features/Explore/bloc/explore_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({
    required this.id,
    super.key,
  });

  final String id;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ExploreBloc>().add(GetMovieById(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      floatingActionButton: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.extraLargeRadius,
            boxShadow: [
              BoxShadow(
                color: AppColors.kWildStrawberry300.withValues(alpha: 0.25),
                blurRadius: 10,
                spreadRadius: 6,
              ),
            ],
          ),
          child: AppButtonElevated(
            text: 'Book Now',
            onPressed: () async {
              await context.push('/chooseSeats');
            },
          ),
        ),
      ),

      backgroundColor: AppColors.kBlack,
      appbar: AppBar(
        backgroundColor: AppColors.kTransparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(AppSvgs.kChevronLeft),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: AppText(
          'Movie Details',
          style: appTextTheme.titleMedium?.copyWith(
            color: AppColors.kWhite,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),

      body: BlocBuilder<ExploreBloc, ExploreState>(
        builder: (context, state) {
          final movieFromList = state.movies
              .where((m) => m.id == widget.id)
              .firstOrNull;

          if (state.movieStatus == ExploreStatus.success ||
              movieFromList != null) {
            final movie = state.selectedMovie ?? movieFromList!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: AppRadius.largeRadius,
                        child: Hero(
                          tag: widget.id,
                          child: Image.network(
                            movie.image!,
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height * 0.55,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (movie.rating != null)
                        Positioned(
                          top: 20,
                          right: 20,
                          child: _buildRating(movie.rating!),
                        ),

                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (movie.title != null)
                              AppText(
                                movie.title!,
                                style: appTextTheme.headlineSmall?.copyWith(
                                  color: AppColors.kWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            8.verticalSpacing,
                            if (movie.genre != null &&
                                movie.genre!.isNotEmpty) ...[
                              Wrap(
                                spacing: 8,
                                runSpacing: 4,
                                children: movie.genre!
                                    .map(_buildGenre)
                                    .toList(),
                              ),
                            ],
                            16.verticalSpacing,
                            Row(
                              children: [
                                if (movie.movieDuration != null)
                                  _buildDuration(movie.movieDuration!),
                                16.horizontalSpacing,
                                if (movie.price != null)
                                  _buildPrice(
                                    '\$${movie.price!.toStringAsFixed(2)}',
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  if (movie.description != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                        bottom: 16,
                      ),
                      child: AppText(
                        movie.description!,
                        style: appTextTheme.titleMedium?.copyWith(
                          color: AppColors.kWhite,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  if (movie.venue != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        bottom: 16,
                      ),
                      child: _buildVenue(movie.venue!),
                    ),
                ],
              ),
            );
          }
          if (state.movieStatus == ExploreStatus.failure) {
            return Center(
              child: AppText(
                state.errorMessage ?? 'An error occurred',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.kMagentaBloom500,
            ),
          );
        },
      ),
    );
  }

  Widget _buildVenue(String venue) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.kCarbonBlack,
        borderRadius: AppRadius.mediumRadius,
      ),
      child: AppRichText(
        spans: [
          TextSpan(
            text: 'Cinema',
            style: appTextTheme.titleMedium?.copyWith(
              color: AppColors.kWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: '  $venue',
            style: appTextTheme.titleMedium?.copyWith(
              color: AppColors.kSliver300,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating(String rating) {
    return Row(
      children: [
        SvgPicture.asset(AppSvgs.kStar),
        4.horizontalSpacing,
        AppText(
          rating,
          style: appTextTheme.titleMedium?.copyWith(
            color: AppColors.kWhite,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildGenre(String genre) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.kMagentaBloom500.withValues(alpha: 0.25),
        border: Border.all(color: AppColors.kDarkAmaranth700),
        borderRadius: AppRadius.fullRadius,
      ),
      child: AppText(
        genre,
        style: appTextTheme.titleMedium?.copyWith(
          color: AppColors.kWildStrawberry300,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDuration(String duration) {
    return Row(
      children: [
        SvgPicture.asset(AppSvgs.kclock),
        4.horizontalSpacing,
        AppText(
          duration,
          style: appTextTheme.titleMedium?.copyWith(
            color: AppColors.kSliver300,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPrice(String price) {
    return AppText(
      price,
      style: appTextTheme.headlineSmall?.copyWith(
        color: AppColors.kMagentaBloom500,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
