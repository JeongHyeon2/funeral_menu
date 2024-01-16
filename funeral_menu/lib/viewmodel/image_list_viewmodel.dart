import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/service/image_listview_service.dart';
import 'package:funeral_menu/state/image_listview_state.dart';

final imageListViewmodelProvider =
    ChangeNotifierProvider((ref) => ImageListViewModel(ref));

class ImageListViewModel extends ChangeNotifier {
  final Ref ref;
  late ImageListViewState imageListViewState;
  ImageListViewModel(this.ref) {
    imageListViewState = ref.watch(imageListServiceProvider);
  }

  List<String>? get imageList => imageListViewState is ImageListViewStateSuccess
      ? (imageListViewState as ImageListViewStateSuccess).data
      : null;

  void getImageList() async {
    await ref.read(imageListServiceProvider.notifier).getImageList();
  }
}
