import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/constatnts/images.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class LinkedDevicesBannerSection extends StatelessWidget {
  const LinkedDevicesBannerSection({
    super.key,
    this.onLinkDeviceTap,
  });

  final VoidCallback? onLinkDeviceTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        SizedBox(height: 12.h),
        Image.asset(
          AppAssets.connectDevice,
          height: 140.h,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Instant sync of all your links and tasks between phone and computer',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSubtitleLight,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          width: double.infinity,
          height: 52.h,
          decoration: BoxDecoration(
            color: AppColors.brandBlue,
            borderRadius: BorderRadius.circular(26.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.brandBlue.withValues(alpha: 0.35),
                blurRadius: 16.r,
                offset: Offset(0, 6.h),
              ),
            ],
          ),
          child: Material(
            color: AppColors.transparent,
            child: InkWell(
              onTap: onLinkDeviceTap,
              borderRadius: BorderRadius.circular(26.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_scanner_rounded,
                    color: AppColors.white,
                    size: 20.r,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Link New Device',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'Scan the QR code displayed on the laptop screen',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSubtitleLight,
          ),
        ),
      ],
    );
  }
}

