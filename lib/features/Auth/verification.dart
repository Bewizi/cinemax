import 'package:cinemax/core/router/app_router.dart';
import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_button.dart';
import 'package:cinemax/core/ui/components/app_text.dart';

import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/variables/app_images.dart';
import 'package:cinemax/core/variables/app_radius.dart';
import 'package:cinemax/core/variables/app_svgs.dart';

import 'package:cinemax/core/variables/colors.dart';
import 'package:cinemax/features/Auth/bloc/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:pinput/pinput.dart';

class Verification extends StatefulWidget {
  const Verification({
    required this.email,
    super.key,
  });

  final String email;

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  late String _displayEmail = _getInitialEmail();

  late final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    margin: const EdgeInsets.only(right: 10),
    textStyle: appTextTheme.titleMedium?.copyWith(
      fontSize: 18,
      color: AppColors.kWhite,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.kWhite),
      borderRadius: AppRadius.mediumLargeRadius,
    ),
  );

  late final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(
      color: AppColors.kMagentaBloom500.withValues(alpha: 0.25),
    ),
    borderRadius: AppRadius.mediumLargeRadius,
  );

  late final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(
      color: AppColors.kShadowGrey800,
    ),
  );

  String _getInitialEmail() {
    final currentState = context.read<AuthBloc>().state;
    if (currentState is AuthSignUpSuccess && currentState.email.isNotEmpty) {
      return currentState.email;
    }

    return widget.email;
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignUpSuccess && state.email.isNotEmpty) {
          setState(() {
            _displayEmail = state.email;
          });
        }
      },
      child: Scaffold(
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
              left: 24,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: SvgPicture.asset(
                      AppSvgs.kChevronLeft,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  136.horizontalSpacing,
                  AppText(
                    'Verifying',
                    style: appTextTheme.titleMedium?.copyWith(
                      color: AppColors.kWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            SafeArea(
              child: SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 20, top: 200),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Align(
                        child: AppText(
                          'Enter your 4 Digit Code',
                          style: appTextTheme.titleMedium?.copyWith(
                            color: AppColors.kWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      8.verticalSpacing,
                      Align(
                        child: BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {},
                          child: AppText(
                            'Enter your OTP code sent to your email '
                            '$_displayEmail',
                            style: appTextTheme.titleMedium?.copyWith(
                              color: AppColors.kCharcoal700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      40.verticalSpacing,
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthOtpVerificationSuccess) {
                            AccountSuccessRoute().go(context);
                          }
                        },
                        builder: (context, state) {
                          return Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Center(
                                  child: Pinput(
                                    controller: _otpController,
                                    defaultPinTheme: defaultPinTheme,
                                    focusedPinTheme: focusedPinTheme,
                                    submittedPinTheme: submittedPinTheme,
                                    validator: (s) {
                                      if (s == null || s.length < 4) {
                                        return 'Enter 4 digit number';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
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
                            AppButtonElevated(
                              text: 'Verify',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    AuthVerifyOtpRequested(
                                      email: widget.email,
                                      otp: _otpController.text,
                                    ),
                                  );
                                }
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
                                  text: 'Didn’t Receive a code?  ',
                                  style: appTextTheme.titleMedium?.copyWith(
                                    color: AppColors.kCharcoal700,
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.read<AuthBloc>().add(
                                        AuthResendOtpRequested(
                                          email: widget.email,
                                        ),
                                      );
                                    },
                                  text: ' Resend',
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
      ),
    );
  }
}
