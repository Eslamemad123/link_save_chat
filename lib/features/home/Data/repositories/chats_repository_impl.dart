import 'dart:io';

import '../../../../core/services/cloudinary/image_upload.dart';
import '../../Domain/repositories/chats_repository.dart';
import '../datasources/categories_local_data_source.dart';
import '../datasources/chats_local_data_source.dart';
import '../datasources/chats_remote_data_source.dart';
import '../models/category_model.dart';
import '../models/chat_model.dart';

class ChatsRepositoryImpl implements ChatsRepository {
  final ChatsLocalDataSource chatsLocalDataSource;
  final CategoriesLocalDataSource categoriesLocalDataSource;
  final ChatsRemoteDataSource chatsRemoteDataSource;

  ChatsRepositoryImpl({
    required this.chatsLocalDataSource,
    required this.categoriesLocalDataSource,
    required this.chatsRemoteDataSource,
  });

  @override
  Stream<List<ChatModel>> watchChats() {
    return chatsLocalDataSource.watchChats();
  }

  @override
  Stream<List<CategoryModel>> watchCategories() {
    return categoriesLocalDataSource.watchCategories();
  }

  @override
  List<ChatModel> getCachedChats() {
    return chatsLocalDataSource.getAllChats();
  }

  @override
  List<CategoryModel> getCachedCategories() {
    return categoriesLocalDataSource.getAllCategories();
  }

  @override
  Future<void> createChat(ChatModel chat, {File? imageFile}) async {
    final chatId =
        chat.id.isNotEmpty ? chat.id : chatsRemoteDataSource.generateChatId();
    final now = DateTime.now();

    final localChat = chat.copyWith(
      id: chatId,
      createdAt: now,
      updatedAt: now,
      deleted: false,
      image: imageFile != null ? imageFile.path : chat.image,
      pendingImagePath: imageFile?.path,
    );

    await chatsLocalDataSource.saveChat(localChat);

    chatsRemoteDataSource.pushChat(localChat.toFirestoreJson(isCreate: true));

    if (imageFile != null) {
      _uploadAndSyncChatImage(chatId, imageFile);
    }
  }

  void _uploadAndSyncChatImage(String chatId, File file) {
    uploadChatImageBackground(file).then((secureUrl) async {
      if (secureUrl != null && secureUrl.isNotEmpty) {
        final current = chatsLocalDataSource.getChat(chatId);
        if (current != null) {
          final updated = current.copyWith(
            image: secureUrl,
            clearPendingImage: true,
            updatedAt: DateTime.now(),
          );
          await chatsLocalDataSource.saveChat(updated);
        }

        chatsRemoteDataSource.updateChatFields(chatId, {
          'image': secureUrl,
          'iconUrl': secureUrl,
        });
      }
    }).catchError((_) {});
  }

  @override
  Future<CategoryModel> addCategory(String name) async {
    final id = chatsRemoteDataSource.generateCategoryId();
    final now = DateTime.now();

    final category = CategoryModel(
      id: id,
      name: name,
      createdAt: now,
      updatedAt: now,
      deleted: false,
    );

    await categoriesLocalDataSource.saveCategory(category);

    chatsRemoteDataSource.pushCategory(category.toFirestoreJson(isCreate: true));

    return category;
  }

  @override
  Future<void> retryPendingUpload(String chatId) async {
    final chat = chatsLocalDataSource.getChat(chatId);
    if (chat != null &&
        chat.pendingImagePath != null &&
        chat.pendingImagePath!.isNotEmpty) {
      final file = File(chat.pendingImagePath!);
      if (file.existsSync()) {
        _uploadAndSyncChatImage(chatId, file);
      } else {
        await chatsLocalDataSource.saveChat(
          chat.copyWith(clearPendingImage: true),
        );
      }
    }
  }
}
