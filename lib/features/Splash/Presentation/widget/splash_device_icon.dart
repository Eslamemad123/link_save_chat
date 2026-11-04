import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/constatnts/images.dart';

class SplashDeviceIcon extends StatelessWidget {
  const SplashDeviceIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.splashIcon,
      width: 72.w,
      height: 48.h,
      fit: BoxFit.contain,
    );
  }
}
