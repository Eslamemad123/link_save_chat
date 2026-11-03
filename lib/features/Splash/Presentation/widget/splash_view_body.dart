import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:link_save_chat/core/routes/routes.dart';
import 'package:link_save_chat/core/utils/colors.dart';
import 'package:link_save_chat/features/Splash/Presentation/widget/splash_background_widget.dart';
import 'package:link_save_chat/features/Splash/Presentation/widget/splash_bottom_section_widget.dart';
import 'package:link_save_chat/features/Splash/Presentation/widget/splash_center_content_widget.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(microseconds: 2500), () {
      if (mounted) {
        context.pushReplacement(Routes.onBoarding);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final overlayStyle = SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Container(
        color: isDark ? AppColors.backgroundDark : AppColors.white,
        child: Stack(
          children: [
            const SplashBackgroundWidget(),
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox.shrink(),
                    const SplashCenterContentWidget(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 32.h),
                      child: const SplashBottomSectionWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
