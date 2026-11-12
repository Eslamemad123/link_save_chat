import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class ChatInfoSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ChatInfoSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22.r,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textTitleLight,
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textTitleLight,
              ),
            ),
          ),
          Switch(
            value: value,
            activeTrackColor: AppColors.brandBlue,
            activeThumbColor: AppColors.white,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

