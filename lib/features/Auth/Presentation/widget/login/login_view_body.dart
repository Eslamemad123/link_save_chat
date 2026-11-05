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
import 'package:link_savw_chat/features/Auth/Presentation/widget/login/login_form.dart';

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
            SizedBox(height: 36.h),
            AuthIllustration(height: 140.h),
            SizedBox(height: 16.h),
            const AuthHeaderText(
              title: 'Welcome Back',
              subtitle: 'Sign in to access your links and tasks',
            ),
            SizedBox(height: 24.h),
            const LoginForm(),
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
            SizedBox(height: 28.h),
            AuthPrompt(
              promptText: "Don't have an account?",
              actionText: 'Sign Up',
              onActionPressed: () => pushTo(context, Routes.signUp),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
