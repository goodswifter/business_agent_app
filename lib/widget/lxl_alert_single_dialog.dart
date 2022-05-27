import 'package:flutter/material.dart';

/*
 * 自定义 alert dialog
 */

typedef AlertConfirmCallBack = void Function(int value);

class LXLAlertSingleDialog {
  static showAlertDialog(context, String title, String message,
      String confirmTitle, AlertConfirmCallBack confirmCallBack) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: const Color.fromRGBO(0, 0, 0, 0.3), //Colors.black12,
          child: GestureDetector(
            //解决showModalBottomSheet点击消失的问题
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print("123");
              // Navigator.of(context).pop();
              // FocusScope.of(context).requestFocus(FocusNode());
              return;
            },
            child: SimpleDialog(
              contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 20),
              title: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xff666666),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  color: const Color(0xffeeeeee),
                  height: 1,
                ),
                const SizedBox(height: 5),
                SimpleDialogOption(
                  padding: const EdgeInsets.fromLTRB(60, 5, 60, 0),
                  child: Container(
                    // width: 60,
                    // height: 50,
                    decoration: const BoxDecoration(),
                    child: SimpleDialogOption(
                      child: Center(
                        child: Text(
                          confirmTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xffFF5B5D),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onPressed: () {
                        print("----alert  确定点击了-------");
                        Navigator.of(context).pop();
                        // 回调事件
                        confirmCallBack(1);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
