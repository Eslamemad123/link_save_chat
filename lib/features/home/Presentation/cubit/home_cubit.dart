import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/datasources/home_data_source.dart';
import '../../Data/models/category_model.dart';
import '../../Data/models/chat_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeDataSource dataSource;

  HomeCubit({required this.dataSource}) : super(const HomeState());

  static final List<ChatModel> _mockChats = [
    ChatModel(
      id: '1',
      name: 'Coding Links',
      description: 'Complete Flutter Course',
      lastMessage: 'Complete Flutter Course',
      color_backgroung_icon: 0xFF0B42EE,
      nummessage: 5,
      date: DateTime.now().subtract(const Duration(minutes: 30)),
      time: '7:29 PM',
      category: 'all',
      datecreateChat: DateTime.now().subtract(const Duration(days: 10)),
      boolNotification: true,
      boolIsPin: false,
    ),
    ChatModel(
      id: '2',
      name: 'Important Tasks',
      description: 'Firebase Project Integration',
      lastMessage:
          'https://testiqx.web.app/?fbclid=IwZXh0bgNhZW0CMTEAcGRvZgVzcnRjBmFwcF9pZAwzNTA2ODU1MzE3MjgAAR-XhgXp1KNiMhKRKURhLSdRF_N8fgfodceTFjA0yVko_Nw_QRK8fVAr1tXcYw_aem_vElDeNon_Lbf14SJodOO5Q',
      color_backgroung_icon: 0xFFF57F17,
      nummessage: 3,
      date: DateTime.now().subtract(const Duration(hours: 2)),
      time: '6:05 PM',
      category: 'important',
      datecreateChat: DateTime.now().subtract(const Duration(days: 8)),
      boolNotification: true,
      boolIsPin: true,
    ),
    ChatModel(
      id: '3',
      name: 'Articles to Read',
      description: 'Clean Architecture in Flutter',
      lastMessage: 'Clean Architecture in Flutter',
      color_backgroung_icon: 0xFF2E7D32,
      nummessage: 2,
      date: DateTime.now().subtract(const Duration(days: 1)),
      time: 'Yesterday',
      category: 'all',
      datecreateChat: DateTime.now().subtract(const Duration(days: 7)),
      boolNotification: true,
      boolIsPin: false,
    ),
    ChatModel(
      id: '4',
      name: 'Project Ideas',
      description: 'Links & Tasks Sync App',
      lastMessage: 'Links & Tasks Sync App',
      color_backgroung_icon: 0xFF7C3AED,
      nummessage: 0,
      date: DateTime.now().subtract(const Duration(days: 3)),
      time: 'Sunday',
      category: 'overdue',
      datecreateChat: DateTime.now().subtract(const Duration(days: 6)),
      boolNotification: true,
      boolIsPin: false,
    ),
    ChatModel(
      id: '5',
      name: 'Study Tasks',
      description: 'Electric Circuits Summary',
      lastMessage: 'Electric Circuits Summary',
      color_backgroung_icon: 0xFF0D9488,
      nummessage: 1,
      date: DateTime.now().subtract(const Duration(days: 4)),
      time: 'Thursday',
      category: 'overdue',
      datecreateChat: DateTime.now().subtract(const Duration(days: 5)),
      boolNotification: true,
      boolIsPin: false,
    ),
    ChatModel(
      id: '6',
      name: 'Tutorial Videos',
      description: 'Cubit and Bloc in detail',
      lastMessage: 'Cubit and Bloc in detail',
      color_backgroung_icon: 0xFFC62828,
      nummessage: 0,
      date: DateTime.now().subtract(const Duration(days: 10)),
      time: 'Oct 12',
      category: 'overdue',
      datecreateChat: DateTime.now().subtract(const Duration(days: 20)),
      boolNotification: true,
      boolIsPin: false,
    ),
  ];

  Future<void> loadChats() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final models = await dataSource.getChats();
      final List<ChatModel> list = models.isNotEmpty ? models : _mockChats;
      final categories = await dataSource.getCategories();
      emit(
        state.copyWith(
          status: HomeStatus.success,
          allChats: list,
          categories: List<CategoryModel>.from(categories),
          filteredChats: _filter(list, state.selectedFilter, state.searchQuery),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> loadCategories() async {
    try {
      final categories = await dataSource.getCategories();
      emit(state.copyWith(categories: categories));
    } catch (e) {
      emit(
        state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> addChat(ChatModel chat) async {
    try {
      await dataSource.addChat(chat);
      await loadChats();
    } catch (e) {
      emit(
        state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> addCategory(String name) async {
    try {
      final newCat = await dataSource.addCategory(name);
      final exists = state.categories.any((c) => c.id == newCat.id);
      final updatedList = exists
          ? state.categories
          : (List<CategoryModel>.from(state.categories)..add(newCat));
      emit(
        state.copyWith(
          categories: updatedList,
          filteredChats: _filter(
            state.allChats,
            state.selectedFilter,
            state.searchQuery,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void changeFilter(String filter) {
    emit(
      state.copyWith(
        selectedFilter: filter,
        filteredChats: _filter(state.allChats, filter, state.searchQuery),
      ),
    );
  }

  void searchChats(String query) {
    emit(
      state.copyWith(
        searchQuery: query,
        filteredChats: _filter(state.allChats, state.selectedFilter, query),
      ),
    );
  }

  List<ChatModel> _filter(
    List<ChatModel> list,
    String filter,
    String query,
  ) {
    return list.where((chat) {
      final matchesFilter = filter == HomeState.filterAll
          ? true
          : _matchesCustomCategory(chat.category, filter);

      final q = query.trim().toLowerCase();
      final matchesQuery =
          q.isEmpty ||
          chat.name.toLowerCase().contains(q) ||
          chat.description.toLowerCase().contains(q) ||
          chat.lastMessage.toLowerCase().contains(q);

      return matchesFilter && matchesQuery;
    }).toList();
  }

  bool _matchesCustomCategory(String chatCategory, String filter) {
    final f = filter.toLowerCase();
    final c = chatCategory.toLowerCase();
    if (c == f) return true;
    for (final cat in state.categories) {
      if (cat.id.toLowerCase() == f && cat.name.toLowerCase() == c) {
        return true;
      }
      if (cat.name.toLowerCase() == f && (cat.id.toLowerCase() == c || cat.name.toLowerCase() == c)) {
        return true;
      }
    }
    return false;
  }
}
