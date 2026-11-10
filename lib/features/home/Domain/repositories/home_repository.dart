import '../../Data/models/category_model.dart';
import '../../Data/models/chat_model.dart';

abstract class HomeRepository {
  Future<List<ChatModel>> getChats();
  Future<void> addChat(ChatModel chat);
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> addCategory(String name);
}
