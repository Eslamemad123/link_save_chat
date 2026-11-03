import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/features/Splash/Presentation/widget/splash_logo_widget.dart';
import 'package:link_savw_chat/features/Splash/Presentation/widget/splash_title_widget.dart';

class SplashCenterContentWidget extends StatelessWidget {
  const SplashCenterContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SplashLogoWidget(),
        SizedBox(height: 16.h),
        const SplashTitleWidget(),
      ],
    );
  }
}
