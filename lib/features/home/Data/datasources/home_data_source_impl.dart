import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/category_model.dart';
import '../models/chat_model.dart';
import 'home_data_source.dart';

class HomeDataSourceImpl implements HomeDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  HomeDataSourceImpl({FirebaseFirestore? firestore, FirebaseAuth? firebaseAuth})
    : firestore = firestore ?? FirebaseFirestore.instance,
      firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<List<ChatModel>> getChats() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('chats')
        .get();

    final chats = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return ChatModel.fromJson(data);
    }).toList();

    chats.sort((a, b) {
      if (a.boolIsPin != b.boolIsPin) {
        return a.boolIsPin ? -1 : 1;
      }
      final aDate =
          a.datecreateChat ?? a.date ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bDate =
          b.datecreateChat ?? b.date ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bDate.compareTo(aDate);
    });

    return chats;
  }

  @override
  Future<void> addChat(ChatModel chat) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final chatsCollection = firestore
        .collection('users')
        .doc(user.uid)
        .collection('chats');

    final docRef = chat.id.isNotEmpty
        ? chatsCollection.doc(chat.id)
        : chatsCollection.doc();

    final chatToSave = chat.copyWith(
      id: docRef.id,
      datecreateChat: chat.datecreateChat ?? DateTime.now(),
      date: chat.date ?? DateTime.now(),
    );

    await docRef.set(chatToSave.toJson(), SetOptions(merge: true));
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('categories')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return CategoryModel.fromJson(data);
    }).toList();
  }

  @override
  Future<CategoryModel> addCategory(String name) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final collection = firestore
        .collection('users')
        .doc(user.uid)
        .collection('categories');

    final docRef = collection.doc();
    final category = CategoryModel(id: docRef.id, name: name);
    await docRef.set(category.toJson());
    return category;
  }
}
