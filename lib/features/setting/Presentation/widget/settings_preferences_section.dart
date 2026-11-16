import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'common/settings_badge.dart';
import 'common/settings_card_container.dart';
import 'common/settings_item_divider.dart';
import 'common/settings_option_tile.dart';
import 'common/settings_tile_icon.dart';

class SettingsPreferencesSection extends StatefulWidget {
  const SettingsPreferencesSection({
    super.key,
    this.onLanguageTap,
  });

  final VoidCallback? onLanguageTap;

  @override
  State<SettingsPreferencesSection> createState() =>
      _SettingsPreferencesSectionState();
}

class _SettingsPreferencesSectionState
    extends State<SettingsPreferencesSection> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SettingsCardContainer(
      child: Column(
        children: [
          SettingsOptionTile(
            leading: SettingsTileIcon(
              icon: Icons.language_rounded,
              iconColor: AppColors.brandBlue,
              backgroundColor: isDark
                  ? AppColors.iconContainerDark
                  : AppColors.brandBlueLight,
            ),
            title: 'Language',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'English',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSubtitleLight,
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14.r,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSubtitleLight,
                ),
              ],
            ),
            onTap: widget.onLanguageTap,
          ),
          const SettingsItemDivider(),
          SettingsOptionTile(
            leading: SettingsTileIcon(
              icon: Icons.notifications_none_rounded,
              iconColor: isDark
                  ? AppColors.taskImportantDark
                  : AppColors.taskImportantLight,
              backgroundColor: isDark
                  ? AppColors.amberContainerDark
                  : AppColors.amberContainerLight,
            ),
            title: 'Notifications',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '3 days delay',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSubtitleLight,
                  ),
                ),
                SizedBox(width: 8.w),
                Switch.adaptive(
                  value: _notificationsEnabled,
                  activeTrackColor: AppColors.brandBlue,
                  onChanged: (val) {
                    setState(() {
                      _notificationsEnabled = val;
                    });
                  },
                ),
              ],
            ),
          ),
          const SettingsItemDivider(),
          SettingsOptionTile(
            leading: SettingsTileIcon(
              icon: Icons.cloud_outlined,
              iconColor: isDark
                  ? AppColors.taskCompletedDark
                  : AppColors.taskCompletedLight,
              backgroundColor: isDark
                  ? AppColors.greenContainerDark
                  : AppColors.greenContainerLight,
            ),
            title: 'Cloud Sync',
            trailing: SettingsBadge(
              text: 'Synced successfully',
              textColor: isDark
                  ? AppColors.taskCompletedDark
                  : AppColors.taskCompletedLight,
              backgroundColor: isDark
                  ? AppColors.greenContainerDark
                  : AppColors.greenContainerLight,
            ),
          ),
        ],
      ),
    );
  }
}
