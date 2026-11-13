import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_savw_chat/core/GetIt/gi.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';
import 'package:link_savw_chat/features/home/Presentation/cubit/home_cubit.dart';

import '../widget/edit_chat/edit_chat_view_body.dart';

class EditChatView extends StatelessWidget {
  final ChatModel chat;

  const EditChatView({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit;
    try {
      homeCubit = context.read<HomeCubit>();
    } catch (_) {
      homeCubit = gi<HomeCubit>();
    }

    return BlocProvider.value(
      value: homeCubit..loadCategories(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: EditChatViewBody(chat: chat),
        ),
      ),
    );
  }
}

