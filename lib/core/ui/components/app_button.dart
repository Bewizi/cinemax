import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/variables/app_radius.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButtonElevated extends StatelessWidget {
  const AppButtonElevated({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    super.key,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final effectiveEnabled = enabled && !isLoading;

    return ElevatedButton(
      onPressed: effectiveEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kMagentaBloom500,
        disabledBackgroundColor: AppColors.kMagentaBloom500.withValues(
          alpha: 0.35,
        ),
        disabledForegroundColor: AppColors.kWhite.withValues(alpha: 0.7),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.extraLargeRadius,
        ),
        minimumSize: const Size(double.infinity, 56),
      ),
      child: isLoading
          ? const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.kWhite),
                strokeWidth: 2,
              ),
            )
          : AppText(
              text,
              style: appTextTheme.titleMedium?.copyWith(
                color: AppColors.kWhite,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
    );
  }
}

class AppButtonOutlined extends StatelessWidget {
  const AppButtonOutlined({
    required this.text,
    required this.onPressed,

    super.key,
    this.icon,
  });

  final String text;
  final VoidCallback onPressed;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.kShadowGrey800,
        side: const BorderSide(color: AppColors.kGunmental800, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.extraLargeRadius,
        ),
        foregroundColor: AppColors.kWhite,
        minimumSize: Size(MediaQuery.sizeOf(context).width, 56),
      ),
      child: Row(
        mainAxisAlignment: .center,
        children: [
          if (icon != null) ...[
            SvgPicture.asset(
              icon!,
              width: 24,
              height: 24,
            ),
            8.horizontalSpacing,
          ],
          AppText(
            text,
            style: appTextTheme.titleMedium?.copyWith(
              color: AppColors.kWhite,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
