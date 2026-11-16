import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class SettingsWallpaperButtonsRow extends StatelessWidget {
  const SettingsWallpaperButtonsRow({
    super.key,
    this.onBuiltInPressed,
    this.onGalleryPressed,
  });

  final VoidCallback? onBuiltInPressed;
  final VoidCallback? onGalleryPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final buttonBg =
        isDark ? AppColors.iconContainerDark : AppColors.brandBlueLight;
    final borderColor =
        isDark ? AppColors.cardBorderDark : AppColors.brandBlueLightBorder;
    final textColor =
        isDark ? AppColors.primaryDark : AppColors.brandBlue;

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onBuiltInPressed,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: buttonBg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: borderColor,
                  width: 1.w,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.grid_view_rounded,
                    color: textColor,
                    size: 18.r,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Built-in',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: InkWell(
            onTap: onGalleryPressed,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: buttonBg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: borderColor,
                  width: 1.w,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    color: textColor,
                    size: 18.r,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'From Gallery',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

