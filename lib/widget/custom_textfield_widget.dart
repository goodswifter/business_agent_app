

import 'package:flutter/material.dart';

class LXLCustomTextFieldWidget extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  bool enabled;
  bool obscureText;
  TextInputType textInputType;
  var onChanged;
  var onSubmitted;

  LXLCustomTextFieldWidget(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.enabled,
      required this.obscureText,
      required this.textInputType,
      this.onSubmitted,
      this.onChanged})
      : super(key: key);

  @override
  _LXLCustomTextFieldWidgetState createState() =>
      _LXLCustomTextFieldWidgetState();
}

class _LXLCustomTextFieldWidgetState extends State<LXLCustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: widget.controller,
        // maxLength: 30, //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
        maxLines: 1, //最大行数
        autocorrect: true, //是否自动更正
        // autofocus: true, //是否自动对焦
        obscureText: widget.obscureText, //true, //是否是密码
        textAlign: TextAlign.left, //文本对齐方式
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff333333),
        ), //输入文本的样式
        // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],//允许的输入格式
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          // fillColor:
          //     Color(0xffEBEDF1), //Color(0xfff8f8f8), //Colors.blue.shade100,
          // filled: true,
          // labelText: "",

          hintText: widget.hintText,
          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
        ),
        // enableInteractiveSelection: true,
        
        // onChanged: (text) {
        //   //内容改变的回调
        //   print('change $text');
        // },
        onChanged: widget.onChanged,
        // onSubmitted: (text) {
        //   //内容提交(按回车)的回调
        //   print('submit $text');
        // },
        onSubmitted: widget.onSubmitted,
        enabled: widget.enabled, //true, //是否禁用
      ),
    );
  }
}
