import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';

class ChatEmptySubtitleText extends StatelessWidget {
  const ChatEmptySubtitleText({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Text(
        'Start sharing links directly from YouTube or browser,\nor write your first task below 👇',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.normal,
          height: 1.5,
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSubtitleLight,
        ),
      ),
    );
  }
}

