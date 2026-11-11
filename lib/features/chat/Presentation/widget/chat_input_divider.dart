import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';

class ChatInputDivider extends StatelessWidget {
  const ChatInputDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 1.w,
      height: 24.h,
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      color: isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight,
    );
  }
}
