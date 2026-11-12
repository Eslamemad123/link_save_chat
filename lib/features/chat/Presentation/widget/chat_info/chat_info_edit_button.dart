import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class ChatInfoEditButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ChatInfoEditButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          width: 44.w,
          height: 44.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isDark
                  ? AppColors.cardBorderDark
                  : AppColors.cardBorderLight,
              width: 1.w,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.edit_outlined,
            size: 19.r,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textTitleLight,
          ),
        ),
      ),
    );
  }
}

