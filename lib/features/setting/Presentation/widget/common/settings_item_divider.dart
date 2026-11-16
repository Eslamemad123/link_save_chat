import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class SettingsItemDivider extends StatelessWidget {
  const SettingsItemDivider({
    super.key,
    this.verticalMargin,
  });

  final double? verticalMargin;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin ?? 12.h),
      height: 1.h,
      color: isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight,
    );
  }
}

