import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/common/category_button.dart';
import 'package:funeral_menu/common/responsive_sizedbox.dart';
import 'package:funeral_menu/const/size.dart';
import 'package:funeral_menu/state/category_state.dart';
import 'package:funeral_menu/viewmodel/image_list_viewmodel.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      List<String>? list =
          await ref.read(imageListViewmodelProvider.notifier).getCategory();
      if (list != null && list.isNotEmpty) {
        ref.read(imageListViewmodelProvider.notifier).getImageList(list[0]);
      }
    });
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(imageListViewmodelProvider);

    return viewmodel.categoryState is CategoryStateSuccess
        ? Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    viewmodel.categories!.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              viewmodel.categories!.length,
                              (index) {
                                return MyCategoryButton(
                                  title: viewmodel.categories![index],
                                  onPressed: () {
                                    setState(() {
                                      selected = index;
                                    });
                                    viewmodel.getImageList(
                                      viewmodel.categories![index],
                                    );
                                  },
                                  onLongPressed: () {
                                    viewmodel.editCategory(context);
                                  },
                                  isSelected: selected == index,
                                );
                              },
                            ),
                          )
                        : Container(),
                    viewmodel.categories!.isNotEmpty
                        ? MyCategoryButton(
                            title: "업로드",
                            onPressed: () {
                              viewmodel.convertAndUpload(
                                context,
                                viewmodel.categories![selected],
                              );
                            },
                          )
                        : Container(),
                    MyCategoryButton(
                      title: "카테고리추가",
                      onPressed: () {
                        viewmodel.addCategory(context);
                      },
                    ),
                  ],
                ),
              ),
              ResponsiveSizedBox(size: kPaddingLargeSize * 5),
              if (viewmodel.categories!.isNotEmpty)
                Text(
                  viewmodel.categories![selected],
                  style: TextStyle(fontSize: kTextLargeSize * 1.5),
                ),
            ],
          )
        : Container();
  }
}
