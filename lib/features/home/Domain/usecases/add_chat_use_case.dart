import '../../Data/models/chat_model.dart';
import '../repositories/home_repository.dart';

class AddChatUseCase {
  final HomeRepository repository;

  AddChatUseCase({required this.repository});

  Future<void> call(ChatModel chat) async {
    await repository.addChat(chat);
  }
}

