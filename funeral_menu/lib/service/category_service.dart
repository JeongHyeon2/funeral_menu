import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/model/category_model.dart';
import 'package:funeral_menu/state/category_state.dart';

final categoryServiceProvider =
    StateNotifierProvider<CategoryService, CategoryState>((ref) {
  return CategoryService();
});

class CategoryService extends StateNotifier<CategoryState> {
  CategoryService() : super(CategoryStateNone());

  Future<List<CategoryModel>?> getCategoryList() async {
    state = CategoryStateLoading();
    try {
      List<CategoryModel> list = [];
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child("category").get();
      var iterator = snapshot.children.iterator;
      while (iterator.moveNext()) {
        var data = iterator.current.value;
        if (data is Map<String, dynamic>) {
          CategoryModel model = CategoryModel.fromJson(data);
          list.add(model);
        }
      }
      state = CategoryStateSuccess(list);
      return list;
    } catch (e) {
      state = CategoryStateError("알 수 없는 에러가 발생했습니다.");
    }
    return null;
  }

  Future<bool> deleteCategory(CategoryModel category, List<String> keys) async {
    try {
      state = CategoryStateLoading();
      final ref = FirebaseDatabase.instance.ref();
      await ref.child("category").child(category.key).remove();
      await FirebaseDatabase.instance.ref().child(category.category).remove();
      for (var i = 0; i < keys.length; i++) {
        await FirebaseStorage.instance.ref().child("${keys[i]}.jpg").delete();
      }
      return true;
    } catch (e) {
      state = CategoryStateError("알 수 없는 에러가 발생했습니다.");
    }
    return false;
  }
}
