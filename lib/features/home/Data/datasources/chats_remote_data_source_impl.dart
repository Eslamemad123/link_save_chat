import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/remote_category_change.dart';
import '../models/remote_chat_change.dart';
import 'chats_remote_data_source.dart';

class ChatsRemoteDataSourceImpl implements ChatsRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ChatsRemoteDataSourceImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? firebaseAuth,
  })  : firestore = firestore ?? FirebaseFirestore.instance,
        firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  String _requireUid() {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> _chatsCollection() {
    return firestore
        .collection('users')
        .doc(_requireUid())
        .collection('chats');
  }

  CollectionReference<Map<String, dynamic>> _categoriesCollection() {
    return firestore
        .collection('users')
        .doc(_requireUid())
        .collection('categories');
  }

  @override
  String generateChatId() {
    return _chatsCollection().doc().id;
  }

  @override
  String generateCategoryId() {
    return _categoriesCollection().doc().id;
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllChats() async {
    final snapshot = await _chatsCollection().get();
    return snapshot.docs.map((doc) {
      final data = Map<String, dynamic>.from(doc.data());
      data['id'] = doc.id;
      return _convertTimestampsToMillis(data);
    }).toList();
  }

  @override
  Stream<List<RemoteChatChange>> watchChatChanges({
    required int sinceEpochMs,
  }) {
    final query = sinceEpochMs > 0
        ? _chatsCollection().where(
            'updatedAt',
            isGreaterThanOrEqualTo:
                Timestamp.fromMillisecondsSinceEpoch(sinceEpochMs),
          )
        : _chatsCollection();

    return query.snapshots().map((snapshot) {
      final changes = <RemoteChatChange>[];

      for (final docChange in snapshot.docChanges) {
        final doc = docChange.doc;
        final rawData = doc.data();
        if (rawData == null) continue;

        final hasPendingWrites = doc.metadata.hasPendingWrites;
        final rawUpdatedAt = rawData['updatedAt'];

        int? updatedAtMs;
        if (rawUpdatedAt is Timestamp) {
          updatedAtMs = rawUpdatedAt.millisecondsSinceEpoch;
        } else if (rawUpdatedAt is int) {
          updatedAtMs = rawUpdatedAt;
        }

        final data = Map<String, dynamic>.from(rawData);
        data['id'] = doc.id;
        final hiveData = _convertTimestampsToMillis(data);

        final isDeleted = rawData['deleted'] == true ||
            docChange.type == DocumentChangeType.removed;

        changes.add(
          RemoteChatChange(
            chatId: doc.id,
            hiveData: hiveData,
            updatedAtMs: updatedAtMs,
            hasPendingWrites: hasPendingWrites,
            isDeleted: isDeleted,
          ),
        );
      }

      return changes;
    });
  }

  @override
  void pushChat(Map<String, dynamic> data) {
    try {
      final id = data['id']?.toString();
      if (id == null || id.isEmpty) return;

      final docRef = _chatsCollection().doc(id);
      final payload = Map<String, dynamic>.from(data);
      payload['updatedAt'] = FieldValue.serverTimestamp();

      docRef.set(payload, SetOptions(merge: true)).catchError((_) {});
    } catch (_) {}
  }

  @override
  void updateChatFields(String chatId, Map<String, dynamic> fields) {
    try {
      final docRef = _chatsCollection().doc(chatId);
      final payload = Map<String, dynamic>.from(fields);
      payload['updatedAt'] = FieldValue.serverTimestamp();

      docRef.set(payload, SetOptions(merge: true)).catchError((_) {});
    } catch (_) {}
  }

  @override
  void softDeleteChat(String chatId) {
    try {
      final docRef = _chatsCollection().doc(chatId);
      docRef.set({
        'deleted': true,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)).catchError((_) {});
    } catch (_) {}
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllCategories() async {
    final snapshot = await _categoriesCollection().get();
    return snapshot.docs.map((doc) {
      final data = Map<String, dynamic>.from(doc.data());
      data['id'] = doc.id;
      return _convertTimestampsToMillis(data);
    }).toList();
  }

  @override
  Stream<List<RemoteCategoryChange>> watchCategoryChanges({
    required int sinceEpochMs,
  }) {
    final query = sinceEpochMs > 0
        ? _categoriesCollection().where(
            'updatedAt',
            isGreaterThanOrEqualTo:
                Timestamp.fromMillisecondsSinceEpoch(sinceEpochMs),
          )
        : _categoriesCollection();

    return query.snapshots().map((snapshot) {
      final changes = <RemoteCategoryChange>[];

      for (final docChange in snapshot.docChanges) {
        final doc = docChange.doc;
        final rawData = doc.data();
        if (rawData == null) continue;

        final hasPendingWrites = doc.metadata.hasPendingWrites;
        final rawUpdatedAt = rawData['updatedAt'];

        int? updatedAtMs;
        if (rawUpdatedAt is Timestamp) {
          updatedAtMs = rawUpdatedAt.millisecondsSinceEpoch;
        } else if (rawUpdatedAt is int) {
          updatedAtMs = rawUpdatedAt;
        }

        final data = Map<String, dynamic>.from(rawData);
        data['id'] = doc.id;
        final hiveData = _convertTimestampsToMillis(data);

        final isDeleted = rawData['deleted'] == true ||
            docChange.type == DocumentChangeType.removed;

        changes.add(
          RemoteCategoryChange(
            categoryId: doc.id,
            name: rawData['name']?.toString() ?? '',
            hiveData: hiveData,
            updatedAtMs: updatedAtMs,
            hasPendingWrites: hasPendingWrites,
            isDeleted: isDeleted,
          ),
        );
      }

      return changes;
    });
  }

  @override
  void pushCategory(Map<String, dynamic> data) {
    try {
      final id = data['id']?.toString();
      if (id == null || id.isEmpty) return;

      final docRef = _categoriesCollection().doc(id);
      final payload = Map<String, dynamic>.from(data);
      payload['updatedAt'] = FieldValue.serverTimestamp();

      docRef.set(payload, SetOptions(merge: true)).catchError((_) {});
    } catch (_) {}
  }

  @override
  void softDeleteCategory(String categoryId) {
    try {
      final docRef = _categoriesCollection().doc(categoryId);
      docRef.set({
        'deleted': true,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)).catchError((_) {});
    } catch (_) {}
  }

  Map<String, dynamic> _convertTimestampsToMillis(Map<String, dynamic> input) {
    final result = <String, dynamic>{};

    for (final entry in input.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is Timestamp) {
        result[key] = value.millisecondsSinceEpoch;
      } else if (value is DateTime) {
        result[key] = value.millisecondsSinceEpoch;
      } else {
        result[key] = value;
      }
    }

    if (!result.containsKey('deleted') || result['deleted'] == null) {
      result['deleted'] = false;
    }

    return result;
  }
}

