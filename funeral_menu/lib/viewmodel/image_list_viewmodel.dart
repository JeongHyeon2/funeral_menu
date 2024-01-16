import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/const/category.dart';
import 'package:funeral_menu/service/image_listview_service.dart';
import 'package:funeral_menu/state/image_listview_state.dart';

final imageListViewmodelProvider =
    ChangeNotifierProvider((ref) => ImageListViewModel(ref));

class ImageListViewModel extends ChangeNotifier {
  final Ref ref;
  late ImageListViewState imageListViewState;

  String _currentCategory = categories[0];

  String get currentCategory => _currentCategory;

  ImageListViewModel(this.ref) {
    imageListViewState = ref.watch(imageListServiceProvider);
  }

  List<String>? get imageList => imageListViewState is ImageListViewStateSuccess
      ? (imageListViewState as ImageListViewStateSuccess).data
      : null;
  void setCurrentCategory(String category) {
    _currentCategory = category;
    notifyListeners();
  }

  Future<void> setImage() async {
    final storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().toUtc().toIso8601String()}');
    await storageReference.putFile(File('assets/images/test.jpg'));
  }

  void getImageList(String category) async {
    await ref.read(imageListServiceProvider.notifier).getImageList(category);
  }
}
