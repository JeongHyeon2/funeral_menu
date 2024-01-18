import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/common/responsive_sizedbox.dart';
import 'package:funeral_menu/const/category.dart';
import 'package:funeral_menu/const/size.dart';
import 'package:funeral_menu/screen/detail_screen.dart';
import 'package:funeral_menu/state/image_listview_state.dart';
import 'package:funeral_menu/viewmodel/image_list_viewmodel.dart';

class ListViewScreen extends ConsumerStatefulWidget {
  const ListViewScreen({super.key});

  @override
  ConsumerState<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends ConsumerState<ListViewScreen> {
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
                    child: renderImage(
                      index,
                      viewmodel,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: renderImage(
                          adjustedIndex,
                          viewmodel,
                        ),
                      ),
                      ResponsiveSizedBox(size: kPaddingXLargeSize),
                      if (adjustedIndex + 1 <
                          (viewmodel.imageList?.length ?? 0))
                        Center(
                          child: renderImage(
                            adjustedIndex + 1,
                            viewmodel,
                          ),
                        ),
                      if (!(adjustedIndex + 1 <
                          (viewmodel.imageList?.length ?? 0)))
                        ResponsiveSizedBox(size: kIconLargeSize * 7),
                      ResponsiveSizedBox(size: kPaddingXLargeSize),
                      if (adjustedIndex + 2 <
                          (viewmodel.imageList?.length ?? 0))
                        Center(
                          child: renderImage(
                            adjustedIndex + 2,
                            viewmodel,
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

  Widget renderImage(int position, ImageListViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              imageModel: viewModel.imageList![position],
            ),
          ),
        );
      },
      onLongPress: () {
        viewModel.deleteImage(position, context);
      },
      child: Hero(
        tag: viewModel.imageList?[position].imageLink ?? '',
        child: Column(
          children: [
            Image.network(
              viewModel.imageList?[position].imageLink ?? '',
              width: kIconLargeSize * 7,
              height: kIconLargeSize * 7,
              fit: BoxFit.cover,
            ),
            ResponsiveSizedBox(size: kPaddingLargeSize),
            Text(
              viewModel.imageList?[position].name ?? '',
              style: TextStyle(fontSize: kTextLargeSize),
            ),
          ],
        ),
      ),
    );
  }
}
