import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class ChatInfoWallpaperPreview extends StatelessWidget {
  final Color? color;

  const ChatInfoWallpaperPreview({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 28.w,
      height: 28.h,
      decoration: BoxDecoration(
        color: color ?? AppColors.chatInfoWallpaperPreview,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight,
          width: 1.w,
        ),
      ),
    );
  }
}

