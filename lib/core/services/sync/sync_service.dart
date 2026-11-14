import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import '../../../../features/home/Data/datasources/categories_local_data_source.dart';
import '../../../../features/home/Data/datasources/chats_local_data_source.dart';
import '../../../../features/home/Data/datasources/chats_remote_data_source.dart';
import '../../../../features/home/Domain/repositories/chats_repository.dart';

class SyncService {
  final ChatsLocalDataSource chatsLocalDataSource;
  final CategoriesLocalDataSource categoriesLocalDataSource;
  final ChatsRemoteDataSource chatsRemoteDataSource;
  final ChatsRepository chatsRepository;
  final Box metaBox;
  final FirebaseAuth firebaseAuth;

  StreamSubscription<User?>? _authSub;
  StreamSubscription? _chatsSub;
  StreamSubscription? _categoriesSub;
  String? _activeUid;

  SyncService({
    required this.chatsLocalDataSource,
    required this.categoriesLocalDataSource,
    required this.chatsRemoteDataSource,
    required this.chatsRepository,
    required this.metaBox,
    required this.firebaseAuth,
  });

  void start() {
    _authSub?.cancel();
    _authSub = firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        if (_activeUid != user.uid) {
          _onUserAuthenticated(user.uid);
        }
      }
    });

    final currentUser = firebaseAuth.currentUser;
    if (currentUser != null && _activeUid == null) {
      _onUserAuthenticated(currentUser.uid);
    }
  }

  void stop() {
    _chatsSub?.cancel();
    _categoriesSub?.cancel();
    _authSub?.cancel();
    _activeUid = null;
  }

  Future<void> _onUserAuthenticated(String uid) async {
    _activeUid = uid;
    await _syncChats(uid);
    await _syncCategories(uid);
    _retryPendingImageUploads();
  }

  Future<void> _syncChats(String uid) async {
    final key = 'lastSyncChats_$uid';
    int lastSync = metaBox.get(key, defaultValue: 0) as int;

    if (lastSync == 0) {
      try {
        final remoteDocs = await chatsRemoteDataSource.fetchAllChats();
        int maxUpdatedAt = 0;

        for (final doc in remoteDocs) {
          final id = doc['id']?.toString() ?? '';
          if (id.isEmpty) continue;

          final isDeleted = doc['deleted'] == true;
          if (isDeleted) {
            await chatsLocalDataSource.removeChat(id);
          } else {
            await chatsLocalDataSource.putRawPreservingPendingImage(id, doc);
          }

          final updatedAt = _extractEpochMs(
            doc['updatedAt'] ?? doc['createdAt'] ?? doc['datecreateChat'],
          );
          if (updatedAt > maxUpdatedAt) {
            maxUpdatedAt = updatedAt;
          }
        }

        if (maxUpdatedAt > 0) {
          await metaBox.put(key, maxUpdatedAt);
          lastSync = maxUpdatedAt;
        }
      } catch (_) {}
    }

    _chatsSub?.cancel();
    _chatsSub = chatsRemoteDataSource
        .watchChatChanges(sinceEpochMs: lastSync)
        .listen((changes) async {
      int currentMax = lastSync;

      for (final change in changes) {
        if (change.hasPendingWrites || change.updatedAtMs == null) {
          continue;
        }

        if (change.isDeleted) {
          await chatsLocalDataSource.removeChat(change.chatId);
        } else {
          await chatsLocalDataSource.putRawPreservingPendingImage(
            change.chatId,
            change.hiveData,
          );
        }

        if (change.updatedAtMs != null && change.updatedAtMs! > currentMax) {
          currentMax = change.updatedAtMs!;
        }
      }

      if (currentMax > lastSync) {
        lastSync = currentMax;
        await metaBox.put(key, currentMax);
      }
    });
  }

  Future<void> _syncCategories(String uid) async {
    final key = 'lastSyncCategories_$uid';
    int lastSync = metaBox.get(key, defaultValue: 0) as int;

    if (lastSync == 0) {
      try {
        final remoteDocs = await chatsRemoteDataSource.fetchAllCategories();
        int maxUpdatedAt = 0;

        for (final doc in remoteDocs) {
          final id = doc['id']?.toString() ?? '';
          if (id.isEmpty) continue;

          final isDeleted = doc['deleted'] == true;
          if (isDeleted) {
            await categoriesLocalDataSource.removeCategory(id);
          } else {
            await categoriesLocalDataSource.putRaw(id, doc);
          }

          final updatedAt = _extractEpochMs(
            doc['updatedAt'] ?? doc['createdAt'],
          );
          if (updatedAt > maxUpdatedAt) {
            maxUpdatedAt = updatedAt;
          }
        }

        if (maxUpdatedAt > 0) {
          await metaBox.put(key, maxUpdatedAt);
          lastSync = maxUpdatedAt;
        }
      } catch (_) {}
    }

    _categoriesSub?.cancel();
    _categoriesSub = chatsRemoteDataSource
        .watchCategoryChanges(sinceEpochMs: lastSync)
        .listen((changes) async {
      int currentMax = lastSync;

      for (final change in changes) {
        if (change.hasPendingWrites || change.updatedAtMs == null) {
          continue;
        }

        if (change.isDeleted) {
          await categoriesLocalDataSource.removeCategory(change.categoryId);
        } else {
          await categoriesLocalDataSource.putRaw(
            change.categoryId,
            change.hiveData,
          );
        }

        if (change.updatedAtMs != null && change.updatedAtMs! > currentMax) {
          currentMax = change.updatedAtMs!;
        }
      }

      if (currentMax > lastSync) {
        lastSync = currentMax;
        await metaBox.put(key, currentMax);
      }
    });
  }

  void _retryPendingImageUploads() {
    final pendingChats = chatsLocalDataSource.getPendingImageChats();
    for (final chat in pendingChats) {
      final path = chat.pendingImagePath;
      if (path != null && path.isNotEmpty) {
        final file = File(path);
        if (file.existsSync()) {
          chatsRepository.retryPendingUpload(chat.id);
        } else {
          chatsLocalDataSource.saveChat(
            chat.copyWith(clearPendingImage: true),
          );
        }
      }
    }
  }

  int _extractEpochMs(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is Timestamp) return value.millisecondsSinceEpoch;
    if (value is DateTime) return value.millisecondsSinceEpoch;
    if (value is String) {
      final parsedInt = int.tryParse(value);
      if (parsedInt != null) return parsedInt;
      final parsedDate = DateTime.tryParse(value);
      if (parsedDate != null) return parsedDate.millisecondsSinceEpoch;
    }
    return 0;
  }
}

