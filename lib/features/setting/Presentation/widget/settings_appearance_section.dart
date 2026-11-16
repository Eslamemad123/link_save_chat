import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'common/settings_card_container.dart';
import 'common/settings_item_divider.dart';
import 'common/settings_option_tile.dart';
import 'common/settings_tile_icon.dart';
import 'settings_color_picker_row.dart';

class SettingsAppearanceSection extends StatefulWidget {
  const SettingsAppearanceSection({super.key});

  @override
  State<SettingsAppearanceSection> createState() =>
      _SettingsAppearanceSectionState();
}

class _SettingsAppearanceSectionState extends State<SettingsAppearanceSection> {
  bool _isDarkMode = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isDarkMode = Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SettingsCardContainer(
      child: Column(
        children: [
          SettingsOptionTile(
            leading: SettingsTileIcon(
              icon: Icons.nightlight_round,
              iconColor: AppColors.purplePrimary,
              backgroundColor: isDark
                  ? AppColors.purpleContainerDark
                  : AppColors.purpleContainerLight,
            ),
            title: 'Dark Mode',
            trailing: Switch.adaptive(
              value: _isDarkMode,
              activeTrackColor: AppColors.brandBlue,
              onChanged: (val) {
                setState(() {
                  _isDarkMode = val;
                });
              },
            ),
          ),
          const SettingsItemDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Primary Color',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textTitleLight,
                ),
              ),
              const SettingsColorPickerRow(),
            ],
          ),
        ],
      ),
    );
  }
}
