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

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _firstname.addListener(_updateFormValidity);
    _lastname.addListener(_updateFormValidity);
    _email.addListener(_updateFormValidity);
    _password.addListener(_updateFormValidity);
    _confirmpassword.addListener(_updateFormValidity);
  }

  void _updateFormValidity() {
    final isFormFilled =
        _firstname.text.isNotEmpty &&
        _lastname.text.isNotEmpty &&
        _email.text.isNotEmpty &&
        _password.text.isNotEmpty &&
        _confirmpassword.text.isNotEmpty;
    final isEmailFilled = _email.text.contains('@');
    final isPasswordValid = _password.text.length >= 8;
    final doPasswordsMatch = _confirmpassword.text == _password.text;

    final isValid =
        isFormFilled && isEmailFilled && isPasswordValid && doPasswordsMatch;
    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  void _signUp() {
    if (_formkey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthSignUpRequested(
          params: SignupParams(
            firstname: _firstname.text,
            lastname: _lastname.text,
            email: _email.text,
            password: _password.text,
            confirmPassword: _confirmpassword.text,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _firstname.removeListener(_updateFormValidity);
    _lastname.removeListener(_updateFormValidity);
    _email.removeListener(_updateFormValidity);
    _password.removeListener(_updateFormValidity);
    _confirmpassword.removeListener(_updateFormValidity);

    _firstname.dispose();
    _lastname.dispose();
    _email.dispose();
    _password.dispose();
    _confirmpassword.dispose();
    super.dispose();
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
              'Sign Up',
              style: appTextTheme.titleMedium?.copyWith(
                color: AppColors.kWhite,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),

          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 20, top: 200),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) async {
                        if (state is AuthSignUpSuccess) {
                          await VerifyOtpRoute(
                            email: state.email,
                          ).push<void>(context);
                        }
                      },
                      builder: (context, state) {
                        return Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              AppTextField(
                                controller: _firstname,
                                hintText: 'First Name',
                                prefixIconSize: 24,
                                prefixIcon: SvgPicture.asset(
                                  AppSvgs.kProfile,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Firstname is required';
                                  }
                                  return null;
                                },
                              ),
                              24.verticalSpacing,
                              AppTextField(
                                controller: _lastname,
                                hintText: 'Last Name',
                                prefixIconSize: 24,
                                prefixIcon: SvgPicture.asset(
                                  AppSvgs.kProfile,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Lastname is required';
                                  }
                                  return null;
                                },
                              ),
                              24.verticalSpacing,
            
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
                                validator: (value) {
                                  if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                  ).hasMatch(value!)) {
                                    return 'Invalid Email Address';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please Include @ in Email Address';
                                  }
            
                                  if (value.isEmpty) {
                                    return 'Email Address is required';
                                  }
                                  return null;
                                },
                              ),
                              24.verticalSpacing,
            
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
                                validator: (value) {
                                  if (value!.length < 8) {
                                    return 'Password must be at least '
                                        '8 characters';
                                  }
            
                                  if (value.isEmpty) {
                                    return 'Password is required';
                                  }
                                  return null;
                                },
                              ),
                              24.verticalSpacing,
            
                              AppTextField(
                                controller: _confirmpassword,
                                hintText: 'Confirm Password',
                                prefixIconSize: 24,
                                prefixIcon: SvgPicture.asset(
                                  AppSvgs.kLock,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.kCharcoal700,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Confirm Password is required';
                                  }
                                  if (value != _password.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              if (state is AuthFailure)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
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
                                ),
                            ],
                          ),
                        );
                      },
                    ),
            
                    64.verticalSpacing,
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return AppButtonElevated(
                          text: 'Sign Up',
                          onPressed: _signUp,
                          isLoading: state is AuthLoading,
                          enabled: _isFormValid,
                        );
                      },
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
