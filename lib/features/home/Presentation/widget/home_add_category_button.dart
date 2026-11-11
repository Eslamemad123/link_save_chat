import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';

class HomeAddCategoryButton extends StatelessWidget {
  final VoidCallback onTap;

  const HomeAddCategoryButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.surfaceDark
        : AppColors.surfaceLight;

    final borderColor = isDark
        ? AppColors.cardBorderDark
        : AppColors.cardBorderLight;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: borderColor, width: 1.w),
          ),
          child: Icon(
            Icons.add_rounded,
            size: 18.r,
            color: AppColors.brandBlue,
          ),
        ),
      ),
    );
  }
}
