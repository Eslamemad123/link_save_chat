import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class ChatInfoDateBadge extends StatelessWidget {
  final DateTime? date;

  const ChatInfoDateBadge({super.key, this.date});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final d = date ?? DateTime.now();

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final dateString = 'Created on ${months[d.month - 1]} ${d.day}, ${d.year}';

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.calendar_today_outlined,
          size: 14.r,
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSubtitleLight,
        ),
        SizedBox(width: 6.w),
        Text(
          dateString,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSubtitleLight,
          ),
        ),
      ],
    );
  }
}

