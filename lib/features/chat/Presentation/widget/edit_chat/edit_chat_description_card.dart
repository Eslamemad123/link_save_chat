import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class EditChatDescriptionCard extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const EditChatDescriptionCard({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final cardBorder = isDark
        ? AppColors.cardBorderDark
        : AppColors.cardBorderLight;
    final labelColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSubtitleLight;
    final textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: cardBorder, width: 1.w),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Description',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: labelColor,
              ),
            ),
            SizedBox(height: 6.h),
            TextFormField(
              controller: controller,
              minLines: 2,
              maxLines: 4,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: textColor,
                height: 1.4,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: 'Enter chat description',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: labelColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

