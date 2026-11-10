import 'package:flutter/material.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';
import '../widget/chat_view_body.dart';

class ChatView extends StatelessWidget {
  final ChatModel chat;

  const ChatView({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ChatViewBody(chat: chat),
    );
  }
}
