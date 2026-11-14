import 'dart:async';

import 'package:hive/hive.dart';

import '../models/category_model.dart';
import 'categories_local_data_source.dart';

class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  final Box categoriesBox;

  CategoriesLocalDataSourceImpl({required this.categoriesBox});

  @override
  Stream<List<CategoryModel>> watchCategories() {
    late final StreamController<List<CategoryModel>> controller;
    StreamSubscription? subscription;

    void emitLatest() {
      if (!controller.isClosed) {
        controller.add(getAllCategories());
      }
    }

    controller = StreamController<List<CategoryModel>>(
      onListen: () {
        emitLatest();
        subscription = categoriesBox.watch().listen((_) => emitLatest());
      },
      onCancel: () {
        subscription?.cancel();
      },
    );

    return controller.stream;
  }

  @override
  List<CategoryModel> getAllCategories() {
    final list = <CategoryModel>[];

    for (final key in categoriesBox.keys) {
      final raw = categoriesBox.get(key);
      if (raw is Map) {
        final category = CategoryModel.fromHiveMap(raw);
        if (!category.deleted) {
          list.add(category);
        }
      }
    }

    list.sort((a, b) {
      final aDate = a.createdAt ??
          a.updatedAt ??
          DateTime.fromMillisecondsSinceEpoch(0);
      final bDate = b.createdAt ??
          b.updatedAt ??
          DateTime.fromMillisecondsSinceEpoch(0);
      return aDate.compareTo(bDate);
    });

    return list;
  }

  @override
  CategoryModel? getCategory(String id) {
    final raw = categoriesBox.get(id);
    if (raw is Map) {
      return CategoryModel.fromHiveMap(raw);
    }
    return null;
  }

  @override
  Future<void> saveCategory(CategoryModel category) async {
    await categoriesBox.put(category.id, category.toHiveMap());
  }

  @override
  Future<void> saveCategories(List<CategoryModel> categories) async {
    final entries = <String, Map<String, dynamic>>{};
    for (final cat in categories) {
      entries[cat.id] = cat.toHiveMap();
    }
    await categoriesBox.putAll(entries);
  }

  @override
  Future<void> putRaw(String id, Map<String, dynamic> data) async {
    await categoriesBox.put(id, data);
  }

  @override
  Future<void> removeCategory(String id) async {
    await categoriesBox.delete(id);
  }

  @override
  Future<void> markDeleted(String id) async {
    final existing = getCategory(id);
    if (existing != null) {
      final updated = existing.copyWith(
        deleted: true,
        updatedAt: DateTime.now(),
      );
      await saveCategory(updated);
    } else {
      await categoriesBox.delete(id);
    }
  }

  @override
  Future<void> clear() async {
    await categoriesBox.clear();
  }
}

