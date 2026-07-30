import 'package:cinemax/core/data/di/injection.dart';
import 'package:cinemax/core/router/go_router_refresh_stream.dart';
import 'package:cinemax/core/theme/app_text_theme.dart';
import 'package:cinemax/core/variables/app_svgs.dart';
import 'package:cinemax/core/variables/colors.dart';
import 'package:cinemax/features/Auth/account_success.dart';
import 'package:cinemax/features/Auth/bloc/auth_bloc.dart';
import 'package:cinemax/features/Auth/login.dart';
import 'package:cinemax/features/Auth/signup.dart';
import 'package:cinemax/features/Auth/verification.dart';
import 'package:cinemax/features/Explore/presentation/pages/choose_seats.dart';
import 'package:cinemax/features/Explore/presentation/pages/explore.dart';
import 'package:cinemax/features/Explore/presentation/pages/movie_details_page.dart';
import 'package:cinemax/features/Explore/presentation/pages/now_showing_page.dart';
import 'package:cinemax/features/Explore/presentation/pages/payment/payment_checkout.dart';
import 'package:cinemax/features/Explore/presentation/pages/payment/payment_method.dart';
import 'package:cinemax/features/GetStarted/getstarted.dart';
import 'package:cinemax/features/Home/presentation/pages/home.dart';
import 'package:cinemax/features/OnboardingScreen/onboarding.dart';
import 'package:cinemax/features/Profile/presentation/pages/profile.dart';
import 'package:cinemax/features/SplashScreen/splashscreen.dart';
import 'package:cinemax/features/Ticket/presentation/pages/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

part 'app_router.g.dart';

final appRouter = GoRouter(
  routes: $appRoutes,
  initialLocation: SplashScreenRoute.path,
  refreshListenable: GoRouterRefreshStream(sl<AuthBloc>().stream),
  redirect: (context, state) {
    final authState = sl<AuthBloc>().state;
    final location = state.matchedLocation;

    const publicRoutes = {
      '/',
      '/onboarding',
      '/getstarted',
      '/signup',
      '/loginScreen',
      '/verifyOtp',
      '/accountsuccess',
    };

    if (authState is AuthInitial || authState is AuthLoading) {
      return null;
    }

    final isAunthenticated = authState is AuthAuthenticated;
    final isProtectedRoute = !publicRoutes.contains(location);

    if (isAunthenticated &&
        (location == '/' ||
            location == '/onboarding' ||
            location == '/getstarted' ||
            location == '/loginScreen' ||
            location == '/signup')) {
      return const HomeRoute().location;
    }

    if (!isAunthenticated && isProtectedRoute) {
      return LoginRoute().location;
    }

    return null;
  },
);

// entry point
@TypedGoRoute<SplashScreenRoute>(path: '/')
class SplashScreenRoute extends GoRouteData with $SplashScreenRoute {
  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Splashscreen();
}

// onboarding screen
@TypedGoRoute<OnboardingScreenRoute>(path: '/onboarding')
class OnboardingScreenRoute extends GoRouteData with $OnboardingScreenRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const Onboarding();
}

// getstarted screen
@TypedGoRoute<GetStartedScreenRoute>(path: '/getstarted')
class GetStartedScreenRoute extends GoRouteData with $GetStartedScreenRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const Getstarted();
}

// signup screen
@TypedGoRoute<SignUpRoute>(path: '/signup')
class SignUpRoute extends GoRouteData with $SignUpRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const Signup();
}

// login screen
@TypedGoRoute<LoginRoute>(path: '/loginScreen')
class LoginRoute extends GoRouteData with $LoginRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const Login();
}

// verify otp screen
@TypedGoRoute<VerifyOtpRoute>(path: '/verifyOtp')
class VerifyOtpRoute extends GoRouteData with $VerifyOtpRoute {
  const VerifyOtpRoute({
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context, GoRouterState state) => Verification(
    email: email,
  );
}

// account success screen
@TypedGoRoute<AccountSuccessRoute>(path: '/accountsuccess')
class AccountSuccessRoute extends GoRouteData with $AccountSuccessRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AccountSuccess();
}

