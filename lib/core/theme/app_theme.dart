import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kCarbonBlack900,
    appBarTheme: const AppBarThemeData(
      backgroundColor: AppColors.kCarbonBlack900,
      elevation: 0,
    ),
    useMaterial3: true,
    textTheme: appTextTheme,
    colorScheme: const ColorScheme.light(
      primary: AppColors.kMagentaBloom500,
      secondary: AppColors.kCarbonBlack900,
      onSecondary: AppColors.kGunmental800,
      onSurface: AppColors.kShadowGrey800,
      error: AppColors.kDarkAmaranth700,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kCarbonBlack900,
    useMaterial3: true,
    textTheme: appTextTheme,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.kMagentaBloom500,
      secondary: AppColors.kCarbonBlack900,
      onSecondary: AppColors.kGunmental800,
      onSurface: AppColors.kShadowGrey800,
      error: AppColors.kDarkAmaranth700,
    ),
  );
}
