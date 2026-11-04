import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class PasswordVisibilityToggle extends StatelessWidget {
  const PasswordVisibilityToggle({
    super.key,
    required this.isObscure,
    required this.onPressed,
  });

  final bool isObscure;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      icon: Icon(
        isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSubtitleLight,
        size: 20.sp,
      ),
      onPressed: onPressed,
    );
  }
}

