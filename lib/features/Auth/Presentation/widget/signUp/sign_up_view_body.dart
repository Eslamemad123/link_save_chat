import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/constatnts/icons.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/routes/routes.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/common/auth_divider.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/common/auth_header_text.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/common/auth_illustration.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/common/auth_prompt.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/common/social_login_button.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/signUp/sign_up_form.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 24.h),
            AuthIllustration(height: 110.h),
            SizedBox(height: 16.h),
            const AuthHeaderText(
              title: 'Create Account',
              subtitle: 'Sign up to sync your links and tasks seamlessly',
            ),
            SizedBox(height: 24.h),
            const SignUpForm(),
            SizedBox(height: 24.h),
            const AuthDivider(),
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
            SizedBox(height: 24.h),
            AuthPrompt(
              promptText: 'Already have an account?',
              actionText: 'Log In',
              onActionPressed: () => pushReplacement(context, Routes.login),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
