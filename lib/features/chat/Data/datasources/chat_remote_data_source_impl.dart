import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_remote_data_source.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ChatRemoteDataSourceImpl({
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
}

