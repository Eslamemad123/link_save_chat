import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/features/Splash/Presentation/widget/splash_background.dart';
import 'package:link_savw_chat/features/Splash/Presentation/widget/splash_bottom_content.dart';
import 'package:link_savw_chat/features/Splash/Presentation/widget/splash_center_content.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const SplashBackground(),
        SafeArea(
          child: Column(
            children: [
              const Spacer(),
              const SplashCenterContent(),
              const Spacer(),
              const SplashBottomContent(),
              SizedBox(height: 36.h),
            ],
          ),
        ),
      ],
    );
  }
}
