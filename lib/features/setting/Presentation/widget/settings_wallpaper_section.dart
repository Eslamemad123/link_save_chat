import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'common/settings_card_container.dart';
import 'settings_wallpaper_buttons_row.dart';
import 'settings_wallpaper_preview.dart';

class SettingsWallpaperSection extends StatelessWidget {
  const SettingsWallpaperSection({
    super.key,
    this.onBuiltInPressed,
    this.onGalleryPressed,
  });

  final VoidCallback? onBuiltInPressed;
  final VoidCallback? onGalleryPressed;

  @override
  Widget build(BuildContext context) {
    return SettingsCardContainer(
      child: Column(
        children: [
          const SettingsWallpaperPreview(),
          SizedBox(height: 12.h),
          SettingsWallpaperButtonsRow(
            onBuiltInPressed: onBuiltInPressed,
            onGalleryPressed: onGalleryPressed,
          ),
        ],
      ),
    );
  }
}

