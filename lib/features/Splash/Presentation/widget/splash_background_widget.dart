import 'package:flutter/material.dart';
import 'package:link_save_chat/core/constatnts/images.dart';

class SplashBackgroundWidget extends StatelessWidget {
  const SplashBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        AppAssets.splashBackground,
        fit: BoxFit.cover,
      ),
    );
  }
}