// choose seats screen
@TypedGoRoute<ChooseSeatsRoute>(path: '/chooseSeats')
class ChooseSeatsRoute extends GoRouteData with $ChooseSeatsRoute {
  const ChooseSeatsRoute(
    //   {
    //   required this.id,
    // }
  );

  // final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChooseSeats();
}

// payment checkout screen
@TypedGoRoute<PaymentCheckoutRoute>(path: '/paymentCheckout')
class PaymentCheckoutRoute extends GoRouteData with $PaymentCheckoutRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PaymentCheckout();
}

// payment method screen
@TypedGoRoute<PaymentMethodRoute>(path: '/paymentMethod')
class PaymentMethodRoute extends GoRouteData with $PaymentMethodRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PaymentMethod();
}

//MAIN APP SHELL WITH BOTTOM NAV  (NESTED ROUTING)
class HomeBranchData extends StatefulShellBranchData {
  const HomeBranchData();
}

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

class ExploreBranchData extends StatefulShellBranchData {
  const ExploreBranchData();
}

class ExplorePageRoute extends GoRouteData with $ExplorePageRoute {
  const ExplorePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ExplorePage();
}

class NowShowingRoute extends GoRouteData with $NowShowingRoute {
  const NowShowingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NowShowingPage();
}

class MovieDetailsRoute extends GoRouteData with $MovieDetailsRoute {
  const MovieDetailsRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) => MovieDetailsPage(
    id: id,
  );
}

class TicketBranchData extends StatefulShellBranchData {
  const TicketBranchData();
}

class TicketRoute extends GoRouteData with $TicketRoute {
  const TicketRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const TicketPage();
}

class ProfileBranchData extends StatefulShellBranchData {
  const ProfileBranchData();
}

class ProfilePageRoute extends GoRouteData with $ProfilePageRoute {
  const ProfilePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfilePage();
}

@TypedStatefulShellRoute<AppShellRouteData>(
  branches: [
    TypedStatefulShellBranch<HomeBranchData>(
      routes: [TypedGoRoute<HomeRoute>(path: '/home')],
    ),
    TypedStatefulShellBranch<ExploreBranchData>(
      routes: [
        TypedGoRoute<ExplorePageRoute>(path: '/explore'),
        TypedGoRoute<NowShowingRoute>(path: '/nowShowing'),

        TypedGoRoute<MovieDetailsRoute>(path: '/movieDetails/:id'),
      ],
    ),
    TypedStatefulShellBranch<TicketBranchData>(
      routes: [TypedGoRoute<TicketRoute>(path: '/ticket')],
    ),

    TypedStatefulShellBranch<ProfileBranchData>(
      routes: [TypedGoRoute<ProfilePageRoute>(path: '/profile')],
    ),
  ],
)
class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ScaffoldWithBottomNavBar(navigationShell: navigationShell);
  }
}

class ScaffoldWithBottomNavBar extends StatelessWidget {
  const ScaffoldWithBottomNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(index),
        backgroundColor: AppColors.kShadowGrey800,
        indicatorColor: AppColors.kTransparent,

        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return appTextTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.kMagentaBloom500,
              );
            }
            return appTextTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.kCharcoal700,
            );
          },
        ),
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(AppSvgs.kHome),
            selectedIcon: SvgPicture.asset(
              AppSvgs.kHome,
              colorFilter: const ColorFilter.mode(
                AppColors.kMagentaBloom500,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AppSvgs.kExplore),
            selectedIcon: SvgPicture.asset(
              AppSvgs.kExplore,
              colorFilter: const ColorFilter.mode(
                AppColors.kMagentaBloom500,
                BlendMode.srcIn,
              ),
            ),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AppSvgs.kTicket),
            selectedIcon: SvgPicture.asset(
              AppSvgs.kTicket,
              colorFilter: const ColorFilter.mode(
                AppColors.kMagentaBloom500,
                BlendMode.srcIn,
              ),
            ),
            label: 'Ticket',
          ),

          NavigationDestination(
            icon: SvgPicture.asset(AppSvgs.kProfile),
            selectedIcon: SvgPicture.asset(
              AppSvgs.kProfile,
              colorFilter: const ColorFilter.mode(
                AppColors.kMagentaBloom500,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
