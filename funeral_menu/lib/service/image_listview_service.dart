import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/const/category.dart';
import 'package:funeral_menu/state/image_listview_state.dart';

final imageListServiceProvider =
    StateNotifierProvider<ImageListViewService, ImageListViewState>((ref) {
  return ImageListViewService();
});

class ImageListViewService extends StateNotifier<ImageListViewState> {
  ImageListViewService() : super(ImageListViewStateNone());
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future getImageList(String category) async {
    state = ImageListViewStateLoading();
    try {
      List<String> stringList = [];
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child(categories[0]).get();
      if (snapshot.exists) {
        var iterator = snapshot.children.iterator;
        while (iterator.moveNext()) {
          var data = iterator.current.value;
          stringList.add(data.toString());
        }
      } else {
        print('No data available.');
      }

      state = ImageListViewStateSuccess(stringList);
    } catch (e) {
      state = ImageListViewStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
