import 'package:cinemax/core/router/app_router.dart';
import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:cinemax/features/Explore/bloc/explore_bloc.dart';
import 'package:cinemax/features/Explore/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NowShowingPage extends StatefulWidget {
  const NowShowingPage({super.key});

  @override
  State<NowShowingPage> createState() => _NowShowingPageState();
}

class _NowShowingPageState extends State<NowShowingPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(AppSvgs.kChevronLeft),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: AppText(
          'Now Showing',
          style: appTextTheme.titleMedium?.copyWith(
            color: AppColors.kWhite,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: BlocBuilder<ExploreBloc, ExploreState>(
        builder: (context, state) {
          if (state.status == ExploreStatus.success) {
            final movies = state.movies;
            return ListView.separated(
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(
                  key: ValueKey(movie.id),
                  title: movie.title!,
                  image: movie.image,
                  genre: movie.genre,
                  rating: movie.rating,
                  duration: movie.movieDuration,
                  price: movie.price,
                  description: movie.description,
                  heroTag: movie.id,
                  onTap: () async {
                    await MovieDetailsRoute(id: movie.id!).push<void>(context);
                  },
                );
              },
              separatorBuilder: (context, index) => 16.verticalSpacing,
              itemCount: movies.length,
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
}
