import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/constatnts/icons.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

import 'chat_info_action_tile.dart';
import 'chat_info_destructive_tile.dart';
import 'chat_info_divider.dart';
import 'chat_info_switch_tile.dart';
import 'chat_info_wallpaper_preview.dart';

class ChatInfoActionsContainer extends StatelessWidget {
  final bool isPinned;
  final ValueChanged<bool> onPinChanged;
  final bool isMuted;
  final ValueChanged<bool> onMuteChanged;
  final VoidCallback? onWallpaperTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onExportTap;
  final VoidCallback? onClearMessagesTap;
  final VoidCallback? onDeleteChatTap;

  const ChatInfoActionsContainer({
    super.key,
    required this.isPinned,
    required this.onPinChanged,
    required this.isMuted,
    required this.onMuteChanged,
    this.onWallpaperTap,
    this.onSearchTap,
    this.onExportTap,
    this.onClearMessagesTap,
    this.onDeleteChatTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isDark
                ? AppColors.cardBorderDark
                : AppColors.cardBorderLight,
            width: 1.w,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            ChatInfoActionTile(
              icon: AppIcons.photo,
              title: 'Chat Wallpaper',
              trailing: const ChatInfoWallpaperPreview(),
              onTap: onWallpaperTap,
            ),
            const ChatInfoDivider(),
            ChatInfoSwitchTile(
              icon: AppIcons.pinCircler,
              title: 'Pin Chat',
              value: isPinned,
              onChanged: onPinChanged,
            ),
            const ChatInfoDivider(),
            ChatInfoSwitchTile(
              icon: AppIcons.notification,
              title: 'Mute Notifications',
              value: isMuted,
              onChanged: onMuteChanged,
            ),
            const ChatInfoDivider(),
            ChatInfoActionTile(
              icon: AppIcons.exportIcon,
              title: 'Export Links',
              onTap: onExportTap,
            ),
            const ChatInfoDivider(),
            ChatInfoDestructiveTile(
              icon: AppIcons.clear,
              title: 'Clear Chat Messages',
              onTap: onClearMessagesTap,
            ),
            const ChatInfoDivider(),
            ChatInfoDestructiveTile(
              icon: AppIcons.deleteLine,
              title: 'Delete Chat',
              onTap: onDeleteChatTap,
            ),
          ],
        ),
      ),
    );
  }
}
