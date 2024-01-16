import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/state/image_listview_state.dart';

final imageListServiceProvider =
    StateNotifierProvider<ImageListViewService, ImageListViewState>((ref) {
  return ImageListViewService();
});

class ImageListViewService extends StateNotifier<ImageListViewState> {
  ImageListViewService() : super(ImageListViewStateNone());

  Future getImageList() async {
    state = ImageListViewStateLoading();
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    try {
      List<String> stringList = [
        "assets/images/test.jpg",
        "assets/images/test2.jpg",
        "assets/images/test3.jpg"
      ];
      state = ImageListViewStateSuccess(stringList);
    } catch (e) {
      state = ImageListViewStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
