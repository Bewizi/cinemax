import 'package:cinemax/core/variables/app_spacing.dart';
import 'package:flutter/material.dart';

extension AppSpacingExtension on num {
  SizedBox get verticalSpacing => SizedBox(
    height: AppSpacing.validate(toDouble()),
  );
  SizedBox get horizontalSpacing => SizedBox(
    width: AppSpacing.validate(toDouble()),
  );
}
