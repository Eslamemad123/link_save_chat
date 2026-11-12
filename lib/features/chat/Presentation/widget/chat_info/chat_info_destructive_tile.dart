import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class ChatInfoDestructiveTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ChatInfoDestructiveTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final destructiveColor = isDark
        ? AppColors.chatInfoDestructiveTextDark
        : AppColors.chatInfoDestructiveTextLight;

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
                color: destructiveColor,
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: destructiveColor,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.r,
                color: destructiveColor.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

