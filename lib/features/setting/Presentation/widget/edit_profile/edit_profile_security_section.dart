import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/features/setting/Presentation/widget/common/settings_card_container.dart';
import 'package:link_savw_chat/features/setting/Presentation/widget/common/settings_option_tile.dart';
import 'package:link_savw_chat/features/setting/Presentation/widget/common/settings_section_header.dart';
import 'package:link_savw_chat/features/setting/Presentation/widget/common/settings_tile_icon.dart';

class EditProfileSecuritySection extends StatelessWidget {
  const EditProfileSecuritySection({
    super.key,
    this.onChangePasswordTap,
  });

  final VoidCallback? onChangePasswordTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(title: 'Security & Account'),
        SettingsCardContainer(
          child: SettingsOptionTile(
            leading: SettingsTileIcon(
              icon: Icons.lock_outline_rounded,
              iconColor: AppColors.brandBlue,
              backgroundColor: isDark
                  ? AppColors.iconContainerDark
                  : AppColors.brandBlueLight,
            ),
            title: 'Change Password',
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.r,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSubtitleLight,
            ),
            onTap: onChangePasswordTap,
          ),
        ),
      ],
    );
  }
}

