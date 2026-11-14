import 'dart:io';

import '../../Data/models/category_model.dart';
import '../../Data/models/chat_model.dart';

abstract class ChatsRepository {
  Stream<List<ChatModel>> watchChats();
  Stream<List<CategoryModel>> watchCategories();
  List<ChatModel> getCachedChats();
  List<CategoryModel> getCachedCategories();
  Future<void> createChat(ChatModel chat, {File? imageFile});
  Future<void> updateChat(ChatModel chat, {File? newImageFile});
  Future<void> togglePin(String chatId, bool isPinned);
  Future<void> toggleMute(String chatId, bool isMuted);
  Future<void> updateWallpaper(String chatId, String? wallpaper);
  Future<void> clearChatMessages(String chatId);
  Future<void> deleteChat(String chatId);
  Future<CategoryModel> addCategory(String name);
  Future<void> retryPendingUpload(String chatId);
}

