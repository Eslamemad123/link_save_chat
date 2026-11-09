import '../models/chat_model.dart';

abstract class HomeDataSource {
  Future<List<ChatModel>> getChats();
  Future<void> addChat(ChatModel chat);
}
