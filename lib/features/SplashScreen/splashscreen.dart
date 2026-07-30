import 'package:cinemax/core/router/app_router.dart';
import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_images.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:cinemax/features/Auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 5000), () {
      if (!mounted) return;

      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        const HomeRoute().go(context);
      } else {
        OnboardingScreenRoute().go(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Image.asset(
              AppImages.kLogo,
              fit: BoxFit.cover,
              width: 60,
              height: 60,
            ),
            16.verticalSpacing,
            AppText(
              'CineMax',
              style: appTextTheme.displaySmall?.copyWith(
                color: AppColors.kWhite,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
