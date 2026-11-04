import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:link_savw_chat/features/Splash/Presentation/widget/splash_logo.dart';
import 'package:link_savw_chat/features/Splash/Presentation/widget/splash_subtitle_text.dart';
import 'package:link_savw_chat/features/Splash/Presentation/widget/splash_title_text.dart';

class SplashCenterContent extends StatelessWidget {
  const SplashCenterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SplashLogo(),
        Gap(20.h),
        const SplashTitleText(),
        Gap(6.h),
        const SplashSubtitleText(),
      ],
    );
  }
}
