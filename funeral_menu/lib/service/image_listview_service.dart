import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/const/category.dart';
import 'package:funeral_menu/model/image_model.dart';
import 'package:funeral_menu/state/image_listview_state.dart';

final imageListServiceProvider =
    StateNotifierProvider<ImageListViewService, ImageListViewState>((ref) {
  return ImageListViewService();
});

class ImageListViewService extends StateNotifier<ImageListViewState> {
  ImageListViewService() : super(ImageListViewStateNone());

  Future getImageList(String category) async {
    state = ImageListViewStateLoading();
    try {
      List<ImageModel> imageList = [];
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child(category).get();
      if (snapshot.exists) {
        var iterator = snapshot.children.iterator;
        while (iterator.moveNext()) {
          var data = iterator.current.value;
          if (data is Map<String, dynamic>) {
            ImageModel imageModel = ImageModel.fromJson(data);
            imageList.add(imageModel);
          }
        }
      }
      state = ImageListViewStateSuccess(imageList);
    } catch (e) {
      state = ImageListViewStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
