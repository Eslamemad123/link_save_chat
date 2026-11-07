import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/extentions/show_dialoges.dart';
import 'package:link_savw_chat/features/Auth/Presentation/cubit/auth_cubit.dart';
import 'package:link_savw_chat/features/Auth/Presentation/cubit/auth_state.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/forgotPassword/forgot_password_animation.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/forgotPassword/forgot_password_back_button.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/forgotPassword/forgot_password_form.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/forgotPassword/forgot_password_header_text.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/forgotPassword/forgot_password_spam_notice.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordResetSent) {
          showMyDialog(
            context,
            'Password reset link sent to your email. Please check your inbox.',
            type: DialogType.success,
          );
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 12.h),
                            const ForgotPasswordBackButton(),
                            SizedBox(height: 12.h),
                            const ForgotPasswordAnimation(),
                            SizedBox(height: 24.h),
                            const ForgotPasswordHeaderText(),
                            SizedBox(height: 32.h),
                            const ForgotPasswordForm(),
                            SizedBox(height: 16.h),
                            const ForgotPasswordSpamNotice(),
                            const Spacer(),
                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
