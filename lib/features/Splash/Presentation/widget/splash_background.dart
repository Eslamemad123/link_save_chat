import 'package:flutter/material.dart';
import 'package:link_savw_chat/core/constatnts/images.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(AppAssets.splashBackground, fit: BoxFit.cover),
    );
  }
}
