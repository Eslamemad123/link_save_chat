import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class EditChatTitleText extends StatelessWidget {
  const EditChatTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Text(
      'Edit Chat',
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight,
      ),
    );
  }
}

