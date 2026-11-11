import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';

class ChatTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;

  const ChatTextFormField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      maxLines: 5,
      minLines: 1,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      ),
      decoration: InputDecoration(
        hintText: 'Type a message...',
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSubtitleLight,
        ),
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
      ),
    );
  }
}
