import 'package:flutter_test/flutter_test.dart';
import 'package:link_savw_chat/features/home/Data/datasources/home_data_source.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';
import 'package:link_savw_chat/features/home/Presentation/cubit/home_cubit.dart';
import 'package:link_savw_chat/features/home/Presentation/cubit/home_state.dart';

class MockHomeDataSource implements HomeDataSource {
  final List<ChatModel> _chats;

  MockHomeDataSource({List<ChatModel>? chats}) : _chats = chats ?? [];

  @override
  Future<List<ChatModel>> getChats() async => _chats;

  @override
  Future<void> addChat(ChatModel chat) async {}

  @override
  Future<void> deleteChat(String id) async {}
}

void main() {
  group('HomeCubit Tests', () {
    test('initial state has default values', () {
      final cubit = HomeCubit(dataSource: MockHomeDataSource());
      expect(cubit.state.status, HomeStatus.initial);
      expect(cubit.state.selectedFilter, HomeFilter.all);
      expect(cubit.state.allChats, isEmpty);
    });

    test('loadChats loads fallback mock items when data source is empty', () async {
      final cubit = HomeCubit(dataSource: MockHomeDataSource());
      await cubit.loadChats();

      expect(cubit.state.status, HomeStatus.success);
      expect(cubit.state.allChats.length, 6);
      expect(cubit.state.filteredChats.length, 6);
      expect(cubit.state.overdueCount, 3);
    });

    test('changeFilter filters chats correctly', () async {
      final cubit = HomeCubit(dataSource: MockHomeDataSource());
      await cubit.loadChats();

      cubit.changeFilter(HomeFilter.overdue);
      expect(cubit.state.selectedFilter, HomeFilter.overdue);
      expect(cubit.state.filteredChats.length, 3);

      cubit.changeFilter(HomeFilter.important);
      expect(cubit.state.selectedFilter, HomeFilter.important);
      expect(cubit.state.filteredChats.length, 1);

      cubit.changeFilter(HomeFilter.all);
      expect(cubit.state.selectedFilter, HomeFilter.all);
      expect(cubit.state.filteredChats.length, 6);
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

