import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';

class ChatSearchButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ChatSearchButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: 40.w,
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.closeButtonBackgroundDark
                : AppColors.closeButtonBackgroundLight,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isDark
                  ? AppColors.cardBorderDark
                  : AppColors.avatarCyan,
              width: 1.w,
            ),
          ),
          child: Icon(
            Icons.search_rounded,
            size: 20.r,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textTitleLight,
          ),
        ),
      ),
    );
  }
}
