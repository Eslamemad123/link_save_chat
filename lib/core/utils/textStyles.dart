import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class AppFontStyles {
  static TextStyle font28BoldTitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.bold,
      color: isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight,
      letterSpacing: 0.5,
    );
  }

  static TextStyle font24BoldTitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight,
    );
  }

  static TextStyle font22BoldTitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
      color: isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight,
      height: 1.3,
    );
  }

  static TextStyle font16BoldButton(BuildContext context) {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    );
  }

  static TextStyle font16RegularSubtitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSubtitleLight,
      height: 1.5,
    );
  }

  static TextStyle font15MediumText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
      color: isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight,
    );
  }

  static TextStyle font14RegularSubtitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSubtitleLight,
    );
  }

  static TextStyle font14MediumSkip(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSubtitleLight,
    );
  }

  static TextStyle font14BoldPrimary(BuildContext context) {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.brandBlue,
    );
  }

  static TextStyle font14RegularInput(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
    );
  }

  static TextStyle font14RegularHint(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSubtitleLight,
    );
  }

  static TextStyle font13MediumSubtitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSubtitleLight,
      letterSpacing: 2.0,
    );
  }
}
