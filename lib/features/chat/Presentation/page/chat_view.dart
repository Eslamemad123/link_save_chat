import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_savw_chat/core/GetIt/gi.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';

import '../cubit/chat_cubit.dart';
import '../widget/chat_view_body.dart';

class ChatView extends StatelessWidget {
  final ChatModel chat;

  const ChatView({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => gi<ChatCubit>(param1: chat),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ChatViewBody(chat: chat),
      ),
    );
  }
}
