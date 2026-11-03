import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_save_chat/core/utils/colors.dart';

class SplashLoadingBarWidget extends StatefulWidget {
  const SplashLoadingBarWidget({super.key});

  @override
  State<SplashLoadingBarWidget> createState() => _SplashLoadingBarWidgetState();
}

class _SplashLoadingBarWidgetState extends State<SplashLoadingBarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 2500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 3.5.h,
      decoration: BoxDecoration(
        color: AppColors.progressTrackLight,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: _animation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.brandBlue,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

