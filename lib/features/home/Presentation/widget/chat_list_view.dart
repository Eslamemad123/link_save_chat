import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../Data/models/chat_model.dart';
import 'chat_empty.dart';
import 'list_chats.dart';

class ChatListView extends StatelessWidget {
  final List<ChatModel> chats;
  final Future<void> Function() onRefresh;
  final ValueChanged<ChatModel>? onChatTap;

  const ChatListView({
    super.key,
    required this.chats,
    required this.onRefresh,
    this.onChatTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (chats.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        color: AppColors.brandBlue,
        child: ChatEmpty(isDark: isDark),
      );
    }

    return ListChats(onRefresh: onRefresh, chats: chats, onChatTap: onChatTap);
  }
}
