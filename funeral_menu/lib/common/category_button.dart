import 'package:flutter/material.dart';
import 'package:funeral_menu/const/colors.dart';
import 'package:funeral_menu/const/size.dart';

class MyCategoryButton extends StatefulWidget {
  final String title;
  final Function()? onPressed;
  final bool isSelected;

  const MyCategoryButton({
    super.key,
    required this.title,
    this.isSelected = false,
    this.onPressed,
  });

  @override
  State<MyCategoryButton> createState() => _MyCategoryButtonState();
}

class _MyCategoryButtonState extends State<MyCategoryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            // 기본 색상
            return widget.isSelected ? Colors.blue : Colors.green;
          },
        ),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(
            width: 2.0,
            color: buttonBorderColor,
          ),
        ),
      ),
      child: SizedBox(
        width: kIconLargeSize * 4,
        height: kIconLargeSize * 2,
        child: Center(
          child: Text(
            widget.title,
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
