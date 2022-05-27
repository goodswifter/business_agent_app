import 'dart:ui';
import 'package:flutter/material.dart';

/*
eg:
        appBar: BaseViewBar(
        childView: BaseTitleBar(
          "设置",
          leftIcon: Icons.arrow_back_ios,
          // rightText: "提交",
          // rightClick: () {
          //   print("点击了干嘛啊。。。哦");
          // },
        ),
        preferredSize: Size.fromHeight(50.0),
      ),
*/

class BaseViewBar extends PreferredSize {
  Widget childView;
  @override
  final Size preferredSize;

  BaseViewBar({required this.preferredSize, required this.childView})
      : super(child: LimitedBox(), preferredSize: Size(0, 0));

  @override
  Widget build(BuildContext context) {
    Widget current = childView;
    if (childView == null) {
      current = LimitedBox(
        maxWidth: 0.0,
        maxHeight: 0.0,
        child: ConstrainedBox(constraints: const BoxConstraints.expand()),
      );
    }
    return current;
  }
}

class BaseTitleBar extends StatelessWidget {
  String title;
  // IconData leftIcon = Icons.arrow_back_ios;
  String? rightText;
  bool? isBackHidden;
  List<Widget>? actions;
  final VoidCallback? leftClick;
  final VoidCallback? rightClick;

  BaseTitleBar(this.title,
      {this.isBackHidden,
      this.rightText,
      this.leftClick,
      this.rightClick,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        /// 实现渐变色的效果
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          // gradient: LinearGradient(
          //   colors: [
          //     Color.fromRGBO(26, 155, 214, 1),
          //     Color.fromRGBO(54, 209, 193, 1)
          //   ],
          // ),
        ),
      ),
      title: Container(
        child: Text(
          this.title,
          style: TextStyle(
            color: Color(0xff111111),
            fontSize: 18,
          ),
        ),
      ),
      leading: Visibility(
          visible: this.isBackHidden == true ? false : true,
          child: Container(
            child: IconButton(
              icon: Image.asset(
                "images/navi_back_images.png",
                fit: BoxFit.cover,
                // color: Colors.white,
              ),
              onPressed: leftClick,
              // onPressed: () {
              //   Navigator.pop(context);
              // },
            ),
          )),
      // brightness: Brightness.dark,
      elevation: 0.0,
      centerTitle: true,
      actions: this.actions,
      // actions: [
      //   /// 右边的 布局，自己可以添加，是一个widget的一个集合，自已需求添加即可，我这里写了一个Text，和text的点击事件，
      //   RightView(title: rightText, rightClick: rightClick),
      // ],
    );
  }
}

/// 右边的 布局，以及点击事件
class RightView extends StatelessWidget {
  String title;
  VoidCallback rightClick;

  RightView({required this.title, required this.rightClick});

  @override
  Widget build(BuildContext context) {
    var containView;
    if (title != Null) {
      containView = Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: GestureDetector(
          child: Text(
            this.title,
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          onTap: this.rightClick,
        ),
      );
    } else {
      containView = Text("");
    }
    return containView;
  }
}
