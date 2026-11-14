import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/GetIt/gi.dart';
import 'package:link_savw_chat/core/extentions/show_dialoges.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/routes/routes.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';
import 'package:link_savw_chat/features/home/Domain/repositories/chats_repository.dart';

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
  late ChatModel _chat;
  late bool _isPinned;
  late bool _isMuted;

  @override
  void initState() {
    super.initState();
    _chat = widget.chat;
    _isPinned = widget.chat.boolIsPin;
    _isMuted = !widget.chat.boolNotification;
  }

  Future<void> _onEditChatPressed() async {
    final updatedChat = await pushTo<ChatModel>(
      context,
      Routes.editChat,
      _chat,
    );
    if (updatedChat != null && mounted) {
      setState(() {
        _chat = updatedChat;
      });
    }
  }

  void _onClearMessagesPressed() {
    showDialog(
      context: context,
      builder: (dialogContext) => ChatInfoConfirmationDialog(
        title: 'Clear Chat Messages',
        message: 'Are you sure you want to clear all messages in this chat?',
        confirmLabel: 'Clear',
        onConfirm: () {
          gi<ChatsRepository>().clearChatMessages(_chat.id);
          if (mounted) {
            setState(() {
              _chat = _chat.copyWith(nummessage: 0, lastMessage: '');
            });
            showMyDialog(
              context,
              'Chat messages cleared',
              type: DialogType.success,
            );
          }
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
          gi<ChatsRepository>().deleteChat(_chat.id);
          pop(context);
          pushAndRemoveUntil(context, Routes.home);
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
                  onEditTap: _onEditChatPressed,
                ),
                SizedBox(height: 8.h),
                ChatInfoProfileSection(
                  image: _chat.displayImage,
                  name: _chat.name,
                  createdAt: _chat.datecreateChat,
                  onAvatarBadgeTap: _onEditChatPressed,
                ),
                SizedBox(height: 24.h),
                ChatInfoStatsSection(
                  overdueCount: 4,
                  completedCount: 28,
                  totalCount: _chat.nummessage > 0 ? _chat.nummessage : 42,
                ),
                SizedBox(height: 20.h),
                ChatInfoActionsContainer(
                  isPinned: _isPinned,
                  onPinChanged: (val) {
                    setState(() {
                      _isPinned = val;
                      _chat = _chat.copyWith(boolIsPin: val);
                    });
                    gi<ChatsRepository>().togglePin(_chat.id, val);
                  },
                  isMuted: _isMuted,
                  onMuteChanged: (val) {
                    setState(() {
                      _isMuted = val;
                      _chat = _chat.copyWith(boolNotification: !val);
                    });
                    gi<ChatsRepository>().toggleMute(_chat.id, val);
                  },
                  onWallpaperTap: () {
                    gi<ChatsRepository>().updateWallpaper(_chat.id, 'default');
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
