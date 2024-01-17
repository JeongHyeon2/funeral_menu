import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
    try {
      List<String> stringList = [];
      // if (category == categories[0]) {
      //   stringList = [
      //     "assets/images/test.jpg",
      //     "assets/images/test2.jpg",
      //     "assets/images/test3.jpg",
      //     "assets/images/test2.jpg",
      //     "assets/images/test3.jpg",
      //   ];
      // }
      // if (category == categories[1]) {
      //   stringList = [
      //     "assets/images/test2.jpg",
      //   ];
      // }
      // if (category == categories[2]) {
      //   stringList = [
      //     "assets/images/test3.jpg",
      //   ];
      // }
      String? path = await downloadImage();
      if (path != null) {
        stringList.add(path);
      }
      state = ImageListViewStateSuccess(stringList);
    } catch (e) {
      state = ImageListViewStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future<String?> downloadImage() async {
    try {
      String downloadURL = await _storage
          .ref('1705451347549.jpg') // 이미지가 저장된 경로
          .getDownloadURL();

      return downloadURL;
    } catch (e) {
      print("Error downloading image: $e");
    }
    return null;
  }
}
