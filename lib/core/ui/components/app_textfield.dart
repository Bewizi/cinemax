import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/variables/app_radius.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.controller,
    this.hintText,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.hintTextColor,
    this.prefixIconSize,
    this.validator,
    super.key,
  });

  final TextEditingController? controller;
  final String? hintText;
  final Color? fillColor;
  final Color? hintTextColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? prefixIconSize;
  final String? Function(String?)? validator;

  Widget _buildTextField(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: appTextTheme.bodyMedium?.copyWith(
        color: AppColors.kWhite,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: AppRadius.mediumLargeRadius,
          borderSide: const BorderSide(
            color: AppColors.kGunmental800,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mediumLargeRadius,
          borderSide: const BorderSide(
            color: AppColors.kGunmental800,
          ),
        ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: hintTextColor ?? AppColors.kCharcoal700.withValues(alpha: 0.5),
        ),
        filled: true,
        fillColor: fillColor ?? AppColors.kShadowGrey800,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        prefixIcon: prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 12),
                child: SizedBox(
                  width: prefixIconSize ?? 20,
                  height: prefixIconSize ?? 20,
                  child: Center(child: prefixIcon),
                ),
              ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 48,
          minHeight: 48,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField(context),
      ],
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    this.controller,
    this.hintText,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.hintTextColor,
    this.prefixIconSize,
    this.validator,
    this.contentPadding,
    super.key,
  });

  final TextEditingController? controller;
  final String? hintText;
  final Color? fillColor;
  final Color? hintTextColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? prefixIconSize;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validator;

  Widget _buildTextField(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: appTextTheme.bodyMedium?.copyWith(
        color: AppColors.kWhite,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: AppRadius.extraLargeRadius,
          borderSide: const BorderSide(color: AppColors.kCharcoal700, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.extraLargeRadius,
          borderSide: const BorderSide(color: AppColors.kCharcoal700, width: 2),
        ),
        hintText: hintText,
        hintStyle: appTextTheme.titleMedium?.copyWith(
          color: hintTextColor ?? AppColors.kCharcoal700,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: fillColor ?? AppColors.kShadowGrey800,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 11,
            ),
        prefixIcon: prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 12),
                child: SizedBox(
                  width: prefixIconSize ?? 20,
                  height: prefixIconSize ?? 20,
                  child: Center(child: prefixIcon),
                ),
              ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 48,
          minHeight: 48,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTextField(context);
  }
}

class AddNewCardTextField extends StatelessWidget {
  const AddNewCardTextField({
    this.controller,
    this.hintText,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.hintTextColor,
    this.prefixIconSize,
    this.validator,
    this.contentPadding,
    this.showTitle = false,
    this.title,
    super.key,
  });

  final TextEditingController? controller;
  final String? hintText;
  final Color? fillColor;
  final Color? hintTextColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? prefixIconSize;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validator;
  final bool showTitle;
  final String? title;

  Widget _buildTextField(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: appTextTheme.bodyMedium?.copyWith(
        color: AppColors.kWhite,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: AppRadius.extraLargeRadius,
          borderSide: const BorderSide(color: AppColors.kCharcoal700, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.extraLargeRadius,
          borderSide: const BorderSide(color: AppColors.kCharcoal700, width: 2),
        ),
        hintText: hintText,
        hintStyle: appTextTheme.titleMedium?.copyWith(
          color: hintTextColor ?? AppColors.kCharcoal700,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: fillColor ?? AppColors.kShadowGrey800,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 11,
            ),
        prefixIcon: prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 12),
                child: SizedBox(
                  width: prefixIconSize ?? 20,
                  height: prefixIconSize ?? 20,
                  child: Center(child: prefixIcon),
                ),
              ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 48,
          minHeight: 48,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        if (showTitle && title != null) ...[
          AppText(
            title!,
            style: appTextTheme.titleMedium?.copyWith(
              color: AppColors.kWhite,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ],
        16.verticalSpacing,
        _buildTextField(context),
      ],
    );
  }
}
