import 'package:flutter/material.dart';
import 'package:funeral_menu/const/size.dart';

class ImputDialog {
  final TextEditingController _textEditingController = TextEditingController();

  Future<String> showInputDialog(BuildContext context) async {
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
          content: TextField(
            controller: _textEditingController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(_textEditingController.text);
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
