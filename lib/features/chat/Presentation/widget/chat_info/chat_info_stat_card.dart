import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

import 'chat_info_stat_icon_badge.dart';

class ChatInfoStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color badgeBackgroundColor;
  final String value;
  final Color valueColor;
  final String label;

  const ChatInfoStatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.badgeBackgroundColor,
    required this.value,
    required this.valueColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ChatInfoStatIconBadge(
            icon: icon,
            iconColor: iconColor,
            backgroundColor: badgeBackgroundColor,
          ),
          SizedBox(height: 10.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: valueColor,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSubtitleLight,
            ),
          ),
        ],
      ),
    );
  }
}

