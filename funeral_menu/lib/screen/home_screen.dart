import 'package:flutter/material.dart';
import 'package:funeral_menu/screen/category_screen.dart';
import 'package:funeral_menu/screen/listview_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "hi",
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CategoryScrenen(),
            ListViewScreen(),
          ],
        ),
      ),
    );
  }
}
