import 'package:firebase_database/firebase_database.dart';
import 'package:funeral_menu/const/size.dart';
import 'package:funeral_menu/model/image_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/const/category.dart';
import 'package:funeral_menu/service/image_listview_service.dart';
import 'package:funeral_menu/state/image_listview_state.dart';

final imageListViewmodelProvider =
    ChangeNotifierProvider((ref) => ImageListViewModel(ref));

class ImageListViewModel extends ChangeNotifier {
  final Ref ref;
  late ImageListViewState imageListViewState;
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String _currentCategory = categories[0];

  String get currentCategory => _currentCategory;

  ImageListViewModel(this.ref) {
    imageListViewState = ref.watch(imageListServiceProvider);
  }

  List<ImageModel>? get imageList =>
      imageListViewState is ImageListViewStateSuccess
          ? (imageListViewState as ImageListViewStateSuccess).data
          : null;
  void setCurrentCategory(String category) {
    _currentCategory = category;
    notifyListeners();
  }

  void getImageList(String category) async {
    await ref.read(imageListServiceProvider.notifier).getImageList(category);
  }

  void deleteImage(int position, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: EdgeInsets.all(kPaddingLargeSize),
            child: Text(
              '${imageList![position].name} 을/를 삭제하시겠습니까?',
              style: TextStyle(
                fontSize: kTextLargeSize,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
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
                String key = imageList![position].key;
                DatabaseReference ref = FirebaseDatabase.instance
                    .ref()
                    .child(key.split(divider)[0])
                    .child(key.split(divider)[1]);
                await ref.remove();
                final desertRef = _storage.ref().child("$key.jpg");
                await desertRef.delete();

                getImageList(key.split(divider)[0]);
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text(
                '확인',
                style: TextStyle(
                  fontSize: kTextMiddleSize,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String?> selectPicture(ImageSource source) async {
    XFile? image = await _imagePicker.pickImage(
      source: source,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    return image?.path;
  }

  void convertAndUpload(BuildContext context, String category) async {
    String? path = await selectPicture(ImageSource.gallery);

    if (path != null) {
      Uint8List imageData = await XFile(path).readAsBytes();
      String name = await _showInputDialog(context);

      try {
        // Create a unique filename based on current time
        DatabaseReference ref = FirebaseDatabase.instance.ref().child(category);
        DatabaseReference newChildRef = ref.push(); // push 메서드로 새로운 고유 키 생성
        // Firebase Storage path where the image will be stored
        String key = "$category$divider${newChildRef.key}";
        String filePath = '$key.jpg';

        // Upload the image to Firebase Storage
        UploadTask uploadTask = _storage.ref(filePath).putData(imageData);

        // Wait for the upload to complete and get the download URL
        TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
        String downloadURL = await snapshot.ref.getDownloadURL();

        await newChildRef.set(
          ImageModel(
            key: key,
            imageLink: downloadURL,
            name: name,
          ).toJson(),
        );
        getImageList(category);
        print("Image uploaded. Download URL: $downloadURL");
      } catch (e) {
        print("Error uploading image: $e");
      }
    } else {
      print("Image selection canceled");
    }
  }

  final TextEditingController _textEditingController = TextEditingController();

  Future<String> _showInputDialog(BuildContext context) async {
    String result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '이름을 입력하세요',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: kTextMiddleSize,
            ),
          ),
          content: TextField(
            controller: _textEditingController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(_textEditingController.text);
              },
              child: Text(
                '확인',
                style: TextStyle(
                  fontSize: kTextMiddleSize,
                ),
              ),
            ),
          ],
        );
      },
    );
    if (result.isNotEmpty) {
      return result;
    }
    return "제목없음";
  }
}
