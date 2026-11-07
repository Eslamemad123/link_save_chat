import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class ForgotPasswordBackButton extends StatelessWidget {
  const ForgotPasswordBackButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        width: 44.w,
        height: 44.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          border: Border.all(
            color: isDark ? AppColors.cardBorderDark : AppColors.borderLight,
            width: 1,
          ),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 10.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
        ),
        child: Material(
          color: AppColors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed ?? () => pop(context),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.r,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
        ),
      ),
    );
  }
}

