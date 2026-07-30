import 'package:cinemax/core/router/app_router.dart';
import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:cinemax/features/Explore/bloc/explore_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatestMovies extends StatefulWidget {
  const LatestMovies({super.key});

  @override
  State<LatestMovies> createState() => _LatestMoviesState();
}

class _LatestMoviesState extends State<LatestMovies> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              'Latest Movies',
              style: appTextTheme.titleMedium?.copyWith(
                color: AppColors.kWhite,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            AppText(
              'See all',
              style: appTextTheme.titleMedium?.copyWith(
                color: AppColors.kMagentaBloom500,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        16.verticalSpacing,

        BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            if (state.status == ExploreStatus.success) {
              final movies = state.movies
                  .where(
                    (movie) => movie.tags?.contains('latest_movie') ?? false,
                  )
                  .toList();

              if (movies.isEmpty) return const SizedBox.shrink();

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(movies.length, (index) {
                    final movie = movies[index];
                    final isLast = index == movies.length - 1;
                    return Padding(
                      padding: EdgeInsets.only(right: isLast ? 0 : 16),
                      child: GestureDetector(
                        onTap: () async {
                          await MovieDetailsRoute(
                            id: movie.id!,
                          ).push<void>(context);
                        },
                        child: _buildMovie(movie.image!),
                      ),
                    );
                  }),
                ),
              );
            }
            return const SizedBox.shrink(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.kMagentaBloom500,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMovie(String image) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
