import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_button.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessfulPayment extends StatelessWidget {
  const SuccessfulPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: AppButtonElevated(
            text: 'View Ticket',
            onPressed: () {},
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 124),
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset(AppSvgs.kAuthSuccess),
              24.verticalSpacing,
              AppText(
                'Ticket Successful',
                style: appTextTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.kWhite,
                ),
              ),
              8.verticalSpacing,
              AppText(
                'Payment Completed Successfully\n Enjoy your cinema Experience',
                style: appTextTheme.titleMedium?.copyWith(
                  color: AppColors.kWhite,
                ),
                textAlign: TextAlign.center,
              ),
              // 64.verticalSpacing,
              // AppButtonElevated(
              //   text: 'View Ticket',
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
