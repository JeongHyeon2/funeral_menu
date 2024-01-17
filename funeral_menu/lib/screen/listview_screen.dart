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
          itemBuilder: (context, index) {
            int adjustedIndex = index * 3;

            return ResponsiveData.kIsMobile
                ? Center(
                    child: Image.asset(
                      viewmodel.imageList?[index] ?? '',
                      width: kIconLargeSize * 7,
                      height: kIconLargeSize * 7,
                      fit: BoxFit.cover,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/funeral-menu.appspot.com/o/1705451347549.jpg?alt=media&token=93a48249-d6ae-46d2-b881-1539b4352641",
                          width: kIconLargeSize * 7,
                          height: kIconLargeSize * 7,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ResponsiveSizedBox(size: kPaddingXLargeSize),
                      if (adjustedIndex + 1 <
                          (viewmodel.imageList?.length ?? 0))
                        Center(
                          child: Image.asset(
                            viewmodel.imageList?[adjustedIndex + 1] ?? '',
                            width: kIconLargeSize * 7,
                            height: kIconLargeSize * 7,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (!(adjustedIndex + 1 <
                          (viewmodel.imageList?.length ?? 0)))
                        ResponsiveSizedBox(size: kIconLargeSize * 7),
                      ResponsiveSizedBox(size: kPaddingXLargeSize),
                      if (adjustedIndex + 2 <
                          (viewmodel.imageList?.length ?? 0))
                        Center(
                          child: Image.asset(
                            viewmodel.imageList?[adjustedIndex + 2] ?? '',
                            width: kIconLargeSize * 7,
                            height: kIconLargeSize * 7,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (!(adjustedIndex + 2 <
                          (viewmodel.imageList?.length ?? 0)))
                        ResponsiveSizedBox(size: kIconLargeSize * 7),
                    ],
                  );
          },
          separatorBuilder: (context, index) =>
              ResponsiveSizedBox(size: kPaddingXLargeSize * 2),
          itemCount: ResponsiveData.kIsMobile
              ? (viewmodel.imageList?.length ?? 0)
              : ((viewmodel.imageList?.length ?? 0) / 3).ceil(),
        );

      case ImageListViewStateLoading:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
    return Container();
  }
}
