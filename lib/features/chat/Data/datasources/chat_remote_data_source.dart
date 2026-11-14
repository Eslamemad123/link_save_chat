abstract class ChatRemoteDataSource {
  void updateChatFields(String chatId, Map<String, dynamic> fields);
  void softDeleteChat(String chatId);
}

