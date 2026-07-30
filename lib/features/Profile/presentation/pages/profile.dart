import 'package:cinemax/core/router/app_router.dart';
import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/ui/components/app_text.dart';
import 'package:cinemax/core/ui/extensions/app_spacing_extension.dart';
import 'package:cinemax/core/ui/layouts/app_scaffold.dart';
import 'package:cinemax/core/variables/app_radius.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:cinemax/features/Auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, String>> account = [
    {'leadingIcon': AppSvgs.kProfile, 'text': 'Member'},
    {'leadingIcon': AppSvgs.kLock, 'text': 'Change Password'},
  ];

  List<Map<String, String>> general = [
    {'leadingIcon': AppSvgs.kSettings, 'text': 'Settings'},
    {'leadingIcon': AppSvgs.kHeart, 'text': 'Favorites'},
    {'leadingIcon': AppSvgs.kHelpCircle, 'text': 'Help & Support'},
    {'leadingIcon': AppSvgs.kLogout, 'text': 'Log Out'},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          LoginRoute().go(context);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state is AuthAuthenticated ? state.user : null;
          final fullName = user == null
              ? 'Guest'
              : '${user.firstname} ${user.lastname}';
          final email = user?.email ?? '';

          return AppScaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.kCarbonBlack,
                      borderRadius: AppRadius.extraLargeRadius,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppColors.kWhite,
                        ),
                        16.horizontalSpacing,
                        Column(
                          crossAxisAlignment: .start,
                          mainAxisAlignment: .center,
                          children: [
                            AppText(
                              fullName,
                              style: appTextTheme.titleMedium?.copyWith(
                                color: AppColors.kWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            4.verticalSpacing,
                            AppText(
                              email,
                              style: appTextTheme.titleMedium?.copyWith(
                                color: AppColors.kSliver300,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  24.verticalSpacing,
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.kCarbonBlack,
                      borderRadius: AppRadius.extraLargeRadius,
                    ),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        AppText(
                          'Account',
                          style: appTextTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kWhite,
                          ),
                        ),
                        16.verticalSpacing,
                        SizedBox(
                          height: 132,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final acct = account[index];
                              return _buildProfileContent(
                                acct['leadingIcon'],
                                acct['text'],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                8.verticalSpacing,
                            itemCount: account.length,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // general settings
                  24.verticalSpacing,
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.kCarbonBlack,
                      borderRadius: AppRadius.extraLargeRadius,
                    ),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        AppText(
                          'General',
                          style: appTextTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kWhite,
                          ),
                        ),
                        16.verticalSpacing,
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.28,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final gen = general[index];
                              return _buildProfileContent(
                                gen['leadingIcon'],
                                gen['text'],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                8.verticalSpacing,
                            itemCount: general.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileContent(
    String? leadingIcon,
    String? text,
  ) {
    final iconPath = leadingIcon ?? AppSvgs.kProfile;
    final label = text ?? '';

    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.kCharcoal700,
            borderRadius: AppRadius.fullRadius,
          ),
          child: SvgPicture.asset(
            iconPath,
            colorFilter: const ColorFilter.mode(
              AppColors.kWhite,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 24,
          ),
        ),
        title: AppText(
          label,
          style: appTextTheme.titleMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.kWhite,
          ),
        ),
        trailing: SvgPicture.asset(AppSvgs.kChevronRight),
        onTap: () {
          if (label == 'Log Out') {
            context.read<AuthBloc>().add(AuthLogoutRequested());
          }
        },
      ),
    );
  }
}
