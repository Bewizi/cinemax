import 'package:cinemax/core/variables/app_fontsize.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const TextTheme _baseTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: AppFontSize.displayLarge,
    fontWeight: FontWeight.w400,
  ),
  displayMedium: TextStyle(
    fontSize: AppFontSize.displayMedium,
    fontWeight: FontWeight.w400,
  ),
  displaySmall: TextStyle(
    fontSize: AppFontSize.displaySmall,
    fontWeight: FontWeight.w400,
  ),

  headlineLarge: TextStyle(
    fontSize: AppFontSize.headlineLarge,
    fontWeight: FontWeight.w400,
  ),
  headlineMedium: TextStyle(
    fontSize: AppFontSize.headlineMedium,
    fontWeight: FontWeight.w400,
  ),
  headlineSmall: TextStyle(
    fontSize: AppFontSize.headlineSmall,
    fontWeight: FontWeight.w400,
  ),

  titleLarge: TextStyle(
    fontSize: AppFontSize.titleLarge,
    fontWeight: FontWeight.w400,
  ),
  titleMedium: TextStyle(
    fontSize: AppFontSize.titleMedium,
    fontWeight: FontWeight.w400,
  ),
  titleSmall: TextStyle(
    fontSize: AppFontSize.titleSmall,
    fontWeight: FontWeight.w400,
  ),

  labelLarge: TextStyle(
    fontSize: AppFontSize.labelLarge,
    fontWeight: FontWeight.w400,
  ),
  labelMedium: TextStyle(
    fontSize: AppFontSize.labelMedium,
    fontWeight: FontWeight.w400,
  ),
  labelSmall: TextStyle(
    fontSize: AppFontSize.labelSmall,
    fontWeight: FontWeight.w400,
  ),

  bodyLarge: TextStyle(
    fontSize: AppFontSize.bodyLarge,
    fontWeight: FontWeight.w400,
  ),
  bodyMedium: TextStyle(
    fontSize: AppFontSize.bodyMedium,
    fontWeight: FontWeight.w400,
  ),
  bodySmall: TextStyle(
    fontSize: AppFontSize.bodySmall,
    fontWeight: FontWeight.w400,
  ),
);

final TextTheme appTextTheme = GoogleFonts.instrumentSansTextTheme(
  _baseTextTheme,
);
