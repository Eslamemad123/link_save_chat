import '../models/category_model.dart';
import '../models/chat_model.dart';

abstract class HomeDataSource {
  Future<List<ChatModel>> getChats();
  Future<void> addChat(ChatModel chat);
  Future<void> updateChat(ChatModel chat);
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> addCategory(String name);
}
