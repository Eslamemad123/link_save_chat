import '../../Data/models/chat_model.dart';
import '../repositories/home_repository.dart';

class GetChatsUseCase {
  final HomeRepository repository;

  GetChatsUseCase({required this.repository});

  Future<List<ChatModel>> call() async {
    return await repository.getChats();
  }
}
