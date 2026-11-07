import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/constatnts/icons.dart';
import 'package:link_savw_chat/core/extentions/show_dialoges.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/routes/routes.dart';
import 'package:link_savw_chat/features/Auth/Presentation/cubit/auth_cubit.dart';
import 'package:link_savw_chat/features/Auth/Presentation/cubit/auth_state.dart';
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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          pushAndRemoveUntil(context, Routes.home);
        } else if (state is AuthError) {
          showMyDialog(context, state.message, type: DialogType.error);
        }
      },
      child: SafeArea(
        child: BlocSelector<AuthCubit, AuthState, bool>(
          selector: (state) => state is AuthLoading,
          builder: (context, isLoading) {
            return AbsorbPointer(
              absorbing: isLoading,
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
                    BlocBuilder<AuthCubit, AuthState>(
                      buildWhen: (prev, curr) =>
                          (prev is AuthLoading) != (curr is AuthLoading),
                      builder: (context, state) {
                        final isGoogleLoading =
                            state is AuthLoading && state.action == 'google';
                        return SocialLoginButton(
                          text: 'Continue with Google',
                          iconPath: AppIcons.googleLogo,
                          isLoading: isGoogleLoading,
                          onPressed: () {
                            context.read<AuthCubit>().signInWithGoogle();
                          },
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    BlocBuilder<AuthCubit, AuthState>(
                      buildWhen: (prev, curr) =>
                          (prev is AuthLoading) != (curr is AuthLoading),
                      builder: (context, state) {
                        final isFacebookLoading =
                            state is AuthLoading && state.action == 'facebook';
                        return SocialLoginButton(
                          text: 'Continue with Facebook',
                          iconPath: AppIcons.facebookLogo,
                          isLoading: isFacebookLoading,
                          onPressed: () {
                            context.read<AuthCubit>().signInWithFacebook();
                          },
                        );
                      },
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
          },
        ),
      ),
    );
  }
}
