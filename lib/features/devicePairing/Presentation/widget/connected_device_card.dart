import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/features/setting/Presentation/widget/common/settings_card_container.dart';
import 'package:link_savw_chat/features/setting/Presentation/widget/common/settings_tile_icon.dart';

class ConnectedDeviceCard extends StatelessWidget {
  const ConnectedDeviceCard({
    super.key,
    required this.deviceName,
    required this.deviceIcon,
    this.statusWidget,
    this.timeText,
    this.trailing,
    this.margin,
  });

  final String deviceName;
  final IconData deviceIcon;
  final Widget? statusWidget;
  final String? timeText;
  final Widget? trailing;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SettingsCardContainer(
      margin: margin ?? EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          SettingsTileIcon(
            icon: deviceIcon,
            iconColor: isDark ? AppColors.primaryDark : AppColors.brandBlue,
            backgroundColor: isDark
                ? AppColors.iconContainerDark
                : AppColors.brandBlueLight,
            size: 44.r,
            iconSize: 24.r,
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deviceName,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textTitleLight,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    if (statusWidget != null) ...[
                      statusWidget!,
                      SizedBox(width: 8.w),
                    ],
                    if (timeText != null)
                      Text(
                        timeText!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSubtitleLight,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: 8.w),
            trailing!,
          ],
        ],
      ),
    );
  }
}

