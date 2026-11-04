import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/forgot_password_animation.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/forgot_password_back_button.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/forgot_password_form.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/forgot_password_header_text.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/forgot_password_spam_notice.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
  }
}
