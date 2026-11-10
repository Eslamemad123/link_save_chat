import 'package:flutter/material.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';
import 'chat_app_bar.dart';
import 'chat_background_wallpaper.dart';
import 'chat_empty_content.dart';
import 'chat_input_bar.dart';

class ChatViewBody extends StatelessWidget {
  final ChatModel chat;

  const ChatViewBody({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ChatBackgroundWallpaper(),
        Column(
          children: [
            ChatAppBar(chat: chat),
            const Expanded(
              child: ChatEmptyContent(),
            ),
            ChatInputBar(
              onSendMessage: (message) {},
            ),
          ],
        ),
      ],
    );
  }
}
