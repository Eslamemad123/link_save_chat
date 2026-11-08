import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class CreateChatAvatarBadge extends StatelessWidget {
  final VoidCallback? onTap;

  const CreateChatAvatarBadge({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: AppColors.brandBlue,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.white,
            width: 2.w,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 4.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.camera_alt_rounded,
          size: 15.r,
          color: AppColors.white,
        ),
      ),
    );
  }
}
