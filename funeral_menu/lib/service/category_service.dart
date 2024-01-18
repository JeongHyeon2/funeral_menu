import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/state/category_state.dart';

final categoryServiceProvider =
    StateNotifierProvider<CategoryService, CategoryState>((ref) {
  return CategoryService();
});

class CategoryService extends StateNotifier<CategoryState> {
  CategoryService() : super(CategoryStateNone());

  Future<List<String>?> getCategoryList() async {
    state = CategoryStateLoading();
    try {
      List<String> list = [];
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child("category").get();
      var iterator = snapshot.children.iterator;
      while (iterator.moveNext()) {
        var data = iterator.current.value;
        list.add(data.toString());
      }
      state = CategoryStateSuccess(list);
      return list;
    } catch (e) {
      state = CategoryStateError("알 수 없는 에러가 발생했습니다.");
    }
    return null;
  }
}
