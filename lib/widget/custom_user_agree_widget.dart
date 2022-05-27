

import 'package:flutter/material.dart';

class CustomUserAgreeWidget extends StatefulWidget {
  bool isSelectedAgree;
  var didSelectedCheckAction;
  var didSelectedUserAgreeAction;
  var didSelectedPrivacyPolicyAction;

  CustomUserAgreeWidget(
      {Key? key,
      required this.isSelectedAgree,
      this.didSelectedCheckAction,
      this.didSelectedUserAgreeAction,
      this.didSelectedPrivacyPolicyAction})
      : super(key: key);

  @override
  _CustomUserAgreeWidgetState createState() => _CustomUserAgreeWidgetState();
}

class _CustomUserAgreeWidgetState extends State<CustomUserAgreeWidget> {
  // 是否选中协议
  // bool _isSelectedAgree = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: SizedBox(
            width: 15,
            height: 15,
            // color: Colors.cyan,
            child: Image.asset(
              widget.isSelectedAgree == false
                  ? "images/icon_no_check.png"
                  : "images/icon_selected_check.png",
              fit: BoxFit.cover,
            ),
          ),
          // onTap: () {
          //   print("选中用户协议");

          //   setState(() {
          //     widget.isSelectedAgree = !widget.isSelectedAgree;
          //   });
          // },
          onTap: widget.didSelectedCheckAction,
        ),
        const SizedBox(width: 5),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: widget.didSelectedCheckAction,
          child: const Text(
            "我已阅读并同意",
            style: TextStyle(
              color: Color(0xff808080),
              fontSize: 12,
            ),
          ),
        ),
        GestureDetector(
          child: const Text(
            "《用户协议》",
            style: TextStyle(
              color: Color(0xff606470),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: widget.didSelectedUserAgreeAction,
        ),
        const Text(
          "和",
          style: TextStyle(
            color: Color(0xff606470),
            fontSize: 12,
            // fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          child: const Text(
            "《隐私政策》",
            style: TextStyle(
              color: Color(0xff606470),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: widget.didSelectedPrivacyPolicyAction,
        ),
      ],
    );
  }
}
