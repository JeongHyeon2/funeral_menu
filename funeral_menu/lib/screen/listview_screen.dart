import 'package:flutter/material.dart';
import 'package:funeral_menu/common/responsive_sizedbox.dart';
import 'package:funeral_menu/const/size.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/test.jpg',
                    width: kIconLargeSize * 7,
                    height: kIconLargeSize * 7,
                    fit: BoxFit.cover,
                  ),
                ),
                ResponsiveSizedBox(size: kPaddingSmallSize),
                Center(
                  child: Image.asset(
                    'assets/images/test.jpg',
                    width: kIconLargeSize * 7,
                    height: kIconLargeSize * 7,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/test.jpg',
                    width: kIconLargeSize * 7,
                    height: kIconLargeSize * 7,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
        separatorBuilder: (context, index) =>
            ResponsiveSizedBox(size: kPaddingSmallSize),
        itemCount: 10);
  }
}
