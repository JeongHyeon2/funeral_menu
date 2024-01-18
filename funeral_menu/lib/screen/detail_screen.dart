import 'package:flutter/material.dart';
import 'package:funeral_menu/common/custom_textfield.dart';
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
          ResponsiveSizedBox(size: kPaddingLargeSize * 3),
          Padding(
            padding: EdgeInsets.all(kPaddingLargeSize),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: kIconLargeSize * 2,
                      child: Text("이름"),
                    ),
                    ResponsiveSizedBox(size: kPaddingSmallSize),
                    SizedBox(
                      width: kIconLargeSize * 7,
                      child: StyledTextFieldWidget(
                        labelText: '이름',
                        hintText: '이름을 입력하세요',
                        onChanged: (value) {
                          // Handle the text change
                          print('Typed: $value');
                        },
                      ),
                    ),
                  ],
                ),
                ResponsiveSizedBox(size: kPaddingLargeSize),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: kIconLargeSize * 2,
                      child: Text("전화번호"),
                    ),
                    ResponsiveSizedBox(size: kPaddingSmallSize),
                    SizedBox(
                      width: kIconLargeSize * 7,
                      child: StyledTextFieldWidget(
                        labelText: '전화번호',
                        hintText: '전화번호를 입력하세요',
                        onChanged: (value) {
                          // Handle the text change
                          print('Typed: $value');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
