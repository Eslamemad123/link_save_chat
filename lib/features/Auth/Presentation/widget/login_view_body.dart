import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/constatnts/icons.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/login_divider.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/login_form.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/login_header_text.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/login_illustration.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/login_sign_up_prompt.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/social_login_button.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60.h),
            const LoginIllustration(),
            SizedBox(height: 20.h),
            const LoginHeaderText(),
            SizedBox(height: 24.h),
            const LoginForm(),
            SizedBox(height: 24.h),
            const LoginDivider(),
            SizedBox(height: 20.h),
            const SocialLoginButton(
              text: 'Continue with Google',
              iconPath: AppIcons.googleLogo,
            ),
            SizedBox(height: 12.h),
            const SocialLoginButton(
              text: 'Continue with Facebook',
              iconPath: AppIcons.facebookLogo,
            ),
            SizedBox(height: 28.h),
            const LoginSignUpPrompt(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
