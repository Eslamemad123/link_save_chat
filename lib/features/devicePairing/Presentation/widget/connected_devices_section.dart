import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/features/setting/Presentation/widget/common/settings_badge.dart';
import 'package:link_savw_chat/features/setting/Presentation/widget/common/settings_section_header.dart';
import 'connected_device_card.dart';

class ConnectedDevicesSection extends StatelessWidget {
  const ConnectedDevicesSection({
    super.key,
    this.onLogoutDevice,
  });

  final ValueChanged<String>? onLogoutDevice;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(title: 'Currently Connected Devices'),
        ConnectedDeviceCard(
          deviceName: 'Windows Laptop',
          deviceIcon: Icons.laptop_mac_rounded,
          statusWidget: SettingsBadge(
            text: 'Active now',
            dotColor: AppColors.activeDotGreen,
            textColor: isDark
                ? AppColors.taskCompletedDark
                : AppColors.taskCompletedLight,
            backgroundColor: isDark
                ? AppColors.greenContainerDark
                : AppColors.greenContainerLight,
          ),
          timeText: 'Today 7:30 PM',
        ),
        ConnectedDeviceCard(
          deviceName: 'Chrome Web',
          deviceIcon: Icons.language_rounded,
          timeText: 'Last active yesterday 4:15 PM',
          trailing: InkWell(
            onTap: () => onLogoutDevice?.call('chrome_web'),
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.logoutRedContainerDark
                    : AppColors.logoutRedContainerLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.logoutRed,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

