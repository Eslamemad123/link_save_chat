import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/navigation.dart';
import '../../../../core/utils/colors.dart';

class ChatBackButton extends StatelessWidget {
  const ChatBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: () => pop(context),
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
                  : AppColors.cardBorderLight,
              width: 1.w,
            ),
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.r,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textTitleLight,
          ),
        ),
      ),
    );
  }
}
