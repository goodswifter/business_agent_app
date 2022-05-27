import 'package:flutter/material.dart';
import '../../utils/pay_password_utils/custom_keyboard_button.dart';
import '../../utils/pay_password_utils/pay_password.dart' as prefix;

/// 自定义密码 键盘
class MyKeyboard extends StatefulWidget {
  final callback;

  MyKeyboard(this.callback);

  @override
  State<StatefulWidget> createState() {
    return MyKeyboardStat();
  }
}

class MyKeyboardStat extends State<MyKeyboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 定义 确定 按钮 接口  暴露给调用方
  ///回调函数执行体
  var backMethod;
  void onCommitChange() {
    widget.callback(prefix.KeyEvent("commit"));
  }

  void onOneChange(BuildContext cont) {
    widget.callback(prefix.KeyEvent("1"));
  }

  void onTwoChange(BuildContext cont) {
    widget.callback(prefix.KeyEvent("2"));
  }

  void onThreeChange(BuildContext cont) {
    widget.callback(prefix.KeyEvent("3"));
  }

  void onFourChange(BuildContext cont) {
    widget.callback(prefix.KeyEvent("4"));
  }

  void onFiveChange(BuildContext cont) {
    widget.callback(prefix.KeyEvent("5"));
  }

  void onSixChange(BuildContext cont) {
    widget.callback(prefix.KeyEvent("6"));
  }

  void onSevenChange(BuildContext cont) {
    widget.callback(prefix.KeyEvent("7"));
  }

  void onEightChange(BuildContext cont) {
    widget.callback(prefix.KeyEvent("8"));
  }

  void onNineChange(BuildContext cont) {
    widget.callback(prefix.KeyEvent("9"));
  }

  void onZeroChange(BuildContext cont) {
    widget.callback(prefix.KeyEvent("0"));
  }

  /// 点击删除
  void onDeleteChange() {
    widget.callback(prefix.KeyEvent("del"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _scaffoldKey,
      width: double.infinity,
      height: 250.0,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 30.0,
            color: Colors.white,
            alignment: Alignment.center,
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   border:  Border(
            //     top: BorderSide(width: 1, color: Color(0xffeeeeee)),
            //   ),
            // ),
            child: Text(
              // '下滑隐藏',
              "",
              style: TextStyle(fontSize: 12.0, color: Color(0xff999999)),
            ),
          ),

          ///  键盘主体
          Column(
            children: [
              ///  第一行
              Row(
                children: [
                  CustomKbBtn(
                      text: '1', callback: (val) => onOneChange(context)),
                  CustomKbBtn(
                      text: '2', callback: (val) => onTwoChange(context)),
                  CustomKbBtn(
                      text: '3', callback: (val) => onThreeChange(context)),
                ],
              ),

              ///  第二行
              Row(
                children: [
                  CustomKbBtn(
                      text: '4', callback: (val) => onFourChange(context)),
                  CustomKbBtn(
                      text: '5', callback: (val) => onFiveChange(context)),
                  CustomKbBtn(
                      text: '6', callback: (val) => onSixChange(context)),
                ],
              ),

              ///  第三行
              Row(
                children: [
                  CustomKbBtn(
                      text: '7', callback: (val) => onSevenChange(context)),
                  CustomKbBtn(
                      text: '8', callback: (val) => onEightChange(context)),
                  CustomKbBtn(
                      text: '9', callback: (val) => onNineChange(context)),
                ],
              ),

              ///  第四行
              Row(
                children: [
                  // CustomKbBtn(text: '删除', callback: (val) => onDeleteChange()),
                  // CustomKbBtn(
                  //     text: '0', callback: (val) => onZeroChange(context)),
                  // CustomKbBtn(text: '确定', callback: (val) => onCommitChange()),

                  CustomKbBtn(text: '', callback: (val) => onCommitChange()),
                  CustomKbBtn(
                      text: '0', callback: (val) => onZeroChange(context)),
                  CustomKbBtn(text: '删除', callback: (val) => onDeleteChange()),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
