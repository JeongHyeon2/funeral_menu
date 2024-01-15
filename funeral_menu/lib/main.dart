import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funeral_menu/screen/home_screen.dart';

void main() async {
  runApp(
    ScreenUtilInit(
      designSize: const Size(1920, 1080),
      rebuildFactor: RebuildFactors.always,
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
