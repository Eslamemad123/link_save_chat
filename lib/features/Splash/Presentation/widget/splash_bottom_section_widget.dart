import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/features/Splash/Presentation/widget/splash_bottom_icon_widget.dart';
import 'package:link_savw_chat/features/Splash/Presentation/widget/splash_loading_bar_widget.dart';

class SplashBottomSectionWidget extends StatelessWidget {
  const SplashBottomSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SplashLoadingBarWidget(),
        SizedBox(height: 14.h),
        const SplashBottomIconWidget(),
      ],
    );
  }
}

