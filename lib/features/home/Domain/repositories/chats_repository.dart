import 'dart:io';

import '../../Data/models/category_model.dart';
import '../../Data/models/chat_model.dart';

abstract class ChatsRepository {
  Stream<List<ChatModel>> watchChats();
  Stream<List<CategoryModel>> watchCategories();
  List<ChatModel> getCachedChats();
  List<CategoryModel> getCachedCategories();
  Future<void> createChat(ChatModel chat, {File? imageFile});
  Future<CategoryModel> addCategory(String name);
  Future<void> retryPendingUpload(String chatId);
}
