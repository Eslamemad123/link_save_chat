import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/extentions/show_dialoges.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/routes/routes.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';

import '../../cubit/chat_cubit.dart';
import '../../cubit/chat_state.dart';
import 'chat_info_actions_container.dart';
import 'chat_info_background_glow.dart';
import 'chat_info_confirmation_dialog.dart';
import 'chat_info_profile_section.dart';
import 'chat_info_stats_section.dart';
import 'chat_info_top_bar.dart';

class ChatInfoViewBody extends StatelessWidget {
  final ChatModel chat;

  const ChatInfoViewBody({super.key, required this.chat});

  Future<void> _onEditChatPressed(BuildContext context, ChatModel currentChat) async {
    final updatedChat = await pushTo<ChatModel>(
      context,
      Routes.editChat,
      currentChat,
    );
    if (updatedChat != null && context.mounted) {
      context.read<ChatCubit>().updateChat(updatedChat);
    }
  }

  void _onClearMessagesPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => ChatInfoConfirmationDialog(
        title: 'Clear Chat Messages',
        message: 'Are you sure you want to clear all messages in this chat?',
        confirmLabel: 'Clear',
        onConfirm: () {
          context.read<ChatCubit>().clearChatMessages();
          showMyDialog(
            context,
            'Chat messages cleared',
            type: DialogType.success,
          );
        },
      ),
    );
  }

  void _onDeleteChatPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => ChatInfoConfirmationDialog(
        title: 'Delete Chat',
        message:
            'Are you sure you want to delete this chat permanently? This action cannot be undone.',
        confirmLabel: 'Delete',
        onConfirm: () {
          context.read<ChatCubit>().deleteChat();
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
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final currentChat = state.chat;

        return Stack(
          children: [
            const ChatInfoBackgroundGlow(),
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ChatInfoTopBar(
                      onEditTap: () => _onEditChatPressed(context, currentChat),
                    ),
                    SizedBox(height: 8.h),
                    ChatInfoProfileSection(
                      image: currentChat.displayImage,
                      name: currentChat.name,
                      createdAt: currentChat.datecreateChat,
                      onAvatarBadgeTap: () => _onEditChatPressed(context, currentChat),
                    ),
                    SizedBox(height: 24.h),
                    ChatInfoStatsSection(
                      overdueCount: 4,
                      completedCount: 28,
                      totalCount: currentChat.nummessage > 0
                          ? currentChat.nummessage
                          : 42,
                    ),
                    SizedBox(height: 20.h),
                    ChatInfoActionsContainer(
                      isPinned: state.isPinned,
                      onPinChanged: (val) {
                        context.read<ChatCubit>().togglePin(val);
                      },
                      isMuted: state.isMuted,
                      onMuteChanged: (val) {
                        context.read<ChatCubit>().toggleMute(val);
                      },
                      onWallpaperTap: () {
                        context.read<ChatCubit>().updateWallpaper('default');
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
                      onClearMessagesTap: () => _onClearMessagesPressed(context),
                      onDeleteChatTap: () => _onDeleteChatPressed(context),
                    ),
                    SizedBox(height: 36.h),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
