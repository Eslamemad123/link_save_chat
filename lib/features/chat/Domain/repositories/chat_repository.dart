import 'dart:io';

import '../../../home/Data/models/chat_model.dart';

abstract class ChatRepository {
  ChatModel? getChat(String chatId);
  Stream<ChatModel?> watchChat(String chatId);
  Future<void> updateChat(ChatModel chat, {File? newImageFile});
  Future<void> togglePin(String chatId, bool isPinned);
  Future<void> toggleMute(String chatId, bool isMuted);
  Future<void> updateWallpaper(String chatId, String? wallpaper);
  Future<void> clearChatMessages(String chatId);
  Future<void> deleteChat(String chatId);
}

