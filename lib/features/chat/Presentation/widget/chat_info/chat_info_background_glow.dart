import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class ChatInfoBackgroundGlow extends StatelessWidget {
  const ChatInfoBackgroundGlow({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Positioned(
      top: -60.h,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 320.w,
          height: 240.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                (isDark
                        ? AppColors.chatBlurBlueDark
                        : AppColors.chatBlurBlueLight)
                    .withValues(alpha: isDark ? 0.35 : 0.45),
                AppColors.transparent,
              ],
              stops: const [0.0, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}

