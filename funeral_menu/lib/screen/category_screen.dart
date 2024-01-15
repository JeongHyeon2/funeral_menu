import 'package:flutter/material.dart';
import 'package:funeral_menu/common/category_button.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyCategoryButton(
          title: "자개함",
          onPressed: () {},
        ),
        MyCategoryButton(
          title: "시그니쳐함",
          onPressed: () {},
        ),
        MyCategoryButton(
          title: "진공함",
          onPressed: () {},
        ),
      ],
    );
  }
}
