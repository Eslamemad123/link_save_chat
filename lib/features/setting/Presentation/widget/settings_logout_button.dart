import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/components/buttons/main_button.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class SettingsLogoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const SettingsLogoutButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return MainButton(
      buttonText: 'Log Out',
      onPressed: onPressed,
      backgroundColor: AppColors.error,
      isLoading: isLoading,
      icon: Icon(
        Icons.logout_rounded,
        color: AppColors.white,
        size: 20.r,
      ),
    );
  }
}

