import '../../Data/models/chat_model.dart';

enum HomeFilter { all, overdue, important }

enum HomeStatus { initial, loading, success, failure }

class HomeState {
  final HomeStatus status;
  final List<ChatModel> allChats;
  final List<ChatModel> filteredChats;
  final HomeFilter selectedFilter;
  final String searchQuery;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.allChats = const [],
    this.filteredChats = const [],
    this.selectedFilter = HomeFilter.all,
    this.searchQuery = '',
    this.errorMessage,
  });

  int get overdueCount =>
      allChats.where((c) => c.category.toLowerCase() == 'overdue').length;

  int get importantCount =>
      allChats.where((c) => c.category.toLowerCase() == 'important').length;

  HomeState copyWith({
    HomeStatus? status,
    List<ChatModel>? allChats,
    List<ChatModel>? filteredChats,
    HomeFilter? selectedFilter,
    String? searchQuery,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      allChats: allChats ?? this.allChats,
      filteredChats: filteredChats ?? this.filteredChats,
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
          selectedFilter == other.selectedFilter &&
          searchQuery == other.searchQuery &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(
        status,
        allChats,
        filteredChats,
        selectedFilter,
        searchQuery,
        errorMessage,
      );
}
