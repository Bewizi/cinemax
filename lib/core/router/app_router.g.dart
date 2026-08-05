// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashScreenRoute,
  $onboardingScreenRoute,
  $getStartedScreenRoute,
  $signUpRoute,
  $loginRoute,
  $verifyOtpRoute,
  $accountSuccessRoute,
  $chooseSeatsRoute,
  $paymentCheckoutRoute,
  $paymentMethodRoute,
  $addCardRoute,
  $successfulPaymentRoute,
  $appShellRouteData,
];

RouteBase get $splashScreenRoute => GoRouteData.$route(
  path: '/',
  hasOverriddenOnExit: false,
  factory: $SplashScreenRoute._fromState,
);

mixin $SplashScreenRoute on GoRouteData {
  static SplashScreenRoute _fromState(GoRouterState state) =>
      SplashScreenRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingScreenRoute => GoRouteData.$route(
  path: '/onboarding',
  hasOverriddenOnExit: false,
  factory: $OnboardingScreenRoute._fromState,
);

mixin $OnboardingScreenRoute on GoRouteData {
  static OnboardingScreenRoute _fromState(GoRouterState state) =>
      OnboardingScreenRoute();

  @override
  String get location => GoRouteData.$location('/onboarding');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $getStartedScreenRoute => GoRouteData.$route(
  path: '/getstarted',
  hasOverriddenOnExit: false,
  factory: $GetStartedScreenRoute._fromState,
);

mixin $GetStartedScreenRoute on GoRouteData {
  static GetStartedScreenRoute _fromState(GoRouterState state) =>
      GetStartedScreenRoute();

  @override
  String get location => GoRouteData.$location('/getstarted');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signUpRoute => GoRouteData.$route(
  path: '/signup',
  hasOverriddenOnExit: false,
  factory: $SignUpRoute._fromState,
);

mixin $SignUpRoute on GoRouteData {
  static SignUpRoute _fromState(GoRouterState state) => SignUpRoute();

  @override
  String get location => GoRouteData.$location('/signup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
  path: '/loginScreen',
  hasOverriddenOnExit: false,
  factory: $LoginRoute._fromState,
);

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => LoginRoute();

  @override
  String get location => GoRouteData.$location('/loginScreen');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $verifyOtpRoute => GoRouteData.$route(
  path: '/verifyOtp',
  hasOverriddenOnExit: false,
  factory: $VerifyOtpRoute._fromState,
);

mixin $VerifyOtpRoute on GoRouteData {
  static VerifyOtpRoute _fromState(GoRouterState state) =>
      VerifyOtpRoute(email: state.uri.queryParameters['email']!);

  VerifyOtpRoute get _self => this as VerifyOtpRoute;

  @override
  String get location =>
      GoRouteData.$location('/verifyOtp', queryParams: {'email': _self.email});

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $accountSuccessRoute => GoRouteData.$route(
  path: '/accountsuccess',
  hasOverriddenOnExit: false,
  factory: $AccountSuccessRoute._fromState,
);

mixin $AccountSuccessRoute on GoRouteData {
  static AccountSuccessRoute _fromState(GoRouterState state) =>
      AccountSuccessRoute();

  @override
  String get location => GoRouteData.$location('/accountsuccess');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $chooseSeatsRoute => GoRouteData.$route(
  path: '/chooseSeats',
  hasOverriddenOnExit: false,
  factory: $ChooseSeatsRoute._fromState,
);

mixin $ChooseSeatsRoute on GoRouteData {
  static ChooseSeatsRoute _fromState(GoRouterState state) =>
      const ChooseSeatsRoute();

  @override
  String get location => GoRouteData.$location('/chooseSeats');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $paymentCheckoutRoute => GoRouteData.$route(
  path: '/paymentCheckout',
  hasOverriddenOnExit: false,
  factory: $PaymentCheckoutRoute._fromState,
);

mixin $PaymentCheckoutRoute on GoRouteData {
  static PaymentCheckoutRoute _fromState(GoRouterState state) =>
      PaymentCheckoutRoute();

  @override
  String get location => GoRouteData.$location('/paymentCheckout');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $paymentMethodRoute => GoRouteData.$route(
  path: '/paymentMethod',
  hasOverriddenOnExit: false,
  factory: $PaymentMethodRoute._fromState,
);

mixin $PaymentMethodRoute on GoRouteData {
  static PaymentMethodRoute _fromState(GoRouterState state) =>
      PaymentMethodRoute();

  @override
  String get location => GoRouteData.$location('/paymentMethod');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $addCardRoute => GoRouteData.$route(
  path: '/addCard',
  hasOverriddenOnExit: false,
  factory: $AddCardRoute._fromState,
);

mixin $AddCardRoute on GoRouteData {
  static AddCardRoute _fromState(GoRouterState state) => AddCardRoute();

  @override
  String get location => GoRouteData.$location('/addCard');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $successfulPaymentRoute => GoRouteData.$route(
  path: '/successfulPayment',
  hasOverriddenOnExit: false,
  factory: $SuccessfulPaymentRoute._fromState,
);

mixin $SuccessfulPaymentRoute on GoRouteData {
  static SuccessfulPaymentRoute _fromState(GoRouterState state) =>
      SuccessfulPaymentRoute();

  @override
  String get location => GoRouteData.$location('/successfulPayment');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $appShellRouteData => StatefulShellRouteData.$route(
  factory: $AppShellRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/home',
          hasOverriddenOnExit: false,
          factory: $HomeRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/explore',
          hasOverriddenOnExit: false,
          factory: $ExplorePageRoute._fromState,
        ),
        GoRouteData.$route(
          path: '/nowShowing',
          hasOverriddenOnExit: false,
          factory: $NowShowingRoute._fromState,
        ),
        GoRouteData.$route(
          path: '/movieDetails/:id',
          hasOverriddenOnExit: false,
          factory: $MovieDetailsRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/ticket',
          hasOverriddenOnExit: false,
          factory: $TicketRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/profile',
          hasOverriddenOnExit: false,
          factory: $ProfilePageRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $AppShellRouteDataExtension on AppShellRouteData {
  static AppShellRouteData _fromState(GoRouterState state) =>
      const AppShellRouteData();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ExplorePageRoute on GoRouteData {
  static ExplorePageRoute _fromState(GoRouterState state) =>
      const ExplorePageRoute();

  @override
  String get location => GoRouteData.$location('/explore');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $NowShowingRoute on GoRouteData {
  static NowShowingRoute _fromState(GoRouterState state) =>
      const NowShowingRoute();

  @override
  String get location => GoRouteData.$location('/nowShowing');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MovieDetailsRoute on GoRouteData {
  static MovieDetailsRoute _fromState(GoRouterState state) =>
      MovieDetailsRoute(id: state.pathParameters['id']!);

  MovieDetailsRoute get _self => this as MovieDetailsRoute;

  @override
  String get location =>
      GoRouteData.$location('/movieDetails/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TicketRoute on GoRouteData {
  static TicketRoute _fromState(GoRouterState state) => const TicketRoute();

  @override
  String get location => GoRouteData.$location('/ticket');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfilePageRoute on GoRouteData {
  static ProfilePageRoute _fromState(GoRouterState state) =>
      const ProfilePageRoute();

  @override
  String get location => GoRouteData.$location('/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
