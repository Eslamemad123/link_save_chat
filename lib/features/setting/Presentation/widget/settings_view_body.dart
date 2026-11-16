import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'common/settings_section_header.dart';
import 'settings_appearance_section.dart';
import 'settings_preferences_section.dart';
import 'settings_user_card.dart';
import 'settings_wallpaper_section.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SettingsSectionHeader(title: 'Account'),
          const SettingsUserCard(),
          const SettingsSectionHeader(title: 'Appearance'),
          const SettingsAppearanceSection(),
          const SettingsSectionHeader(title: 'Chat Wallpaper'),
          const SettingsWallpaperSection(),
          const SettingsSectionHeader(title: 'General Preferences'),
          const SettingsPreferencesSection(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
