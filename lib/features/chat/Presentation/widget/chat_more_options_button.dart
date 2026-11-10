import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';

class ChatMoreOptionsButton extends StatelessWidget {
  final VoidCallback? onInfoTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onClearTap;

  const ChatMoreOptionsButton({
    super.key,
    this.onInfoTap,
    this.onSearchTap,
    this.onClearTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert_rounded,
        size: 22.r,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight,
      ),
      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: isDark
              ? AppColors.cardBorderDark
              : AppColors.cardBorderLight,
          width: 1.w,
        ),
      ),
      elevation: 6,
      onSelected: (value) {
        if (value == 'info') {
          onInfoTap?.call();
        } else if (value == 'search') {
          onSearchTap?.call();
        } else if (value == 'clear') {
          onClearTap?.call();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'search',
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                size: 18.r,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textTitleLight,
              ),
              SizedBox(width: 10.w),
              Text(
                'Search',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textTitleLight,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'info',
          child: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 18.r,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textTitleLight,
              ),
              SizedBox(width: 10.w),
              Text(
                'Chat Info',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textTitleLight,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'clear',
          child: Row(
            children: [
              Icon(
                Icons.delete_outline_rounded,
                size: 18.r,
                color: AppColors.error,
              ),
              SizedBox(width: 10.w),
              Text(
                'Clear Chat',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

