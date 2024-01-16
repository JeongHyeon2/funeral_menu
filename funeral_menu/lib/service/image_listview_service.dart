import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/const/category.dart';
import 'package:funeral_menu/state/image_listview_state.dart';

final imageListServiceProvider =
    StateNotifierProvider<ImageListViewService, ImageListViewState>((ref) {
  return ImageListViewService();
});

class ImageListViewService extends StateNotifier<ImageListViewState> {
  ImageListViewService() : super(ImageListViewStateNone());

  Future getImageList(String category) async {
    state = ImageListViewStateLoading();
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
    try {
      List<String> stringList = [];
      if (category == categories[0]) {
        stringList = [
          "assets/images/test.jpg",
        ];
      }
      if (category == categories[1]) {
        stringList = [
          "assets/images/test2.jpg",
        ];
      }
      if (category == categories[2]) {
        stringList = [
          "assets/images/test3.jpg",
        ];
      }
      state = ImageListViewStateSuccess(stringList);
    } catch (e) {
      state = ImageListViewStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
