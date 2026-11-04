import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class LoginSignUpPrompt extends StatelessWidget {
  const LoginSignUpPrompt({
    super.key,
    this.onSignUpPressed,
  });

  final VoidCallback? onSignUpPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: AppFontStyles.font14RegularSubtitle(context),
        ),
        SizedBox(width: 6.w),
        GestureDetector(
          onTap: onSignUpPressed ?? () {},
          child: Text(
            'Sign Up',
            style: AppFontStyles.font14BoldPrimary(context),
          ),
        ),
      ],
    );
  }
}
