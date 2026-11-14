import '../models/chat_model.dart';

abstract class ChatsLocalDataSource {
  Stream<List<ChatModel>> watchChats();
  List<ChatModel> getAllChats();
  ChatModel? getChat(String id);
  Future<void> saveChat(ChatModel chat);
  Future<void> saveChats(List<ChatModel> chats);
  Future<void> putRaw(String id, Map<String, dynamic> data);
  Future<void> putRawPreservingPendingImage(String id, Map<String, dynamic> data);
  Future<void> removeChat(String id);
  Future<void> markDeleted(String id);
  List<ChatModel> getPendingImageChats();
  Future<void> clear();
}

