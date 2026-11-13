import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class EditChatSaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const EditChatSaveButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: 44.w,
        height: 44.h,
        child: Center(
          child: SizedBox(
            width: 20.r,
            height: 20.r,
            child: const CircularProgressIndicator(
              strokeWidth: 2.2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.brandBlue),
            ),
          ),
        ),
      );
    }

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.brandBlue,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        minimumSize: Size(44.w, 44.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      child: Text(
        'Save',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.brandBlue,
        ),
      ),
    );
  }
}

