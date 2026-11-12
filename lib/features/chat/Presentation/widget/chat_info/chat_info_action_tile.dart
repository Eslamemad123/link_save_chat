import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class ChatInfoActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ChatInfoActionTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
              if (trailing != null) ...[
                trailing!,
                SizedBox(width: 8.w),
              ],
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.r,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSubtitleLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

