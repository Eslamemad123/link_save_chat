import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/datasources/home_data_source.dart';
import '../../Data/models/category_model.dart';
import '../../Data/models/chat_model.dart';
import '../../Domain/repositories/chats_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ChatsRepository? repository;
  final HomeDataSource? dataSource;

  StreamSubscription<List<ChatModel>>? _chatsSubscription;
  StreamSubscription<List<CategoryModel>>? _categoriesSubscription;

  @visibleForTesting
  static final List<ChatModel> mockChats = [
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

  HomeCubit({
    this.repository,
    this.dataSource,
  }) : super(const HomeState()) {
    if (repository != null) {
      _initStreams();
    }
  }

  void _initStreams() {
    final cachedChats = repository!.getCachedChats();
    final cachedCategories = repository!.getCachedCategories();

    emit(
      state.copyWith(
        status: HomeStatus.success,
        allChats: cachedChats,
        categories: cachedCategories,
        filteredChats: _filter(
          cachedChats,
          state.selectedFilter,
          state.searchQuery,
          categories: cachedCategories,
        ),
      ),
    );

    _chatsSubscription = repository!.watchChats().listen((chats) {
      emit(
        state.copyWith(
          status: HomeStatus.success,
          allChats: chats,
          filteredChats: _filter(
            chats,
            state.selectedFilter,
            state.searchQuery,
            categories: state.categories,
          ),
          clearError: true,
        ),
      );
    });

    _categoriesSubscription = repository!.watchCategories().listen((categories) {
      emit(
        state.copyWith(
          categories: categories,
          filteredChats: _filter(
            state.allChats,
            state.selectedFilter,
            state.searchQuery,
            categories: categories,
          ),
          clearError: true,
        ),
      );
    });
  }

  Future<void> loadChats() async {
    if (repository != null) {
      final cachedChats = repository!.getCachedChats();
      final cachedCategories = repository!.getCachedCategories();
      emit(
        state.copyWith(
          status: HomeStatus.success,
          allChats: cachedChats,
          categories: cachedCategories,
          filteredChats: _filter(
            cachedChats,
            state.selectedFilter,
            state.searchQuery,
            categories: cachedCategories,
          ),
        ),
      );
      return;
    }

    if (dataSource != null) {
      emit(state.copyWith(status: HomeStatus.loading));
      try {
        final models = await dataSource!.getChats();
        final categories = await dataSource!.getCategories();
        emit(
          state.copyWith(
            status: HomeStatus.success,
            allChats: models,
            categories: List<CategoryModel>.from(categories),
            clearError: true,
            filteredChats: _filter(
              models,
              state.selectedFilter,
              state.searchQuery,
              categories: categories,
            ),
          ),
        );
      } on FirebaseException catch (e) {
        emit(
          state.copyWith(
            status: HomeStatus.failure,
            errorMessage: _mapFirebaseError(e),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: HomeStatus.failure,
            errorMessage: _mapGenericError(e),
          ),
        );
      }
    }
  }

  Future<void> loadCategories() async {
    if (repository != null) {
      final cachedCategories = repository!.getCachedCategories();
      emit(
        state.copyWith(
          categories: cachedCategories,
          filteredChats: _filter(
            state.allChats,
            state.selectedFilter,
            state.searchQuery,
            categories: cachedCategories,
          ),
        ),
      );
      return;
    }

    if (dataSource != null) {
      try {
        final categories = await dataSource!.getCategories();
        emit(state.copyWith(categories: categories, clearError: true));
      } on FirebaseException catch (e) {
        emit(
          state.copyWith(
            status: HomeStatus.failure,
            errorMessage: _mapFirebaseError(e),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: HomeStatus.failure,
            errorMessage: _mapGenericError(e),
          ),
        );
      }
    }
  }

  Future<bool> addChat(ChatModel chat, {File? imageFile}) async {
    try {
      if (repository != null) {
        await repository!.createChat(chat, imageFile: imageFile);
        return true;
      }
      if (dataSource != null) {
        await dataSource!.addChat(chat);
        await loadChats();
        return true;
      }
      return false;
    } on FirebaseException catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: _mapFirebaseError(e),
        ),
      );
      return false;
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: _mapGenericError(e),
        ),
      );
      return false;
    }
  }

  Future<bool> updateChat(ChatModel chat, {File? newImageFile}) async {
    try {
      if (repository != null) {
        await repository!.updateChat(chat, newImageFile: newImageFile);
        return true;
      }
      if (dataSource != null) {
        await dataSource!.updateChat(chat);
        await loadChats();
        return true;
      }
      return false;
    } on FirebaseException catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: _mapFirebaseError(e),
        ),
      );
      return false;
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: _mapGenericError(e),
        ),
      );
      return false;
    }
  }

  Future<void> togglePin(String chatId, bool isPinned) async {
    try {
      if (repository != null) {
        await repository!.togglePin(chatId, isPinned);
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> toggleMute(String chatId, bool isMuted) async {
    try {
      if (repository != null) {
        await repository!.toggleMute(chatId, isMuted);
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> updateWallpaper(String chatId, String? wallpaper) async {
    try {
      if (repository != null) {
        await repository!.updateWallpaper(chatId, wallpaper);
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> clearChatMessages(String chatId) async {
    try {
      if (repository != null) {
        await repository!.clearChatMessages(chatId);
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteChat(String chatId) async {
    try {
      if (repository != null) {
        await repository!.deleteChat(chatId);
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<bool> addCategory(String name) async {
    try {
      if (repository != null) {
        await repository!.addCategory(name);
        return true;
      }
      if (dataSource != null) {
        final newCat = await dataSource!.addCategory(name);
        final exists = state.categories.any((c) => c.id == newCat.id);
        final updatedList = exists
            ? state.categories
            : (List<CategoryModel>.from(state.categories)..add(newCat));
        emit(
          state.copyWith(
            categories: updatedList,
            clearError: true,
            filteredChats: _filter(
              state.allChats,
              state.selectedFilter,
              state.searchQuery,
              categories: updatedList,
            ),
          ),
        );
        return true;
      }
      return false;
    } on FirebaseException catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: _mapFirebaseError(e),
        ),
      );
      return false;
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: _mapGenericError(e),
        ),
      );
      return false;
    }
  }

  void changeFilter(String filter) {
    emit(
      state.copyWith(
        selectedFilter: filter,
        filteredChats: _filter(
          state.allChats,
          filter,
          state.searchQuery,
          categories: state.categories,
        ),
      ),
    );
  }

  void searchChats(String query) {
    emit(
      state.copyWith(
        searchQuery: query,
        filteredChats: _filter(
          state.allChats,
          state.selectedFilter,
          query,
          categories: state.categories,
        ),
      ),
    );
  }

  List<ChatModel> _filter(
    List<ChatModel> list,
    String filter,
    String query, {
    List<CategoryModel> categories = const [],
  }) {
    return list.where((chat) {
      final matchesFilter = filter == HomeState.filterAll
          ? true
          : _matchesCustomCategory(chat.category, filter, categories);

      final q = query.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          chat.name.toLowerCase().contains(q) ||
          chat.description.toLowerCase().contains(q) ||
          chat.lastMessage.toLowerCase().contains(q);

      return matchesFilter && matchesQuery;
    }).toList();
  }

  bool _matchesCustomCategory(
    String chatCategory,
    String filter,
    List<CategoryModel> categories,
  ) {
    final f = filter.toLowerCase();
    final c = chatCategory.toLowerCase();
    if (c == f) return true;
    for (final cat in categories) {
      if (cat.id.toLowerCase() == f && cat.name.toLowerCase() == c) {
        return true;
      }
      if (cat.name.toLowerCase() == f &&
          (cat.id.toLowerCase() == c || cat.name.toLowerCase() == c)) {
        return true;
      }
    }
    return false;
  }

  String _mapFirebaseError(FirebaseException e) {
    switch (e.code) {
      case 'unavailable':
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      case 'permission-denied':
        return 'Permission denied. You do not have access.';
      case 'deadline-exceeded':
        return 'Request timed out. Please try again.';
      default:
        return e.message?.isNotEmpty == true
            ? e.message!
            : 'A database error occurred.';
    }
  }

  String _mapGenericError(Object e) {
    final msg = e.toString();
    if (msg.contains('not authenticated')) {
      return 'User not authenticated';
    }
    return msg.replaceFirst('Exception: ', '');
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    _categoriesSubscription?.cancel();
    return super.close();
  }
}
