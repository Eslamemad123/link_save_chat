import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:link_save_chat/core/constatnts/animations.dart';
import 'package:link_save_chat/core/utils/colors.dart';

class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 240.w,
          height: 240.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.brandBlue.withValues(alpha: 0.3),
                AppColors.brandBlue.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
        Lottie.asset(
          AppAnimation.splashLogoJSON,
          width: 130.w,
          height: 130.h,
          fit: BoxFit.contain,
          repeat: false,
        ),
      ],
    );
  }
}
