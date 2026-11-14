import 'package:flutter_test/flutter_test.dart';
import 'package:link_savw_chat/features/home/Data/models/category_model.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';

void main() {
  group('ChatModel Local-First & Sync Conversion Tests', () {
    test('ChatModel toHiveMap and fromHiveMap roundtrip preserves all fields', () {
      final now = DateTime.now();
      final chat = ChatModel(
        id: 'chat_123',
        name: 'Dev Links',
        description: 'Flutter links',
        lastMessage: 'Check this out',
        image: 'https://res.cloudinary.com/demo/image/upload/sample.jpg',
        color_backgroung_icon: 0xFF123456,
        nummessage: 3,
        date: now,
        time: '12:00 PM',
        category: 'work',
        datecreateChat: now,
        wallpaper: 'default',
        boolNotification: true,
        boolIsPin: true,
        createdAt: now,
        updatedAt: now,
        deleted: false,
        pendingImagePath: '/data/user/0/app/cache/local_image.jpg',
      );

      final hiveMap = chat.toHiveMap();
      expect(hiveMap['id'], 'chat_123');
      expect(hiveMap['pendingImagePath'], '/data/user/0/app/cache/local_image.jpg');
      expect(hiveMap['updatedAt'], now.millisecondsSinceEpoch);
      expect(hiveMap['deleted'], false);

      final reconstructed = ChatModel.fromHiveMap(hiveMap);
      expect(reconstructed.id, chat.id);
      expect(reconstructed.name, chat.name);
      expect(reconstructed.pendingImagePath, chat.pendingImagePath);
      expect(reconstructed.boolIsPin, true);
      expect(reconstructed.displayImage, '/data/user/0/app/cache/local_image.jpg');
    });

    test('ChatModel displayImage prefers pendingImagePath over remote image', () {
      const chat = ChatModel(
        id: '1',
        name: 'Test',
        description: '',
        color_backgroung_icon: 0,
        nummessage: 0,
        category: 'all',
        image: 'https://res.cloudinary.com/demo/remote.jpg',
        pendingImagePath: '/local/cache/picked.jpg',
      );

      expect(chat.displayImage, '/local/cache/picked.jpg');

      final uploadedChat = chat.copyWith(clearPendingImage: true);
      expect(uploadedChat.displayImage, 'https://res.cloudinary.com/demo/remote.jpg');
    });

    test('toFirestoreJson never sends pendingImagePath and never sends raw local path', () {
      const localOnlyChat = ChatModel(
        id: '1',
        name: 'Local Pick Chat',
        description: '',
        color_backgroung_icon: 0,
        nummessage: 0,
        category: 'all',
        image: '/local/path/avatar.png',
        pendingImagePath: '/local/path/avatar.png',
      );

      final firestoreData = localOnlyChat.toFirestoreJson(isCreate: true);
      expect(firestoreData.containsKey('pendingImagePath'), isFalse);
      expect(firestoreData['image'], isNull);
      expect(firestoreData['iconUrl'], isNull);
    });

    test('ChatModel fromHiveMap handles iconUrl and image_or_icon schemas', () {
      final hiveMap1 = {
        'id': 'legacy_icon',
        'title': 'Legacy Icon Chat',
        'iconUrl': 'https://res.cloudinary.com/demo/icon.jpg',
        'uncompletedCount': 5,
        'isPinned': true,
      };

      final chat1 = ChatModel.fromHiveMap(hiveMap1);
      expect(chat1.id, 'legacy_icon');
      expect(chat1.name, 'Legacy Icon Chat');
      expect(chat1.image, 'https://res.cloudinary.com/demo/icon.jpg');
      expect(chat1.nummessage, 5);
      expect(chat1.boolIsPin, isTrue);

      final hiveMap2 = {
        'id': 'legacy_image_or_icon',
        'name': 'Image Or Icon Chat',
        'image_or_icon': 'https://res.cloudinary.com/demo/image_or_icon.jpg',
      };

      final chat2 = ChatModel.fromHiveMap(hiveMap2);
      expect(chat2.image, 'https://res.cloudinary.com/demo/image_or_icon.jpg');
    });

    test('ChatModel copyWith clears image when clearImage is true', () {
      const chat = ChatModel(
        id: '1',
        name: 'Chat',
        description: '',
        color_backgroung_icon: 0,
        nummessage: 0,
        category: 'all',
        image: 'https://res.cloudinary.com/demo/img.jpg',
      );

      final cleared = chat.copyWith(clearImage: true);
      expect(cleared.image, isNull);
    });
  });

  group('CategoryModel Local-First & Sync Conversion Tests', () {
    test('CategoryModel toHiveMap and fromHiveMap roundtrip', () {
      final now = DateTime.now();
      final cat = CategoryModel(
        id: 'cat_1',
        name: 'Work',
        createdAt: now,
        updatedAt: now,
        deleted: false,
      );

      final hiveMap = cat.toHiveMap();
      expect(hiveMap['id'], 'cat_1');
      expect(hiveMap['name'], 'Work');
      expect(hiveMap['deleted'], false);

      final reconstructed = CategoryModel.fromHiveMap(hiveMap);
      expect(reconstructed.id, cat.id);
      expect(reconstructed.name, cat.name);
      expect(reconstructed.deleted, false);
    });

    test('CategoryModel fromJson handles legacy docs missing deleted or updatedAt', () {
      final legacyJson = {
        'id': 'legacy_1',
        'name': 'Legacy Cat',
      };

      final cat = CategoryModel.fromJson(legacyJson);
      expect(cat.id, 'legacy_1');
      expect(cat.name, 'Legacy Cat');
      expect(cat.deleted, isFalse);
    });
  });
}

