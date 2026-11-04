import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/constatnts/animations.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordAnimation extends StatelessWidget {
  const ForgotPasswordAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      width: double.infinity,
      child: Center(
        child: Lottie.asset(AppAnimation.emptyChat, fit: BoxFit.contain),
      ),
    );
  }
}
