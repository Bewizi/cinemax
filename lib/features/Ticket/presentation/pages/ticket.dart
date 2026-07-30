import 'package:cinemax/core/router/app_router.dart';
import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_button.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_radius.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        centerTitle: true,
        title: AppText(
          'My Tickets',
          style: appTextTheme.titleMedium?.copyWith(
            color: AppColors.kWhite,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 34),
            decoration: BoxDecoration(
              color: AppColors.kWildStrawberry300.withValues(alpha: 0.25),
              borderRadius: AppRadius.fullRadius,
            ),
            child: SvgPicture.asset(
              AppSvgs.kStar,
              width: 44,
              height: 44,
            ),
          ),
          32.verticalSpacing,
          AppText(
            'No Tickets Yet',
            style: appTextTheme.headlineSmall?.copyWith(
              color: AppColors.kWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.verticalSpacing,
          AppText(
            'Book your first movie ticket!',
            style: appTextTheme.titleMedium?.copyWith(
              color: AppColors.kSliver300,
              fontSize: 18,
            ),
          ),
          24.verticalSpacing,
          AppButtonElevated(
            text: 'Explore Cinemas',
            onPressed: () {
              const ExplorePageRoute().go(context);
            },
          ),
        ],
      ),
    );
  }
}
