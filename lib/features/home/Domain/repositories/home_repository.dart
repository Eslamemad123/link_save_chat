import '../../Data/models/chat_model.dart';

abstract class HomeRepository {
  Future<List<ChatModel>> getChats();
  Future<void> addChat(ChatModel chat);
}
