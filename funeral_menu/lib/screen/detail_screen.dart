import 'package:flutter/material.dart';
import 'package:funeral_menu/common/responsive_sizedbox.dart';
import 'package:funeral_menu/const/size.dart';
import 'package:funeral_menu/model/image_model.dart';
import 'package:funeral_menu/screen/base_screen.dart';

class DetailScreen extends StatelessWidget {
  final ImageModel imageModel;
  const DetailScreen({
    super.key,
    required this.imageModel,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          ResponsiveSizedBox(size: kPaddingLargeSize * 10),
          Text(
            imageModel.name,
            style: TextStyle(
              fontSize: kTextLargeSize,
            ),
          ),
          ResponsiveSizedBox(size: kPaddingLargeSize),
          Center(
            child: Hero(
              tag: imageModel.imageLink,
              child: Image.network(
                imageModel.imageLink,
                fit: BoxFit.cover,
                width: kIconLargeSize * 10,
                height: kIconLargeSize * 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
