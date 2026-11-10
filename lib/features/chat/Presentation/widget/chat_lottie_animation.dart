import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constatnts/animations.dart';

class ChatLottieAnimation extends StatelessWidget {
  const ChatLottieAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170.w,
      height: 170.h,
      child: Lottie.asset(
        AppAnimation.emptyChat,
        fit: BoxFit.contain,
        repeat: true,
      ),
    );
  }
}

