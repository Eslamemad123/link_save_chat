import 'package:flutter/material.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/features/setting/Presentation/widget/common/settings_badge.dart';
import 'edit_profile_field_card.dart';

class EditProfileFieldsSection extends StatelessWidget {
  const EditProfileFieldsSection({
    super.key,
    this.fullName = 'Eslam Medny',
    this.username = '@eslam_dev',
    this.email = 'eslam@example.com',
    this.bio = 'Software Developer 💻 | Links & Tasks Organizer',
  });

  final String fullName;
  final String username;
  final String email;
  final String bio;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        EditProfileFieldCard(
          label: 'Full Name',
          value: fullName,
          icon: Icons.person_outline_rounded,
        ),
        EditProfileFieldCard(
          label: 'Username',
          value: username,
          icon: Icons.alternate_email_rounded,
        ),
        EditProfileFieldCard(
          label: 'Email',
          value: email,
          badge: SettingsBadge(
            text: 'Verified ✓',
            textColor: isDark
                ? AppColors.taskCompletedDark
                : AppColors.taskCompletedLight,
            backgroundColor: isDark
                ? AppColors.greenContainerDark
                : AppColors.greenContainerLight,
          ),
          icon: Icons.mail_outline_rounded,
        ),
        EditProfileFieldCard(
          label: 'Bio',
          value: bio,
          icon: Icons.chat_bubble_outline_rounded,
        ),
      ],
    );
  }
}

