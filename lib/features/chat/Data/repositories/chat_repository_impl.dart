import 'dart:io';

import '../../../../core/services/cloudinary/image_upload.dart';
import '../../../home/Data/models/chat_model.dart';
import '../../Domain/repositories/chat_repository.dart';
import '../datasources/chat_local_data_source.dart';
import '../datasources/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource chatLocalDataSource;
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatRepositoryImpl({
    required this.chatLocalDataSource,
    required this.chatRemoteDataSource,
  });

  @override
  ChatModel? getChat(String chatId) {
    return chatLocalDataSource.getChat(chatId);
  }

  @override
  Stream<ChatModel?> watchChat(String chatId) {
    return chatLocalDataSource.watchChat(chatId);
  }

  @override
  Future<void> updateChat(ChatModel chat, {File? newImageFile}) async {
    final now = DateTime.now();

    final localChat = chat.copyWith(
      updatedAt: now,
      image: newImageFile != null ? newImageFile.path : chat.image,
      pendingImagePath: newImageFile != null
          ? newImageFile.path
          : chat.pendingImagePath,
    );

    await chatLocalDataSource.saveChat(localChat);

    chatRemoteDataSource.updateChatFields(
      chat.id,
      localChat.toFirestoreJson(isCreate: false),
    );

    if (newImageFile != null) {
      _uploadAndSyncChatImage(chat.id, newImageFile);
    }
  }

  void _uploadAndSyncChatImage(String chatId, File file) {
    uploadChatImageBackground(file).then((secureUrl) async {
      if (secureUrl != null && secureUrl.isNotEmpty) {
        final current = chatLocalDataSource.getChat(chatId);
        if (current != null) {
          final updated = current.copyWith(
            image: secureUrl,
            clearPendingImage: true,
            updatedAt: DateTime.now(),
          );
          await chatLocalDataSource.saveChat(updated);
        }

        chatRemoteDataSource.updateChatFields(chatId, {
          'image': secureUrl,
        });
      }
    }).catchError((_) {});
  }

  @override
  Future<void> togglePin(String chatId, bool isPinned) async {
    final existing = chatLocalDataSource.getChat(chatId);
    if (existing != null) {
      final updated = existing.copyWith(
        boolIsPin: isPinned,
        updatedAt: DateTime.now(),
      );
      await chatLocalDataSource.saveChat(updated);
    }

    chatRemoteDataSource.updateChatFields(chatId, {
      'boolIsPin': isPinned,
    });
  }

  @override
  Future<void> toggleMute(String chatId, bool isMuted) async {
    final existing = chatLocalDataSource.getChat(chatId);
    if (existing != null) {
      final updated = existing.copyWith(
        boolNotification: !isMuted,
        updatedAt: DateTime.now(),
      );
      await chatLocalDataSource.saveChat(updated);
    }

    chatRemoteDataSource.updateChatFields(chatId, {
      'boolNotification': !isMuted,
    });
  }

  @override
  Future<void> updateWallpaper(String chatId, String? wallpaper) async {
    final existing = chatLocalDataSource.getChat(chatId);
    if (existing != null) {
      final updated = existing.copyWith(
        wallpaper: wallpaper,
        updatedAt: DateTime.now(),
      );
      await chatLocalDataSource.saveChat(updated);
    }

    chatRemoteDataSource.updateChatFields(chatId, {
      'wallpaper': wallpaper,
    });
  }

  @override
  Future<void> clearChatMessages(String chatId) async {
    await chatLocalDataSource.clearChatMessages(chatId);

    chatRemoteDataSource.updateChatFields(chatId, {
      'nummessage': 0,
      'lastMessage': '',
    });
  }

  @override
  Future<void> deleteChat(String chatId) async {
    await chatLocalDataSource.markDeleted(chatId);
    chatRemoteDataSource.softDeleteChat(chatId);
  }
}

