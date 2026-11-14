import '../models/category_model.dart';

abstract class CategoriesLocalDataSource {
  Stream<List<CategoryModel>> watchCategories();
  List<CategoryModel> getAllCategories();
  CategoryModel? getCategory(String id);
  Future<void> saveCategory(CategoryModel category);
  Future<void> saveCategories(List<CategoryModel> categories);
  Future<void> putRaw(String id, Map<String, dynamic> data);
  Future<void> removeCategory(String id);
  Future<void> markDeleted(String id);
  Future<void> clear();
}

