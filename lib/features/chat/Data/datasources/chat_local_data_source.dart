import '../../../home/Data/models/chat_model.dart';

abstract class ChatLocalDataSource {
  ChatModel? getChat(String chatId);
  Stream<ChatModel?> watchChat(String chatId);
  Future<void> saveChat(ChatModel chat);
  Future<void> markDeleted(String chatId);
  Future<void> clearChatMessages(String chatId);
}

