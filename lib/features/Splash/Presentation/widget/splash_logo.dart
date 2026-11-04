import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/constatnts/animations.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:lottie/lottie.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 140.w,
          height: 140.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? AppColors.splashGlowDark
                    : AppColors.splashGlowLight,
                blurRadius: 60.r,
                spreadRadius: 25.r,
              ),
            ],
          ),
        ),
        Lottie.asset(
          AppAnimation.splashLogoJSON,
          width: 150.w,
          height: 150.w,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
