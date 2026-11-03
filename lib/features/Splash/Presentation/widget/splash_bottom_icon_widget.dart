import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_save_chat/core/constatnts/images.dart';

class SplashBottomIconWidget extends StatelessWidget {
  const SplashBottomIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.splashIcon,
      width: 44.w,
      height: 22.h,
      fit: BoxFit.contain,
    );
  }
}
