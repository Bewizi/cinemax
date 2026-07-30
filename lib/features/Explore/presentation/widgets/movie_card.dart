import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/variables/app_radius.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    required this.title,
    this.image,
    this.genre,
    this.rating,
    this.duration,
    this.price,
    this.description,
    this.onTap,
    this.heroTag,
    super.key,
  });

  final String? image;
  final List<String>? genre;
  final String? rating;
  final String? duration;
  final double? price;
  final String title;
  final String? description;
  final VoidCallback? onTap;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: AppColors.kCarbonBlack,
          borderRadius: AppRadius.extraLargeRadius,
          border: Border.all(
            color: AppColors.kGunmental800,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: AppRadius.mediumLargeRadius,
                  child: Hero(
                    tag: heroTag ?? 'dash',
                    child: Image.network(
                      image!,
                      width: 120,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 8,
                  child: _buildAvailability(),
                ),
              ],
            ),
            16.horizontalSpacing,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    style: appTextTheme.titleMedium?.copyWith(
                      color: AppColors.kWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  8.verticalSpacing,
                  if (genre != null && genre!.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: genre!.map(_buildGenre).toList(),
                    ),
                  ],
                  12.verticalSpacing,
                  Row(
                    children: [
                      _buildRating(rating!),
                      24.horizontalSpacing,
                      _buildDuration(duration!),
                    ],
                  ),
                  12.verticalSpacing,
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          description!,
                          style: appTextTheme.titleMedium?.copyWith(
                            color: AppColors.kSliver300,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      16.horizontalSpacing,
                      _buildPrice('\$${price!.toStringAsFixed(2)}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
        style: appTextTheme.titleSmall?.copyWith(
          color: AppColors.kWildStrawberry300,
          fontWeight: FontWeight.w500,
        ),
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
          style: appTextTheme.titleSmall?.copyWith(
            color: AppColors.kWhite,
          ),
        ),
      ],
    );
  }

  Widget _buildDuration(String duration) {
    return Row(
      children: [
        SvgPicture.asset(AppSvgs.kclock),
        4.horizontalSpacing,
        AppText(
          duration,
          style: appTextTheme.titleSmall?.copyWith(
            color: AppColors.kWhite,
          ),
        ),
      ],
    );
  }

  Widget _buildPrice(String price) {
    return AppText(
      price,
      style: appTextTheme.titleMedium?.copyWith(
        color: AppColors.kMagentaBloom500,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    );
  }

  Widget _buildAvailability() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.kMagentaBloom500.withValues(alpha: 0.5),

        borderRadius: AppRadius.fullRadius,
      ),
      child: AppText(
        'Now Showing',
        style: appTextTheme.bodySmall?.copyWith(
          color: AppColors.kWhite,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
