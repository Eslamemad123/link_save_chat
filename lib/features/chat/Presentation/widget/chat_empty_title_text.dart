import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';

class ChatEmptyTitleText extends StatelessWidget {
  const ChatEmptyTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Text(
      'No links or tasks yet! 🚀',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight,
        letterSpacing: 0.2,
      ),
    );
  }
}

