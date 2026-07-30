import 'package:cinemax/core/router/app_router.dart';
import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_button.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/components/app_textfield.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_images.dart';
import 'package:cinemax/core/variables/app_radius.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<Map<String, dynamic>> cinemas = [
    {
      'name': 'iMax Cinemas',
      'location': '456 Oak Avenue, Midtown',
      'image': AppImages.kImax,
      'distance': '3.8 km away',
    },
    {
      'name': 'Film House Cinemas',
      'location': '789 Elm Street, Downtown',
      'image': AppImages.kFilmHouse,
      'distance': '2.5 km away',
    },
    {
      'name': 'StartLight Cineplex',
      'location': '789 Elm Street, Downtown',
      'image': AppImages.kStartLight,
      'distance': '2.5 km away',
    },
    {
      'name': 'Silverbird Cinemas',
      'location': '789 Elm Street, Downtown',
      'image': AppImages.kSliverBird,
      'distance': '2.5 km away',
    },
    {
      'name': 'Genesis Cinemas',
      'location': '789 Elm Street, Downtown',
      'image': AppImages.kGenesis,
      'distance': '2.5 km away',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        centerTitle: true,
        title: AppText(
          'Nearby Cinemas you',
          style: appTextTheme.titleMedium?.copyWith(
            color: AppColors.kWhite,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: SearchTextField(
                    hintText: 'Search cinemas or locations......',
                    prefixIcon: SvgPicture.asset(
                      AppSvgs.kSearch,
                    ),
                    prefixIconSize: 24,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 18,
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.only(
                        right: 12,
                        top: 5,
                        bottom: 5,
                      ),
                      width: 14,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.kMagentaBloom500,
                        borderRadius: AppRadius.mediumRadius,
                      ),
                      child: SvgPicture.asset(
                        AppSvgs.kMapPin,
                        width: 12,
                        height: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            16.verticalSpacing,
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.7,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final cinema = cinemas[index];
                    return _buildWhereMovieIsShown(
                      cinema['location']! as String,
                      cinema['image']! as String,
                      cinema['distance']! as String,
                      cinema['name']! as String,
                    );
                  },
                  separatorBuilder: (context, index) => 16.verticalSpacing,
                  itemCount: cinemas.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhereMovieIsShown(
    String location,
    String image,
    String distance,
    String name,
  ) {
    return Container(
      width: MediaQuery.sizeOf(context).width,

      decoration: BoxDecoration(
        color: AppColors.kCarbonBlack,
        borderRadius: AppRadius.largeRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: AppRadius.largeCorner,
                  topRight: AppRadius.largeCorner,
                ),
                child: Image.asset(
                  image,
                  width: MediaQuery.sizeOf(context).width,
                  // height: MediaQuery.sizeOf(context).height * 0.125,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.kBlack.withValues(alpha: 0.45),
                    borderRadius: AppRadius.fullRadius,
                    border: Border.all(
                      width: 2,
                      color: AppColors.kBlack.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppSvgs.kMapPin,
                      ),
                      8.horizontalSpacing,
                      AppText(
                        distance,
                        style: appTextTheme.titleMedium?.copyWith(
                          color: AppColors.kWhite,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          16.verticalSpacing,
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  name,
                  style: appTextTheme.titleMedium?.copyWith(
                    color: AppColors.kWhite,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                8.verticalSpacing,
                AppText(
                  location,
                  style: appTextTheme.titleMedium?.copyWith(
                    color: AppColors.kSliver300,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                24.verticalSpacing,
                AppButtonElevated(
                  text: 'View Movies',
                  onPressed: () async {
                    await const NowShowingRoute().push<void>(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
