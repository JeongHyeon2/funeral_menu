import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/common/responsive_sizedbox.dart';
import 'package:funeral_menu/const/category.dart';
import 'package:funeral_menu/const/size.dart';
import 'package:funeral_menu/state/image_listview_state.dart';
import 'package:funeral_menu/viewmodel/image_list_viewmodel.dart';

class ListViewScreen extends ConsumerStatefulWidget {
  const ListViewScreen({super.key});

  @override
  ConsumerState<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends ConsumerState<ListViewScreen> {
  @override
  void initState() {
    super.initState();
    Future(
      () => ref
          .read(imageListViewmodelProvider.notifier)
          .getImageList(categories[0]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(imageListViewmodelProvider);
    switch (viewmodel.imageListViewState.runtimeType) {
      case ImageListViewStateSuccess:
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => Center(
            child: Image.asset(
              viewmodel.imageList?[index] ?? '',
              width: kIconLargeSize * 7,
              height: kIconLargeSize * 7,
              fit: BoxFit.cover,
            ),
          ),
          separatorBuilder: (context, index) =>
              ResponsiveSizedBox(size: kPaddingSmallSize),
          itemCount: viewmodel.imageList?.length ?? 0,
        );
      case ImageListViewStateLoading:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
    return Container();
  }
}
