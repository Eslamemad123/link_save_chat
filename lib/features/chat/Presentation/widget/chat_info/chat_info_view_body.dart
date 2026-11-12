import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/extentions/show_dialoges.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';

import 'chat_info_actions_container.dart';
import 'chat_info_background_glow.dart';
import 'chat_info_confirmation_dialog.dart';
import 'chat_info_profile_section.dart';
import 'chat_info_stats_section.dart';
import 'chat_info_top_bar.dart';

class ChatInfoViewBody extends StatefulWidget {
  final ChatModel chat;

  const ChatInfoViewBody({super.key, required this.chat});

  @override
  State<ChatInfoViewBody> createState() => _ChatInfoViewBodyState();
}

class _ChatInfoViewBodyState extends State<ChatInfoViewBody> {
  late bool _isPinned;
  late bool _isMuted;

  @override
  void initState() {
    super.initState();
    _isPinned = widget.chat.boolIsPin;
    _isMuted = !widget.chat.boolNotification;
  }

  void _onClearMessagesPressed() {
    showDialog(
      context: context,
      builder: (dialogContext) => ChatInfoConfirmationDialog(
        title: 'Clear Chat Messages',
        message: 'Are you sure you want to clear all messages in this chat?',
        confirmLabel: 'Clear',
        onConfirm: () {
          showMyDialog(
            context,
            'Chat messages cleared',
            type: DialogType.success,
          );
        },
      ),
    );
  }

  void _onDeleteChatPressed() {
    showDialog(
      context: context,
      builder: (dialogContext) => ChatInfoConfirmationDialog(
        title: 'Delete Chat',
        message:
            'Are you sure you want to delete this chat permanently? This action cannot be undone.',
        confirmLabel: 'Delete',
        onConfirm: () {
          pop(context);
          showMyDialog(
            context,
            'Chat deleted successfully',
            type: DialogType.success,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ChatInfoBackgroundGlow(),
        SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ChatInfoTopBar(
                  onEditTap: () {
                    showMyDialog(
                      context,
                      'Edit chat details',
                      type: DialogType.warning,
                    );
                  },
                ),
                SizedBox(height: 8.h),
                ChatInfoProfileSection(
                  image: widget.chat.image,
                  name: widget.chat.name,
                  createdAt: widget.chat.datecreateChat,
                  onAvatarBadgeTap: () {
                    showMyDialog(
                      context,
                      'Change chat icon',
                      type: DialogType.warning,
                    );
                  },
                ),
                SizedBox(height: 24.h),
                ChatInfoStatsSection(
                  overdueCount: 4,
                  completedCount: 28,
                  totalCount: widget.chat.nummessage > 0
                      ? widget.chat.nummessage
                      : 42,
                ),
                SizedBox(height: 20.h),
                ChatInfoActionsContainer(
                  isPinned: _isPinned,
                  onPinChanged: (val) {
                    setState(() {
                      _isPinned = val;
                    });
                  },
                  isMuted: _isMuted,
                  onMuteChanged: (val) {
                    setState(() {
                      _isMuted = val;
                    });
                  },
                  onWallpaperTap: () {
                    showMyDialog(
                      context,
                      'Wallpaper settings',
                      type: DialogType.warning,
                    );
                  },
                  onSearchTap: () {
                    showMyDialog(
                      context,
                      'Search in chat',
                      type: DialogType.warning,
                    );
                  },
                  onExportTap: () {
                    showMyDialog(
                      context,
                      'Exporting links',
                      type: DialogType.success,
                    );
                  },
                  onClearMessagesTap: _onClearMessagesPressed,
                  onDeleteChatTap: _onDeleteChatPressed,
                ),
                SizedBox(height: 36.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

