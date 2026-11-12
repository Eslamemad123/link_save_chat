import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class ChatInfoDivider extends StatelessWidget {
  const ChatInfoDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Divider(
        height: 1.h,
        thickness: 1.h,
        color: isDark ? AppColors.cardBorderDark : AppColors.borderLight,
      ),
    );
  }
}

