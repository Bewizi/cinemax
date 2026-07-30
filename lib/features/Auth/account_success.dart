import 'package:cinemax/core/router/app_router.dart';
import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_button.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccountSuccess extends StatefulWidget {
  const AccountSuccess({super.key});

  @override
  State<AccountSuccess> createState() => _AccountSuccessState();
}

class _AccountSuccessState extends State<AccountSuccess> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppSvgs.kAuthSuccess),
            24.verticalSpacing,
            AppText(
              'Congratulations!',
              style: appTextTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.kWhite,
              ),
            ),
            8.verticalSpacing,
            AppText(
              'Your account has now been\n successfully created!',
              style: appTextTheme.titleMedium?.copyWith(
                color: AppColors.kWhite,
              ),
              textAlign: TextAlign.center,
            ),
            64.verticalSpacing,
            AppButtonElevated(
              text: 'Next',
              onPressed: () => const HomeRoute().go(context),
            ),
          ],
        ),
      ),
    );
  }
}
