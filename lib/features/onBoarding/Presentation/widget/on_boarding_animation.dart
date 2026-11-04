import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OnBoardingAnimation extends StatelessWidget {
  const OnBoardingAnimation({super.key, required this.animationPath});

  final String animationPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290.h,
      width: double.infinity,
      child: Center(child: Lottie.asset(animationPath, fit: BoxFit.contain)),
    );
  }
}
