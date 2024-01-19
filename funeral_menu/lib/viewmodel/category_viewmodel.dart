import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/common/input_dialog.dart';
import 'package:funeral_menu/const/size.dart';
import 'package:funeral_menu/model/category_model.dart';
import 'package:funeral_menu/service/category_service.dart';
import 'package:funeral_menu/service/image_listview_service.dart';
import 'package:funeral_menu/state/category_state.dart';

final categoryViewmodelProvider =
    ChangeNotifierProvider((ref) => CategoryViewModel(ref));

class CategoryViewModel extends ChangeNotifier {
  final Ref ref;
  late CategoryState categoryState;

  CategoryViewModel(this.ref) {
    categoryState = ref.watch(categoryServiceProvider);
  }
  List<CategoryModel>? get categories => categoryState is CategoryStateSuccess
      ? (categoryState as CategoryStateSuccess).data
      : null;
  Future<List<CategoryModel>?> getCategory() async {
    return await ref.read(categoryServiceProvider.notifier).getCategoryList();
  }

  Future<bool> editCategory(BuildContext context, int index) async {
    bool isDelete = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "${categories![index].category}을 삭제하시겠습니까?\n저장된 이미지들은 모두 삭제됩니다.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: kTextMiddleSize,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                '취소',
                style: TextStyle(
                  fontSize: kTextMiddleSize,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                List<String>? keys = await ref
                    .read(imageListServiceProvider.notifier)
                    .getImageListForDelete(
                      categories![index].category,
                    );
                if (keys != null) {
                  await ref
                      .read(categoryServiceProvider.notifier)
                      .deleteCategory(
                        categories![index],
                        keys,
                      );

                  getCategory();

                  isDelete = true;
                }
                Navigator.of(context).pop();
              },
              child: Text(
                '삭제',
                style: TextStyle(
                  fontSize: kTextMiddleSize,
                ),
              ),
            ),
          ],
        );
      },
    );
    return isDelete;
  }

  void addCategory(BuildContext context) async {
    String name = await ImputDialog().showInputDialog(context);
    (context);
    DatabaseReference ref = FirebaseDatabase.instance.ref().child("category");
    DatabaseReference newChildRef = ref.push();

    String key = newChildRef.key.toString();
    newChildRef.set(
      CategoryModel(
        key: key,
        category: name,
      ).toJson(),
    );
    getCategory();
  }
}
