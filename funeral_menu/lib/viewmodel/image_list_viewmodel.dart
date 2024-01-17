import 'package:firebase_database/firebase_database.dart';
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

  void deleteImage(int position) {}

  Future<String?> selectPicture(ImageSource source) async {
    XFile? image = await _imagePicker.pickImage(
      source: source,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    return image?.path;
  }

  void convertAndUpload() async {
    String? path = await selectPicture(ImageSource.gallery);

    if (path != null) {
      Uint8List imageData = await XFile(path).readAsBytes();

      try {
        // Create a unique filename based on current time
        DatabaseReference ref =
            FirebaseDatabase.instance.reference().child(categories[0]);
        DatabaseReference newChildRef = ref.push(); // push 메서드로 새로운 고유 키 생성
        // Firebase Storage path where the image will be stored
        String filePath = '${newChildRef.key}.jpg';

        // Upload the image to Firebase Storage
        UploadTask uploadTask = _storage.ref(filePath).putData(imageData);

        // Wait for the upload to complete and get the download URL
        TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
        String downloadURL = await snapshot.ref.getDownloadURL();

        await newChildRef.set({newChildRef.key: downloadURL});

        print("Image uploaded. Download URL: $downloadURL");
      } catch (e) {
        print("Error uploading image: $e");
      }
    } else {
      print("Image selection canceled");
    }
  }
}
