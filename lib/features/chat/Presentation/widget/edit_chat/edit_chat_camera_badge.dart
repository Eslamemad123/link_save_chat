import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class EditChatCameraBadge extends StatelessWidget {
  final VoidCallback? onTap;

  const EditChatCameraBadge({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
          color: AppColors.brandBlue,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 2.w),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.camera_alt_rounded,
          size: 16.r,
          color: AppColors.white,
        ),
      ),
    );
  }
}

