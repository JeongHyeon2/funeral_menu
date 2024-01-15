import 'package:flutter/material.dart';
import 'package:funeral_menu/common/responsive_sizedbox.dart';
import 'package:funeral_menu/const/size.dart';
import 'package:funeral_menu/screen/category_screen.dart';
import 'package:funeral_menu/screen/listview_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hi"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ResponsiveSizedBox(size: kLayoutGutterSize),
            const CategoryScreen(),
            ResponsiveSizedBox(size: kPaddingLargeSize * 5),
            Text("dddd"),
            ResponsiveSizedBox(size: kPaddingLargeSize * 5),
            const ListViewScreen(),
            ResponsiveSizedBox(size: kLayoutGutterSize),
          ],
        ),
      ),
    );
  }
}
