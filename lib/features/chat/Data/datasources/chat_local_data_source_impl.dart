import 'dart:async';

import 'package:hive/hive.dart';

import '../../../home/Data/models/chat_model.dart';
import 'chat_local_data_source.dart';

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final Box chatsBox;

  ChatLocalDataSourceImpl({required this.chatsBox});

  @override
  ChatModel? getChat(String chatId) {
    final raw = chatsBox.get(chatId);
    if (raw is Map) {
      return ChatModel.fromHiveMap(raw);
    }
    return null;
  }

  @override
  Stream<ChatModel?> watchChat(String chatId) {
    late final StreamController<ChatModel?> controller;
    StreamSubscription? subscription;

    void emitLatest() {
      if (!controller.isClosed) {
        controller.add(getChat(chatId));
      }
    }

    controller = StreamController<ChatModel?>(
      onListen: () {
        emitLatest();
        subscription = chatsBox.watch(key: chatId).listen((_) => emitLatest());
      },
      onCancel: () {
        subscription?.cancel();
      },
    );

    return controller.stream;
  }

  @override
  Future<void> saveChat(ChatModel chat) async {
    await chatsBox.put(chat.id, chat.toHiveMap());
  }

  @override
  Future<void> markDeleted(String chatId) async {
    final existing = getChat(chatId);
    if (existing != null) {
      final updated = existing.copyWith(
        deleted: true,
        updatedAt: DateTime.now(),
      );
      await saveChat(updated);
    } else {
      await chatsBox.delete(chatId);
    }
  }

  @override
  Future<void> clearChatMessages(String chatId) async {
    final existing = getChat(chatId);
    if (existing != null) {
      final updated = existing.copyWith(
        nummessage: 0,
        lastMessage: '',
        updatedAt: DateTime.now(),
      );
      await saveChat(updated);
    }
  }
}

