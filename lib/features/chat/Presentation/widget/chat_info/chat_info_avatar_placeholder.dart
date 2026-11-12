import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class ChatInfoAvatarPlaceholder extends StatelessWidget {
  const ChatInfoAvatarPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CircleAvatar(
      radius: 46.r,
      backgroundColor: isDark
          ? AppColors.avatarBackgroundDark
          : AppColors.avatarBackgroundLight,
      child: Icon(
        Icons.code_rounded,
        size: 44.r,
        color: AppColors.brandBlue,
      ),
    );
  }
}

