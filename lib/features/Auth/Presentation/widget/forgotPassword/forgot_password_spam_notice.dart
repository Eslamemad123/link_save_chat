import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class ForgotPasswordSpamNotice extends StatelessWidget {
  const ForgotPasswordSpamNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Text(
      "Didn't receive the email? Check your spam folder",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.normal,
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSubtitleLight,
        height: 1.4,
      ),
    );
  }
}

