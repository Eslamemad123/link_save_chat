import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:link_savw_chat/features/chat/Domain/repositories/chat_repository.dart';
import 'package:link_savw_chat/features/chat/Presentation/cubit/chat_cubit.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';

class MockChatRepository implements ChatRepository {
  ChatModel? chat;
  final StreamController<ChatModel?> _controller =
      StreamController<ChatModel?>.broadcast();

  MockChatRepository({this.chat});

  @override
  ChatModel? getChat(String chatId) => chat;

  @override
  Stream<ChatModel?> watchChat(String chatId) => _controller.stream;

  @override
  Future<void> updateChat(ChatModel updatedChat, {File? newImageFile}) async {
    chat = updatedChat;
    _controller.add(chat);
  }

  @override
  Future<void> togglePin(String chatId, bool isPinned) async {
    if (chat != null) {
      chat = chat!.copyWith(boolIsPin: isPinned);
      _controller.add(chat);
    }
  }

  @override
  Future<void> toggleMute(String chatId, bool isMuted) async {
    if (chat != null) {
      chat = chat!.copyWith(boolNotification: !isMuted);
      _controller.add(chat);
    }
  }

  @override
  Future<void> updateWallpaper(String chatId, String? wallpaper) async {
    if (chat != null) {
      chat = chat!.copyWith(wallpaper: wallpaper);
      _controller.add(chat);
    }
  }

  @override
  Future<void> clearChatMessages(String chatId) async {
    if (chat != null) {
      chat = chat!.copyWith(nummessage: 0, lastMessage: '');
      _controller.add(chat);
    }
  }

  @override
  Future<void> deleteChat(String chatId) async {
    if (chat != null) {
      chat = chat!.copyWith(deleted: true);
      _controller.add(chat);
    }
  }

  void dispose() {
    _controller.close();
  }
}

void main() {
  group('ChatCubit Tests', () {
    const initialChat = ChatModel(
      id: 'chat_1',
      name: 'Flutter Tasks',
      description: 'Clean Architecture',
      color_backgroung_icon: 0xFF123456,
      nummessage: 5,
      category: 'work',
      boolNotification: true,
      boolIsPin: false,
    );

    late MockChatRepository mockRepo;
    late ChatCubit cubit;

    setUp(() {
      mockRepo = MockChatRepository(chat: initialChat);
      cubit = ChatCubit(repository: mockRepo, initialChat: initialChat);
    });

    tearDown(() {
      cubit.close();
      mockRepo.dispose();
    });

    test('initial state contains initial chat values', () {
      expect(cubit.state.chat.id, 'chat_1');
      expect(cubit.state.isPinned, isFalse);
      expect(cubit.state.isMuted, isFalse);
      expect(cubit.state.isDeleted, isFalse);
    });

    test('togglePin updates pin state', () async {
      await cubit.togglePin(true);
      expect(cubit.state.isPinned, isTrue);
      expect(mockRepo.chat?.boolIsPin, isTrue);

      await cubit.togglePin(false);
      expect(cubit.state.isPinned, isFalse);
    });

    test('toggleMute updates notification state', () async {
      await cubit.toggleMute(true);
      expect(cubit.state.isMuted, isTrue);
      expect(mockRepo.chat?.boolNotification, isFalse);

      await cubit.toggleMute(false);
      expect(cubit.state.isMuted, isFalse);
    });

    test('clearChatMessages resets unread count and last message', () async {
      await cubit.clearChatMessages();
      expect(cubit.state.chat.nummessage, 0);
      expect(cubit.state.chat.lastMessage, isEmpty);
    });

    test('deleteChat marks state as deleted', () async {
      await cubit.deleteChat();
      expect(cubit.state.isDeleted, isTrue);
    });

    test('updateChat updates chat properties', () async {
      final updated = initialChat.copyWith(name: 'Updated Name');
      final result = await cubit.updateChat(updated);
      expect(result, isTrue);
      expect(cubit.state.chat.name, 'Updated Name');
    });
  });
}
