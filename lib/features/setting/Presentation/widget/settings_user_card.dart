import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/routes/routes.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'common/settings_card_container.dart';

class SettingsUserCard extends StatelessWidget {
  const SettingsUserCard({
    super.key,
    this.userName = 'Eslam Medny',
    this.email = 'user@example.com',
  });

  final String userName;
  final String email;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SettingsCardContainer(
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          InkWell(
            onTap: () => pushTo(context, Routes.editProfile),
            borderRadius: BorderRadius.circular(14.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
              child: Row(
                children: [
                  Container(
                    width: 52.r,
                    height: 52.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? AppColors.avatarBackgroundDark
                          : AppColors.brandBlueLight,
                    ),
                    child: Center(
                      child: Text(
                        userName.isNotEmpty
                            ? userName.substring(0, 1).toUpperCase()
                            : 'M',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.brandBlue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textTitleLight,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.normal,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSubtitleLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.r,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSubtitleLight,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              InkWell(
                onTap: () => pushTo(context, Routes.linkedDevices),
                borderRadius: BorderRadius.circular(14.r),
                child: Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.iconContainerDark
                        : AppColors.brandBlueLight,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: isDark
                          ? AppColors.cardBorderDark
                          : AppColors.brandBlueLightBorder,
                      width: 1.w,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.qr_code_scanner_rounded,
                      color: AppColors.brandBlue,
                      size: 22.r,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: AppColors.brandBlue,
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brandBlue.withValues(alpha: 0.35),
                        blurRadius: 12.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Material(
                    color: AppColors.transparent,
                    child: InkWell(
                      onTap: () => pushTo(context, Routes.linkedDevices),
                      borderRadius: BorderRadius.circular(14.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.laptop_mac_rounded,
                            color: AppColors.white,
                            size: 20.r,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Linked Devices',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

