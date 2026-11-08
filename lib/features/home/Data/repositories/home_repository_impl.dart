import '../../Domain/repositories/home_repository.dart';
import '../datasources/home_data_source.dart';
import '../models/chat_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource dataSource;

  HomeRepositoryImpl({required this.dataSource});

  @override
  Future<List<ChatModel>> getChats() async {
    return await dataSource.getChats();
  }

  @override
  Future<void> addChat(ChatModel chat) async {
    await dataSource.addChat(chat);
  }

  @override
  Future<void> deleteChat(String id) async {
    await dataSource.deleteChat(id);
  }
}
