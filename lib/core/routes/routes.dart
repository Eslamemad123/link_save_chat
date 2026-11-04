import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:link_savw_chat/features/Splash/Presentation/page/splash_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splash = '/';
  static const String onBoarding = '/onBoarding';

  static final routes = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashView()),
    ],
  );
}
