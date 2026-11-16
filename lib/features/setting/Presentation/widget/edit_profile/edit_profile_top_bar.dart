import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class EditProfileTopBar extends StatelessWidget {
  const EditProfileTopBar({
    super.key,
    this.onSave,
  });

  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => pop(context),
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceDark
                    : AppColors.surfaceLight,
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
          Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textTitleLight,
            ),
          ),
          TextButton(
            onPressed: onSave ?? () => pop(context),
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.brandBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

