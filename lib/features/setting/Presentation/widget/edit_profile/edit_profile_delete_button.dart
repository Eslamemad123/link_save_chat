import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class EditProfileDeleteButton extends StatelessWidget {
  const EditProfileDeleteButton({
    super.key,
    this.onDeleteAccount,
  });

  final VoidCallback? onDeleteAccount;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onDeleteAccount,
        child: Text(
          'Delete Account',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.logoutRed,
          ),
        ),
      ),
    );
  }
}

