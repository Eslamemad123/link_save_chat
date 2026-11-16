import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'edit_profile_avatar_section.dart';
import 'edit_profile_delete_button.dart';
import 'edit_profile_fields_section.dart';
import 'edit_profile_security_section.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({
    super.key,
    this.onChangePhoto,
    this.onChangePasswordTap,
    this.onDeleteAccount,
  });

  final VoidCallback? onChangePhoto;
  final VoidCallback? onChangePasswordTap;
  final VoidCallback? onDeleteAccount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          EditProfileAvatarSection(
            onChangePhoto: onChangePhoto,
          ),
          SizedBox(height: 16.h),
          const EditProfileFieldsSection(),
          SizedBox(height: 8.h),
          EditProfileSecuritySection(
            onChangePasswordTap: onChangePasswordTap,
          ),
          SizedBox(height: 24.h),
          EditProfileDeleteButton(
            onDeleteAccount: onDeleteAccount,
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

