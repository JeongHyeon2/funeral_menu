import 'package:flutter/material.dart';
import 'package:funeral_menu/common/custom_textfield.dart';
import 'package:funeral_menu/const/size.dart';

class ImputDialog {
  Future<String> showInputDialog(BuildContext context) async {
    String s = "";
    String result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '이름을 입력하세요',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: kTextMiddleSize,
            ),
          ),
          content: StyledTextFieldWidget(
            hintText: "이름을 입력하세요",
            labelText: "이름",
            onChanged: (p0) {
              s = p0;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(s);
              },
              child: Text(
                '확인',
                style: TextStyle(
                  fontSize: kTextMiddleSize,
                ),
              ),
            ),
          ],
        );
      },
    );
    if (result.isNotEmpty) {
      return result;
    }
    return "제목없음";
  }
}
