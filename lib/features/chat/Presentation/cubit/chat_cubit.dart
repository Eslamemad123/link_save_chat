import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/Data/models/chat_model.dart';
import '../../Domain/repositories/chat_repository.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;
  StreamSubscription<ChatModel?>? _chatSubscription;

  ChatCubit({
    required this.repository,
    required ChatModel initialChat,
  }) : super(ChatState(chat: initialChat)) {
    _initStream(initialChat.id);
  }

  void _initStream(String chatId) {
    if (chatId.isEmpty) return;
    _chatSubscription = repository.watchChat(chatId).listen((updated) {
      if (updated != null) {
        emit(state.copyWith(chat: updated, isDeleted: updated.deleted));
      }
    });
  }

  Future<void> togglePin(bool isPinned) async {
    final updated = state.chat.copyWith(boolIsPin: isPinned);
    emit(state.copyWith(chat: updated));
    try {
      await repository.togglePin(state.chat.id, isPinned);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> toggleMute(bool isMuted) async {
    final updated = state.chat.copyWith(boolNotification: !isMuted);
    emit(state.copyWith(chat: updated));
    try {
      await repository.toggleMute(state.chat.id, isMuted);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> updateWallpaper(String? wallpaper) async {
    final updated = state.chat.copyWith(wallpaper: wallpaper);
    emit(state.copyWith(chat: updated));
    try {
      await repository.updateWallpaper(state.chat.id, wallpaper);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> clearChatMessages() async {
    final updated = state.chat.copyWith(nummessage: 0, lastMessage: '');
    emit(state.copyWith(chat: updated));
    try {
      await repository.clearChatMessages(state.chat.id);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> deleteChat() async {
    emit(state.copyWith(isDeleted: true));
    try {
      await repository.deleteChat(state.chat.id);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<bool> updateChat(ChatModel updatedChat, {File? newImageFile}) async {
    emit(state.copyWith(chat: updatedChat));
    try {
      await repository.updateChat(updatedChat, newImageFile: newImageFile);
      return true;
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
      return false;
    }
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}

