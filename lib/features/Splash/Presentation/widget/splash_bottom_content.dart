import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:link_savw_chat/features/Splash/Presentation/widget/splash_device_icon.dart';
import 'package:link_savw_chat/features/Splash/Presentation/widget/splash_loading_indicator.dart';

class SplashBottomContent extends StatelessWidget {
  const SplashBottomContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SplashLoadingIndicator(),
        Gap(12.h),
        const SplashDeviceIcon(),
      ],
    );
  }
}
