import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/variables/app_radius.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> catergories = ['All', 'Action', 'Sci-Fi', 'Romance', 'Horror'];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            AppText(
              'Categories',
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(catergories.length, (index) {
              final isLast = index == catergories.length - 1;
              return Padding(
                padding: EdgeInsets.only(right: isLast ? 0 : 16),
                child: _buildMovieCategorie(catergories[index], index),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieCategorie(String text, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: AppRadius.mediumLargeRadius,
          color: isSelected
              ? AppColors.kDarkAmaranth700.withValues(alpha: 0.25)
              : AppColors.kShadowGrey800,
          border: Border.all(
            color: isSelected
                ? AppColors.kMagentaBloom500.withValues(alpha: 0.25)
                : AppColors.kCharcoal700,
          ),
        ),
        child: AppText(
          text,
          style: appTextTheme.titleMedium?.copyWith(
            color: isSelected
                ? AppColors.kMagentaBloom500
                : AppColors.kCharcoal700,
          ),
        ),
      ),
    );
  }
}
