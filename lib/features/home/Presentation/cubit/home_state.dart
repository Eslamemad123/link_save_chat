import '../../Data/models/category_model.dart';
import '../../Data/models/chat_model.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState {
  static const String filterAll = 'all';
  static const String filterOverdue = 'overdue';
  static const String filterImportant = 'important';

  final HomeStatus status;
  final List<ChatModel> allChats;
  final List<ChatModel> filteredChats;
  final List<CategoryModel> categories;
  final String selectedFilter;
  final String searchQuery;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.allChats = const [],
    this.filteredChats = const [],
    this.categories = const [],
    this.selectedFilter = filterAll,
    this.searchQuery = '',
    this.errorMessage,
  });

  int get overdueCount =>
      allChats.where((c) => c.category.toLowerCase() == 'overdue').length;

  int get importantCount =>
      allChats.where((c) => c.category.toLowerCase() == 'important').length;

  int categoryChatCount(String categoryId, String categoryName) {
    final lowerId = categoryId.toLowerCase();
    final lowerName = categoryName.toLowerCase();
    return allChats.where((c) {
      final chatCat = c.category.toLowerCase();
      return chatCat == lowerId || chatCat == lowerName;
    }).length;
  }

  HomeState copyWith({
    HomeStatus? status,
    List<ChatModel>? allChats,
    List<ChatModel>? filteredChats,
    List<CategoryModel>? categories,
    String? selectedFilter,
    String? searchQuery,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      allChats: allChats ?? this.allChats,
      filteredChats: filteredChats ?? this.filteredChats,
      categories: categories ?? this.categories,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          allChats == other.allChats &&
          filteredChats == other.filteredChats &&
          categories == other.categories &&
          selectedFilter == other.selectedFilter &&
          searchQuery == other.searchQuery &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(
        status,
        allChats,
        filteredChats,
        categories,
        selectedFilter,
        searchQuery,
        errorMessage,
      );
}
