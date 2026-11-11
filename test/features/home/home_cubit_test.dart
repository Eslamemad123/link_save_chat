import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_savw_chat/features/home/Data/datasources/home_data_source.dart';
import 'package:link_savw_chat/features/home/Data/models/category_model.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';
import 'package:link_savw_chat/features/home/Presentation/cubit/home_cubit.dart';
import 'package:link_savw_chat/features/home/Presentation/cubit/home_state.dart';

class MockHomeDataSource implements HomeDataSource {
  final List<ChatModel> _chats;
  final List<CategoryModel> _categories;

  MockHomeDataSource({List<ChatModel>? chats, List<CategoryModel>? categories})
    : _chats = chats ?? [],
      _categories = categories ?? [];

  @override
  Future<List<ChatModel>> getChats() async => _chats;

  @override
  Future<void> addChat(ChatModel chat) async {
    _chats.add(chat);
  }

  @override
  Future<List<CategoryModel>> getCategories() async =>
      List<CategoryModel>.from(_categories);

  @override
  Future<CategoryModel> addCategory(String name) async {
    final cat = CategoryModel(id: 'cat_${_categories.length + 1}', name: name);
    _categories.add(cat);
    return cat;
  }
}

class FailingHomeDataSource implements HomeDataSource {
  final Object error;

  FailingHomeDataSource(this.error);

  @override
  Future<List<ChatModel>> getChats() async => throw error;

  @override
  Future<void> addChat(ChatModel chat) async => throw error;

  @override
  Future<List<CategoryModel>> getCategories() async => throw error;

  @override
  Future<CategoryModel> addCategory(String name) async => throw error;
}

void main() {
  group('HomeCubit Tests', () {
    test('initial state has default values', () {
      final cubit = HomeCubit(dataSource: MockHomeDataSource());
      expect(cubit.state.status, HomeStatus.initial);
      expect(cubit.state.selectedFilter, HomeState.filterAll);
      expect(cubit.state.allChats, isEmpty);
      expect(cubit.state.categories, isEmpty);
    });

    test('loadChats returns empty list when data source is empty', () async {
      final cubit = HomeCubit(dataSource: MockHomeDataSource(chats: []));
      await cubit.loadChats();

      expect(cubit.state.status, HomeStatus.success);
      expect(cubit.state.allChats, isEmpty);
      expect(cubit.state.filteredChats, isEmpty);
      expect(cubit.state.totalUnreadChatCount, 0);
    });

    test('loadChats populates real chats from data source', () async {
      final cubit = HomeCubit(
        dataSource: MockHomeDataSource(chats: List.of(HomeCubit.mockChats)),
      );
      await cubit.loadChats();

      expect(cubit.state.status, HomeStatus.success);
      expect(cubit.state.allChats.length, 6);
      expect(cubit.state.filteredChats.length, 6);
      expect(cubit.state.totalUnreadChatCount, greaterThan(0));
    });

    test('loadChats preserves existing chats on refresh failure', () async {
      final cubit = HomeCubit(
        dataSource: MockHomeDataSource(chats: List.of(HomeCubit.mockChats)),
      );
      await cubit.loadChats();
      expect(cubit.state.allChats.length, 6);

      final failingCubit = HomeCubit(
        dataSource: FailingHomeDataSource(
          FirebaseException(plugin: 'cloud_firestore', code: 'unavailable'),
        ),
      );
      await failingCubit.loadChats();
      expect(failingCubit.state.status, HomeStatus.failure);
      expect(
        failingCubit.state.errorMessage,
        'Network error. Please check your connection.',
      );
    });

    test('changeFilter filters chats correctly', () async {
      final cubit = HomeCubit(
        dataSource: MockHomeDataSource(chats: List.of(HomeCubit.mockChats)),
      );
      await cubit.loadChats();

      await cubit.addCategory('important');
      cubit.changeFilter('important');
      expect(cubit.state.selectedFilter, 'important');
      expect(cubit.state.filteredChats.length, 1);

      cubit.changeFilter(HomeState.filterAll);
      expect(cubit.state.selectedFilter, HomeState.filterAll);
      expect(cubit.state.filteredChats.length, 6);
    });

    test('addCategory adds category and updates state on success', () async {
      final cubit = HomeCubit(dataSource: MockHomeDataSource());
      await cubit.loadChats();

      final result = await cubit.addCategory('Work');
      expect(result, isTrue);
      expect(cubit.state.categories.length, 1);
      expect(cubit.state.categories.first.name, 'Work');
    });

    test('addCategory returns false and emits failure on error', () async {
      final cubit = HomeCubit(
        dataSource: FailingHomeDataSource(
          FirebaseException(
            plugin: 'cloud_firestore',
            code: 'permission-denied',
          ),
        ),
      );

      final result = await cubit.addCategory('Work');
      expect(result, isFalse);
      expect(cubit.state.status, HomeStatus.failure);
      expect(
        cubit.state.errorMessage,
        'Permission denied. You do not have access.',
      );
    });

    test('addChat returns true and reloads chats on success', () async {
      final cubit = HomeCubit(dataSource: MockHomeDataSource());
      final newChat = ChatModel(
        id: 'new_1',
        name: 'New Chat',
        description: 'New Description',
        lastMessage: 'Hello',
        color_backgroung_icon: 0xFF2196F3,
        nummessage: 0,
        category: 'all',
        date: DateTime.now(),
        boolIsPin: false,
      );

      final result = await cubit.addChat(newChat);
      expect(result, isTrue);
      expect(cubit.state.allChats.length, 1);
      expect(cubit.state.allChats.first.name, 'New Chat');
    });

    test('addChat returns false and emits failure on error', () async {
      final cubit = HomeCubit(
        dataSource: FailingHomeDataSource(
          FirebaseException(
            plugin: 'cloud_firestore',
            code: 'deadline-exceeded',
          ),
        ),
      );
      final newChat = ChatModel(
        id: 'new_1',
        name: 'New Chat',
        description: 'New Description',
        lastMessage: 'Hello',
        color_backgroung_icon: 0xFF2196F3,
        nummessage: 0,
        category: 'all',
        date: DateTime.now(),
        boolIsPin: false,
      );

      final result = await cubit.addChat(newChat);
      expect(result, isFalse);
      expect(cubit.state.status, HomeStatus.failure);
      expect(cubit.state.errorMessage, 'Request timed out. Please try again.');
    });

    test('searchChats filters by query', () async {
      final cubit = HomeCubit(
        dataSource: MockHomeDataSource(chats: List.of(HomeCubit.mockChats)),
      );
      await cubit.loadChats();

      cubit.searchChats('Coding');
      expect(cubit.state.filteredChats.length, 1);
      expect(cubit.state.filteredChats.first.name, 'Coding Links');

      cubit.searchChats('');
      expect(cubit.state.filteredChats.length, 6);
    });
  });
}
