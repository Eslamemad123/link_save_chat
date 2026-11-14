import 'dart:async';

import 'package:hive/hive.dart';

import '../models/chat_model.dart';
import 'chats_local_data_source.dart';

class ChatsLocalDataSourceImpl implements ChatsLocalDataSource {
  final Box chatsBox;

  ChatsLocalDataSourceImpl({required this.chatsBox});

  @override
  Stream<List<ChatModel>> watchChats() {
    late final StreamController<List<ChatModel>> controller;
    StreamSubscription? subscription;

    void emitLatest() {
      if (!controller.isClosed) {
        controller.add(getAllChats());
      }
    }

    controller = StreamController<List<ChatModel>>(
      onListen: () {
        emitLatest();
        subscription = chatsBox.watch().listen((_) => emitLatest());
      },
      onCancel: () {
        subscription?.cancel();
      },
    );

    return controller.stream;
  }

  @override
  List<ChatModel> getAllChats() {
    final list = <ChatModel>[];

    for (final key in chatsBox.keys) {
      final raw = chatsBox.get(key);
      if (raw is Map) {
        final chat = ChatModel.fromHiveMap(raw);
        if (!chat.deleted) {
          list.add(chat);
        }
      }
    }

    list.sort((a, b) {
      if (a.boolIsPin != b.boolIsPin) {
        return a.boolIsPin ? -1 : 1;
      }
      final aDate = a.updatedAt ??
          a.datecreateChat ??
          a.date ??
          DateTime.fromMillisecondsSinceEpoch(0);
      final bDate = b.updatedAt ??
          b.datecreateChat ??
          b.date ??
          DateTime.fromMillisecondsSinceEpoch(0);
      return bDate.compareTo(aDate);
    });

    return list;
  }

  @override
  ChatModel? getChat(String id) {
    final raw = chatsBox.get(id);
    if (raw is Map) {
      return ChatModel.fromHiveMap(raw);
    }
    return null;
  }

  @override
  Future<void> saveChat(ChatModel chat) async {
    await chatsBox.put(chat.id, chat.toHiveMap());
  }

  @override
  Future<void> saveChats(List<ChatModel> chats) async {
    final entries = <String, Map<String, dynamic>>{};
    for (final chat in chats) {
      entries[chat.id] = chat.toHiveMap();
    }
    await chatsBox.putAll(entries);
  }

  @override
  Future<void> putRaw(String id, Map<String, dynamic> data) async {
    await chatsBox.put(id, data);
  }

  @override
  Future<void> putRawPreservingPendingImage(
    String id,
    Map<String, dynamic> data,
  ) async {
    final existingRaw = chatsBox.get(id);
    if (existingRaw is Map) {
      final existingPending = existingRaw['pendingImagePath']?.toString();
      if (existingPending != null && existingPending.isNotEmpty) {
        final merged = Map<String, dynamic>.from(data);
        merged['pendingImagePath'] = existingPending;
        merged['image'] = existingRaw['image'] ?? existingPending;
        await chatsBox.put(id, merged);
        return;
      }
    }
    await chatsBox.put(id, data);
  }

  @override
  Future<void> removeChat(String id) async {
    await chatsBox.delete(id);
  }

  @override
  Future<void> markDeleted(String id) async {
    final existing = getChat(id);
    if (existing != null) {
      final updated = existing.copyWith(
        deleted: true,
        updatedAt: DateTime.now(),
      );
      await saveChat(updated);
    } else {
      await chatsBox.delete(id);
    }
  }

  @override
  List<ChatModel> getPendingImageChats() {
    final list = <ChatModel>[];
    for (final key in chatsBox.keys) {
      final raw = chatsBox.get(key);
      if (raw is Map) {
        final chat = ChatModel.fromHiveMap(raw);
        if (chat.pendingImagePath != null &&
            chat.pendingImagePath!.isNotEmpty) {
          list.add(chat);
        }
      }
    }
    return list;
  }

  @override
  Future<void> clear() async {
    await chatsBox.clear();
  }
}

