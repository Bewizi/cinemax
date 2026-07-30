import 'package:cinemax/core/router/app_router.dart';
import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_button.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/variables/app_images.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:cinemax/features/Auth/bloc/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Getstarted extends StatefulWidget {
  const Getstarted({super.key});

  @override
  State<Getstarted> createState() => _GetstartedState();
}

class _GetstartedState extends State<Getstarted> {
  void _signUpWithGoogle() {
    context.read<AuthBloc>().add(const AuthGoogleSignInRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -200,
            left: 9,
            child: Image.asset(
              AppImages.kLogo,
              fit: BoxFit.cover,
              width: MediaQuery.sizeOf(context).width,
              color: AppColors.kMagentaBloom500.withValues(alpha: 0.1),

              colorBlendMode: BlendMode.srcIn,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 20, top: 200),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    AppText(
                      'Lets get your\nJourney Started',
                      style: appTextTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.kWhite,
                      ),
                    ),
                    24.verticalSpacing,
                    AppButtonOutlined(
                      icon: AppSvgs.kMail,
                      text: 'Sign up with email',
                      onPressed: () => SignUpRoute().go(context),
                    ),
                    24.verticalSpacing,
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthGoogleSignInSuccess) {
                          context.go('/home');
                        }

                        if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return AppButtonOutlined(
                          icon: AppSvgs.kGoogle,
                          text: state is AuthLoading
                              ? 'Signing in...'
                              : 'Sign up with Google',
                          onPressed: state is AuthLoading
                              ? () {}
                              : _signUpWithGoogle,
                        );
                      },
                    ),
                    24.verticalSpacing,
                    AppButtonOutlined(
                      icon: AppSvgs.kApple,
                      text: 'Sign up with Apple',
                      onPressed: () {},
                    ),
                    24.verticalSpacing,
                    AppButtonOutlined(
                      icon: AppSvgs.kFacebook,
                      text: 'Sign up with facebook',
                      onPressed: () {},
                    ),

                    64.verticalSpacing,
                    AppButtonElevated(
                      text: 'Sign Up',
                      onPressed: () => SignUpRoute().go(context),
                    ),

                    24.verticalSpacing,

                    Center(
                      child: AppRichText(
                        style: appTextTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        spans: [
                          TextSpan(
                            text: 'already have an account? ',
                            style: appTextTheme.titleMedium?.copyWith(
                              color: AppColors.kCharcoal700,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => LoginRoute().go(context),
                            text: ' Log in',
                            style: appTextTheme.titleMedium?.copyWith(
                              color: AppColors.kMagentaBloom500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
