import 'package:cinemax/core/router/app_router.dart';
import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_button.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/components/app_textfield.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/variables/app_images.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:cinemax/features/Auth/bloc/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthLoginRequested(
          email: _email.text,
          password: _password.text,
        ),
      );
    }
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

          Positioned(
            top: 100,
            left: 180,
            child: AppText(
              'Log in',
              style: appTextTheme.titleMedium?.copyWith(
                color: AppColors.kWhite,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),

          SafeArea(
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 20, top: 200),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthLoginSuccess) {
                          if (mounted) {
                            context.go('/home');
                          }
                        }
                      },
                      builder: (context, state) {
                        return Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              AppTextField(
                                controller: _email,
                                hintText: 'Email',
                                prefixIconSize: 24,
                                prefixIcon: SvgPicture.asset(
                                  AppSvgs.kMail,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.kCharcoal700,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              24.verticalSpacing,

                              Column(
                                crossAxisAlignment: .start,
                                children: [
                                  AppTextField(
                                    controller: _password,
                                    hintText: 'Password',
                                    prefixIconSize: 24,
                                    prefixIcon: SvgPicture.asset(
                                      AppSvgs.kLock,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.kCharcoal700,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  24.verticalSpacing,
                                  _forgotPassword(),
                                ],
                              ),
                              if (state is AuthFailure) ...[
                                24.verticalSpacing,
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.kDarkAmaranth700
                                        .withValues(
                                          alpha: 0.12,
                                        ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.kDarkAmaranth700
                                          .withValues(alpha: 0.4),
                                    ),
                                  ),
                                  child: AppText(
                                    state.message,
                                    style: appTextTheme.bodyMedium?.copyWith(
                                      color: AppColors.kMagentaBloom500,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                              24.verticalSpacing,
                            ],
                          ),
                        );
                      },
                    ),

                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return AppButtonElevated(
                                text: 'Log in',
                                onPressed: _login,
                                isLoading: state is AuthLoading,
                              );
                            },
                          ),
                          24.verticalSpacing,

                          AppRichText(
                            textAlign: TextAlign.center,
                            style: appTextTheme.titleMedium?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            spans: [
                              TextSpan(
                                text: 'Don’t have an account? ',
                                style: appTextTheme.titleMedium?.copyWith(
                                  color: AppColors.kCharcoal700,
                                ),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => SignUpRoute().go(context),
                                text: 'Sign Up',
                                style: appTextTheme.titleMedium?.copyWith(
                                  color: AppColors.kMagentaBloom500,
                                ),
                              ),
                            ],
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

  Widget _forgotPassword() {
    return Align(
      alignment: Alignment.bottomRight,
      child: AppText(
        'Forget Password?',
        style: appTextTheme.titleMedium?.copyWith(
          fontSize: 18,
          color: AppColors.kCharcoal700,
        ),
      ),
    );
  }
}
