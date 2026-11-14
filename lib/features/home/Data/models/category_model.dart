import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool deleted;

  const CategoryModel({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
    this.deleted = false,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      if (value is String) return DateTime.tryParse(value);
      if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
      return null;
    }

    bool parseBool(dynamic value, [bool fallback = false]) {
      if (value is bool) return value;
      if (value is String) return value.toLowerCase() == 'true';
      return fallback;
    }

    final createdDate = parseDate(json['createdAt'] ?? json['updatedAt']);
    final updatedDate = parseDate(json['updatedAt']) ?? createdDate;

    return CategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      createdAt: createdDate,
      updatedAt: updatedDate,
      deleted: parseBool(json['deleted'], false),
    );
  }

  factory CategoryModel.fromHiveMap(Map<dynamic, dynamic> map) {
    DateTime? parseMillis(dynamic value) {
      if (value == null) return null;
      if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
      if (value is String) {
        final parsed = int.tryParse(value);
        if (parsed != null) return DateTime.fromMillisecondsSinceEpoch(parsed);
        return DateTime.tryParse(value);
      }
      return null;
    }

    bool parseBool(dynamic value, [bool fallback = false]) {
      if (value is bool) return value;
      if (value is String) return value.toLowerCase() == 'true';
      return fallback;
    }

    final createdDate =
        parseMillis(map['createdAt']) ?? parseMillis(map['updatedAt']);

    return CategoryModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      createdAt: createdDate,
      updatedAt: parseMillis(map['updatedAt']) ?? createdDate,
      deleted: parseBool(map['deleted'], false),
    );
  }

  Map<String, dynamic> toHiveMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': (createdAt ?? updatedAt)?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'deleted': deleted,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'deleted': deleted,
    };
  }

  Map<String, dynamic> toFirestoreJson({bool isCreate = false}) {
    return {
      'id': id,
      'name': name,
      'createdAt': isCreate
          ? FieldValue.serverTimestamp()
          : (createdAt != null
              ? Timestamp.fromDate(createdAt!)
              : FieldValue.serverTimestamp()),
      'updatedAt': FieldValue.serverTimestamp(),
      'deleted': deleted,
    };
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? deleted,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          deleted == other.deleted;

  @override
  int get hashCode => Object.hash(id, name, createdAt, updatedAt, deleted);
}

extension CategoryListExtension on List<CategoryModel> {
  int findIndexByIdOrName(String idOrName) {
    final target = idOrName.trim().toLowerCase();
    final index = indexWhere(
      (c) => c.id.toLowerCase() == target || c.name.toLowerCase() == target,
    );
    return index != -1 ? index : 0;
  }

  String findIdByIndex(int index) {
    if (isEmpty || index < 0 || index >= length) return 'all';
    return this[index].id;
  }
}
