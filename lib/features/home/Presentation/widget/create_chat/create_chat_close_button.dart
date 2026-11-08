import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class CreateChatCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CreateChatCloseButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onPressed ?? () => Navigator.of(context).pop(),
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        width: 36.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.closeButtonBackgroundDark
              : AppColors.closeButtonBackgroundLight,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.close_rounded,
          size: 18.r,
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSubtitleLight,
        ),
      ),
    );
  }
}
