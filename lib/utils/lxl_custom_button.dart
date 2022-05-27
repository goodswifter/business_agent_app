

import 'package:flutter/material.dart';


class LXLCustomButton extends StatelessWidget {
  final Color color;
  final String text;
  var onClick;
  final double height;
  final double width;
  final double fontSize;
  final double borderRadius;

  LXLCustomButton({
    Key? key,
    this.color = Colors.black,
    this.text = "登录",
    this.onClick = null,
    this.height = 68,
    this.width = double.infinity,
    this.fontSize = 16,
    this.borderRadius = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: this.onClick,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        height: this.height,  //ScreenAdapter.height(this.height),
        width: this.width, //ScreenAdapter.width(this.width),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(this.borderRadius)),
        child: Center(
          child: Text(
            "${text}",
            style: TextStyle(color: Colors.white, fontSize: this.fontSize),
          ),
        ),
      ),
    );
  }
}
