import 'dart:async';

import 'package:cinemax/core/ui/components/app_textfield.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_images.dart';
import 'package:cinemax/core/variables/app_radius.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:cinemax/features/Explore/bloc/explore_bloc.dart';
import 'package:cinemax/features/Home/presentation/widgets/categories.dart';
import 'package:cinemax/features/Home/presentation/widgets/latest_movies.dart';
import 'package:cinemax/features/Home/presentation/widgets/top_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;

  late final PageController _pageController;
  Timer? _autoScrollTimer;

  List<String> movies = [
    AppImages.kMaxresdefault,
    AppImages.kWonderWoman,
    AppImages.kFrame5277_1,
    AppImages.kFrame5277_2,
    AppImages.kFrame5277_3,
    AppImages.kFrame5277_4,
    AppImages.kFrame5277_5,
    AppImages.kFrame5277_6,
    AppImages.kFrame5277_7,
  ];

  @override
  void initState() {
    super.initState();
    context.read<ExploreBloc>().add(const GetMovies());
    _pageController = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (
      timer,
    ) async {
      if (!_pageController.hasClients) return;

      final isLastPage = _current == movies.length - 1;
      final nextPage = isLastPage ? 0 : _current + 1;

      await _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: SearchTextField(
                    hintText: 'Search for movies',
                    prefixIcon: SvgPicture.asset(
                      AppSvgs.kSearch,
                    ),
                    prefixIconSize: 24,
                  ),
                ),
                16.horizontalSpacing,
                Container(
                  width: 44,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.kMagentaBloom500,
                    borderRadius: AppRadius.mediumRadius,
                  ),
                  child: SvgPicture.asset(
                    AppSvgs.kBell,
                  ),
                ),
              ],
            ),
            24.verticalSpacing,
            Column(
              mainAxisAlignment: .center,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).width * 0.5,
                  child: _buildCarouselMovie(),
                ),
                8.verticalSpacing,
                _buildIndicator(),
              ],
            ),

            16.verticalSpacing,
            // categories
            const Categories(),
            16.verticalSpacing,
            //   top movies
            const TopMovies(),

            16.verticalSpacing,
            const LatestMovies(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselMovie() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
      itemBuilder: (context, index) {
        final movieList = movies[index];
        return ClipRRect(
          borderRadius: AppRadius.largeRadius,
          child: Image.asset(
            movieList,
            width: MediaQuery.sizeOf(context).width,
          ),
        );
      },
      itemCount: movies.length,
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: .center,
      children: List.generate(movies.length, (i) {
        final isActive = i == _current;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 8 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.kWhite
                : AppColors.kWhite.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}
