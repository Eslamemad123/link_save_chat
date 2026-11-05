import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class LoginForgotPasswordButton extends StatelessWidget {
  const LoginForgotPasswordButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: onPressed ?? () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'Forgot Password?',
          style: AppFontStyles.font14BoldPrimary(context),
        ),
      ),
    );
  }
}
