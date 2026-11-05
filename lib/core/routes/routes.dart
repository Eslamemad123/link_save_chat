import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:link_savw_chat/features/Auth/Presentation/page/forgot_password_view.dart';
import 'package:link_savw_chat/features/Auth/Presentation/page/login_view.dart';
import 'package:link_savw_chat/features/Auth/Presentation/page/sign_up_view.dart';
import 'package:link_savw_chat/features/Splash/Presentation/page/splash_view.dart';
import 'package:link_savw_chat/features/home/Presentation/page/home_view.dart';
import 'package:link_savw_chat/features/onBoarding/Presentation/page/on_boarding_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splash = '/';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String forgotPassword = '/forgotPassword';

  static final routes = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashView()),
      GoRoute(
        path: onBoarding,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: signUp,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => const ForgotPasswordView(),
      ),
    ],
  );
}
