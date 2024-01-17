import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funeral_menu/common/category_button.dart';
import 'package:funeral_menu/common/responsive_sizedbox.dart';
import 'package:funeral_menu/const/category.dart';
import 'package:funeral_menu/const/size.dart';
import 'package:funeral_menu/viewmodel/image_list_viewmodel.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(imageListViewmodelProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyCategoryButton(
              title: categories[0],
              onPressed: () {
                setState(() {
                  selected = 0;
                });
                viewmodel.getImageList(categories[0]);
              },
              isSelected: selected == 0,
            ),
            MyCategoryButton(
              title: categories[1],
              onPressed: () {
                setState(() {
                  selected = 1;
                });
              },
              isSelected: selected == 1,
            ),
            MyCategoryButton(
              title: categories[2],
              onPressed: () {
                setState(() {
                  selected = 2;
                });
              },
              isSelected: selected == 2,
            ),
            MyCategoryButton(
              title: "업로드",
              onPressed: () {
                viewmodel.convertAndUpload();
              },
            ),
          ],
        ),
        ResponsiveSizedBox(size: kPaddingLargeSize * 5),
        Text(categories[selected]),
      ],
    );
  }
}
