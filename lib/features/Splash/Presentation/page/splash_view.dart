import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/routes/routes.dart';
import 'package:link_savw_chat/features/Auth/Presentation/cubit/auth_cubit.dart';
import 'package:link_savw_chat/features/Splash/Presentation/widget/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        final authCubit = context.read<AuthCubit>();
        authCubit.getCurrentUserAuthState();
        final user = authCubit.currentUser;
        if (user != null) {
          pushAndRemoveUntil(context, Routes.home);
        } else {
          pushReplacement(context, Routes.onBoarding);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashViewBody());
  }
}
