import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class EditProfileAvatarSection extends StatelessWidget {
  const EditProfileAvatarSection({
    super.key,
    this.onChangePhoto,
  });

  final VoidCallback? onChangePhoto;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        SizedBox(height: 12.h),
        Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 100.r,
                height: 100.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? AppColors.avatarBackgroundDark
                      : AppColors.brandBlueLight,
                  border: Border.all(
                    color: AppColors.brandBlue.withValues(alpha: 0.2),
                    width: 2.w,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.person_rounded,
                    size: 56.r,
                    color: AppColors.brandBlue,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onChangePhoto,
                  child: Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(
                      color: AppColors.brandBlue,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark
                            ? AppColors.surfaceDark
                            : AppColors.surfaceLight,
                        width: 2.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.brandBlue.withValues(alpha: 0.3),
                          blurRadius: 6.r,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.white,
                        size: 16.r,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        TextButton(
          onPressed: onChangePhoto,
          child: Text(
            'Change Photo',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.brandBlue,
            ),
          ),
        ),
      ],
    );
  }
}

