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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  categories.length,
                  (index) {
                    return MyCategoryButton(
                      title: categories[index],
                      onPressed: () {
                        setState(() {
                          selected = index;
                        });
                        viewmodel.getImageList(categories[index]);
                      },
                      isSelected: selected == index,
                    );
                  },
                ),
              ),
              MyCategoryButton(
                title: "업로드",
                onPressed: () {
                  viewmodel.convertAndUpload(
                    context,
                    categories[selected],
                  );
                },
              ),
            ],
          ),
        ),
        ResponsiveSizedBox(size: kPaddingLargeSize * 5),
        Text(
          categories[selected],
          style: TextStyle(fontSize: kTextLargeSize * 1.5),
        ),
      ],
    );
  }
}
