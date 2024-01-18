import 'package:flutter/material.dart';
import 'package:funeral_menu/const/colors.dart';
import 'package:funeral_menu/const/size.dart';

class MyCategoryButton extends StatefulWidget {
  final String title;
  final Function()? onPressed;
  final Function()? onLongPressed;
  final bool isSelected;

  const MyCategoryButton({
    super.key,
    required this.title,
    this.isSelected = false,
    this.onPressed,
    this.onLongPressed,
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
      onLongPress: () {
        if (widget.onLongPressed != null) {
          widget.onLongPressed!();
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            // 기본 색상
            return widget.isSelected ? Colors.black : Colors.grey.withAlpha(0);
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
        width:
            ResponsiveData.kIsMobile ? kIconLargeSize * 2 : kIconLargeSize * 4,
        height: kIconLargeSize * 2,
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize:
                  ResponsiveData.kIsMobile ? kTextMiddleSize : kTextLargeSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
