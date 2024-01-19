import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/common/category_button.dart';
import 'package:funeral_menu/common/responsive_sizedbox.dart';
import 'package:funeral_menu/const/size.dart';
import 'package:funeral_menu/model/category_model.dart';
import 'package:funeral_menu/state/category_state.dart';
import 'package:funeral_menu/viewmodel/category_viewmodel.dart';
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
      List<CategoryModel>? list =
          await ref.read(categoryViewmodelProvider.notifier).getCategory();
      if (list != null && list.isNotEmpty) {
        ref
            .read(imageListViewmodelProvider.notifier)
            .getImageList(list[0].category);
      }
    });
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final categoryViewmodel = ref.watch(categoryViewmodelProvider);

    return categoryViewmodel.categoryState is CategoryStateSuccess
        ? Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    categoryViewmodel.categories!.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              categoryViewmodel.categories!.length,
                              (index) {
                                return MyCategoryButton(
                                  title: categoryViewmodel
                                      .categories![index].category,
                                  onPressed: () {
                                    setState(() {
                                      selected = index;
                                    });
                                    ref
                                        .read(
                                            imageListViewmodelProvider.notifier)
                                        .getImageList(
                                          categoryViewmodel
                                              .categories![index].category,
                                        );
                                  },
                                  onLongPressed: () async {
                                    bool isDelete =
                                        await categoryViewmodel.editCategory(
                                      context,
                                      index,
                                    );
                                    if (isDelete) {
                                      if (categoryViewmodel
                                          .categories!.isNotEmpty) {
                                        selected = 0;
                                      }
                                    }
                                  },
                                  isSelected: selected == index,
                                );
                              },
                            ),
                          )
                        : Container(),
                    categoryViewmodel.categories!.isNotEmpty
                        ? MyCategoryButton(
                            title: "업로드",
                            onPressed: () {
                              ref
                                  .read(imageListViewmodelProvider.notifier)
                                  .convertAndUpload(
                                    context,
                                    categoryViewmodel
                                        .categories![selected].category,
                                  );
                            },
                          )
                        : Container(),
                    MyCategoryButton(
                      title: "카테고리추가",
                      onPressed: () {
                        categoryViewmodel.addCategory(context);
                      },
                    ),
                  ],
                ),
              ),
              ResponsiveSizedBox(size: kPaddingLargeSize * 5),
              if (categoryViewmodel.categories!.isNotEmpty)
                Text(
                  categoryViewmodel.categories![selected].category,
                  style: TextStyle(fontSize: kTextLargeSize * 1.5),
                ),
            ],
          )
        : Container();
  }
}
