import 'package:cinemax/core/router/app_router.dart';
import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_button.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_images.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  int _current = 0;

  final List<Map<String, String>> pageView = [
    {
      'imageAsset': AppImages.kOnboarding1,
      'mainText': 'Find Your Scene',
      'subText':
          'From Hot series to the latest blockbusters,\n'
          'find exactly what you’re looking for.',
    },
    {
      'imageAsset': AppImages.kOnboarding2,
      'mainText': 'Feel the moments',
      'subText':
          'Explore a journey that starts the second\n'
          'you walk through the doors.',
    },
    {
      'imageAsset': AppImages.kOnboarding3,
      'mainText': 'Create Memories',
      'subText':
          'Movie nights are better together.\n'
          'Easily book and share tickets with friends ',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final page = _controller.page?.round() ?? 0;
      if (page != _current) {
        setState(() => _current = page);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.kCarbonBlack900,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pageView.length,
              itemBuilder: (context, index) {
                final pageViews = pageView[index];
                return _buildPage(
                  pageViews['imageAsset']!,
                  pageViews['mainText']!,
                  pageViews['subText']!,
                );
              },
            ),
          ),

          _buildIndicator(),
          24.verticalSpacing,
          AppButtonElevated(
            text: 'Continue',
            onPressed: () => GetStartedScreenRoute().go(context),
          ),

          16.verticalSpacing,
          AppButtonOutlined(
            text: 'Already have an account?',
            onPressed: () => LoginRoute().go(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String imageAsset, String mainText, String subText) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Image.asset(
          imageAsset,
          fit: BoxFit.cover,
        ),
        40.verticalSpacing,
        AppText(
          mainText,
          style: appTextTheme.displaySmall?.copyWith(
            color: AppColors.kWhite,
            fontWeight: FontWeight.w700,
          ),
        ),
        24.verticalSpacing,
        AppText(
          subText,

          style: appTextTheme.titleMedium?.copyWith(
            color: AppColors.kAlabasterGrey100,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator() {
    return Row(
      children: List.generate(3, (i) {
        final isActive = i == _current;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: isActive ? 22 : 22,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.kMagentaBloom500
                : AppColors.kMagentaBloom500.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}
