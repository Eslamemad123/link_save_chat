import 'home_data_source.dart';
import '../models/chat_model.dart';

class HomeDataSourceImpl implements HomeDataSource {
  @override
  Future<List<ChatModel>> getChats() async {
    return [];
  }

  @override
  Future<void> addChat(ChatModel chat) async {}

  @override
  Future<void> deleteChat(String id) async {}
}

