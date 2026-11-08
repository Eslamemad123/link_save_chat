import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';

class HomeFilterChipItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final int? count;
  final Color? badgeColor;
  final VoidCallback onTap;

  const HomeFilterChipItem({
    super.key,
    required this.label,
    required this.isSelected,
    this.count,
    this.badgeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isSelected
        ? (isDark ? AppColors.filterChipActiveDark : AppColors.filterChipActiveLight)
        : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);

    final borderColor = isSelected
        ? AppColors.brandBlue
        : (isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight);

    final textColor = isSelected
        ? AppColors.brandBlue
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSubtitleLight);

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: borderColor, width: 1.w),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (count != null && count! > 0) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: badgeColor ?? AppColors.brandBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

