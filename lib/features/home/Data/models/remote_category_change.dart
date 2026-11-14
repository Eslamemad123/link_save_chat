class RemoteCategoryChange {
  final String categoryId;
  final String name;
  final Map<String, dynamic> hiveData;
  final int? updatedAtMs;
  final bool hasPendingWrites;
  final bool isDeleted;

  const RemoteCategoryChange({
    required this.categoryId,
    required this.name,
    required this.hiveData,
    this.updatedAtMs,
    required this.hasPendingWrites,
    required this.isDeleted,
  });
}

