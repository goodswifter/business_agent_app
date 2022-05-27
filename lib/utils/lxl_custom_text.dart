import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LXLCustomText extends StatelessWidget {
  final String text;
  final bool password;
  var onChanged;
  final int maxLines;
  final double height;
  // final TextEditingController controller;
  var controller;

  LXLCustomText(
      {Key? key,
      this.text = "手机号",
      this.password = false,
      this.onChanged = null,
      this.maxLines = 1,
      this.height = 68,
      this.controller = null})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: TextField(
        controller: controller,
        maxLines: this.maxLines,
        obscureText: this.password,
        decoration: InputDecoration(
            hintText: this.text,
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Color(0xffcccccc),
            ), //设置提示文字样式
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none)),
        onChanged: this.onChanged,
      ),
      height: this.height, //ScreenAdapter.height(this.height),
      //   decoration: BoxDecoration(
      //     // color: Colors.cyan, // Color(0xF6F6F6),
      //       border: Border(
      //         bottom: BorderSide(
      //           width: 1,
      //           color: Color(0xffe9e9e9), //Colors.black12,
      //         )

      //       )
      // ),
    );
  }
}
