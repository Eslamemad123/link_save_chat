import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class ForgotPasswordHeaderText extends StatelessWidget {
  const ForgotPasswordHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Forgot Password 🔐',
          textAlign: TextAlign.center,
          style: AppFontStyles.font24BoldTitle(context),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Enter your registered email and we will send you a secure link to reset your password immediately.',
            textAlign: TextAlign.center,
            style: AppFontStyles.font14RegularSubtitle(context),
          ),
        ),
      ],
    );
  }
}

