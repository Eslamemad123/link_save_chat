import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';

class ChatHeaderInfo extends StatelessWidget {
  final String name;
  final String? subtitle;

  const ChatHeaderInfo({
    super.key,
    required this.name,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final displaySubtitle = (subtitle != null && subtitle!.trim().isNotEmpty)
        ? subtitle!.trim()
        : 'New Chat';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          displaySubtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            color: isDark
                ? AppColors.chatHeaderSubtitleDark
                : AppColors.chatHeaderSubtitleLight,
          ),
        ),
      ],
    );
  }
}

