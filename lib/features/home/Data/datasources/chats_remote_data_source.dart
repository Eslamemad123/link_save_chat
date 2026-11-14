import '../models/remote_category_change.dart';
import '../models/remote_chat_change.dart';

abstract class ChatsRemoteDataSource {
  String generateChatId();
  Future<List<Map<String, dynamic>>> fetchAllChats();
  Stream<List<RemoteChatChange>> watchChatChanges({required int sinceEpochMs});
  void pushChat(Map<String, dynamic> data);
  void updateChatFields(String chatId, Map<String, dynamic> fields);
  void softDeleteChat(String chatId);

  String generateCategoryId();
  Future<List<Map<String, dynamic>>> fetchAllCategories();
  Stream<List<RemoteCategoryChange>> watchCategoryChanges({required int sinceEpochMs});
  void pushCategory(Map<String, dynamic> data);
  void softDeleteCategory(String categoryId);
}

