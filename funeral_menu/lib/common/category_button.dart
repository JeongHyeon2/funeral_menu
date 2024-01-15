import 'package:flutter/material.dart';
import 'package:funeral_menu/const/colors.dart';
import 'package:funeral_menu/const/size.dart';

class MyCategoryButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  const MyCategoryButton({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(
              width: 2.0,
              color: buttonBorderColor), // Adjust width and color as needed
        ),
      ),
      child: SizedBox(
        width: kIconLargeSize * 5,
        height: kIconLargeSize * 2,
        child: Center(
          child: Text(
            title,
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
