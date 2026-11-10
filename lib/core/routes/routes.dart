import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:link_savw_chat/core/GetIt/gi.dart';
import 'package:link_savw_chat/features/Auth/Presentation/cubit/auth_cubit.dart';
import 'package:link_savw_chat/features/Auth/Presentation/page/forgot_password_view.dart';
import 'package:link_savw_chat/features/Auth/Presentation/page/login_view.dart';
import 'package:link_savw_chat/features/Auth/Presentation/page/sign_up_view.dart';
import 'package:link_savw_chat/features/Splash/Presentation/page/splash_view.dart';
import 'package:link_savw_chat/features/home/Presentation/page/home_view.dart';
import 'package:link_savw_chat/features/onBoarding/Presentation/page/on_boarding_view.dart';
import 'package:link_savw_chat/features/setting/Presentation/page/settings_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splash = '/';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String forgotPassword = '/forgotPassword';
  static const String settings = '/settings';

  static final routes = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: splash,
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      final isAuth = user != null;
      final location = state.matchedLocation;
      final isPublicRoute = location == splash ||
          location == onBoarding ||
          location == login ||
          location == signUp ||
          location == forgotPassword;

      if (!isAuth && !isPublicRoute) {
        return login;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => BlocProvider(
          create: (context) => gi<AuthCubit>(),
          child: const SplashView(),
        ),
      ),
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
      GoRoute(
        path: settings,
        builder: (context, state) => const SettingsView(),
      ),
    ],
  );
}
