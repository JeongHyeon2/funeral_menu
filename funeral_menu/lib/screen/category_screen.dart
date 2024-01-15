import 'package:flutter/material.dart';
import 'package:funeral_menu/const/size.dart';

class CategoryScrenen extends StatelessWidget {
  const CategoryScrenen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kPaddingLargeSize),
      child: const Row(
        children: [
          MyCategoryButton(),
        ],
      ),
    );
  }
}

class MyCategoryButton extends StatelessWidget {
  const MyCategoryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: SizedBox(
        width: kIconLargeSize * 10,
        height: kIconLargeSize * 2,
        child: Center(
          child: Text(
            "선택1",
            style: TextStyle(
              fontSize: kTextLargeSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
