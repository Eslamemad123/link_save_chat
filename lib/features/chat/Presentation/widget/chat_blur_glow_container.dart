import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';

class ChatBlurGlowContainer extends StatelessWidget {
  final Widget child;

  const ChatBlurGlowContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 220.w,
          height: 220.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? AppColors.chatBlurBlueDark
                    : AppColors.chatBlurBlueLight,
                blurRadius: 70.r,
                spreadRadius: 25.r,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.chatIllustrationCardDark
                : AppColors.chatIllustrationCardLight,
            borderRadius: BorderRadius.circular(28.r),
            border: Border.all(
              color: isDark
                  ? AppColors.chatIllustrationBorderDark
                  : AppColors.chatIllustrationBorderLight,
              width: 1.5.w,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? AppColors.chatCardGlowDark
                    : AppColors.chatCardGlowLight,
                blurRadius: 24.r,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}

