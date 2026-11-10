import 'package:flutter_test/flutter_test.dart';
import 'package:link_savw_chat/features/home/Data/datasources/home_data_source.dart';
import 'package:link_savw_chat/features/home/Data/models/category_model.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';
import 'package:link_savw_chat/features/home/Presentation/cubit/home_cubit.dart';
import 'package:link_savw_chat/features/home/Presentation/cubit/home_state.dart';

class MockHomeDataSource implements HomeDataSource {
  final List<ChatModel> _chats;
  final List<CategoryModel> _categories;

  MockHomeDataSource({
    List<ChatModel>? chats,
    List<CategoryModel>? categories,
  })  : _chats = chats ?? [],
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
    final cat = CategoryModel(
      id: 'cat_${_categories.length + 1}',
      name: name,
    );
    _categories.add(cat);
    return cat;
  }
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

    test('loadChats loads fallback mock items when data source is empty', () async {
      final cubit = HomeCubit(dataSource: MockHomeDataSource());
      await cubit.loadChats();

      expect(cubit.state.status, HomeStatus.success);
      expect(cubit.state.allChats.length, 6);
      expect(cubit.state.filteredChats.length, 6);
      expect(cubit.state.totalUnreadChatCount, greaterThan(0));
    });

    test('changeFilter filters chats correctly', () async {
      final cubit = HomeCubit(dataSource: MockHomeDataSource());
      await cubit.loadChats();

      await cubit.addCategory('important');
      cubit.changeFilter('important');
      expect(cubit.state.selectedFilter, 'important');
      expect(cubit.state.filteredChats.length, 1);

      cubit.changeFilter(HomeState.filterAll);
      expect(cubit.state.selectedFilter, HomeState.filterAll);
      expect(cubit.state.filteredChats.length, 6);
    });

    test('addCategory adds category and updates state', () async {
      final cubit = HomeCubit(dataSource: MockHomeDataSource());
      await cubit.loadChats();

      await cubit.addCategory('Work');
      expect(cubit.state.categories.length, 1);
      expect(cubit.state.categories.first.name, 'Work');
    });

    test('searchChats filters by query', () async {
      final cubit = HomeCubit(dataSource: MockHomeDataSource());
      await cubit.loadChats();

      cubit.searchChats('Coding');
      expect(cubit.state.filteredChats.length, 1);
      expect(cubit.state.filteredChats.first.name, 'Coding Links');

      cubit.searchChats('');
      expect(cubit.state.filteredChats.length, 6);
    });
  });
}
