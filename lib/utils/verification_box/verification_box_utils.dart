

import 'package:flutter/material.dart';
// import 'package:umpay_app/utils/verification_box/verification_box.dart';
// import 'package:umpay_app/utils/verification_box/verification_box_item.dart';

import 'package:flutter_verification_box/verification_box.dart';


typedef CallBack = void Function(String str);

class VerificationBoxUtils extends StatefulWidget {
  var onSubmitted;

  VerificationBoxUtils({Key? key, this.onSubmitted}) : super(key: key);

  @override
  _VerificationBoxUtilsState createState() => _VerificationBoxUtilsState();
}

class _VerificationBoxUtilsState extends State<VerificationBoxUtils> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, //Colors.cyan[50],
      height: 50,
      // margin: EdgeInsets.all(20),

      child: VerificationBox(
        // count: 4,
        borderColor: Color(0xffC5CAD5), //Colors.lightBlue,
        borderWidth: 1,
        // borderRadius: 50,
        type: VerificationBoxItemType.underline,
        // type: VerificationBoxItemType.box,
        textStyle: TextStyle(
          color: Color(0xff222222),
          fontSize: 29.0,
        ),
        showCursor: true,
        cursorWidth: 1,
        cursorColor: Color(0xff222222),
        cursorIndent: 10,
        cursorEndIndent: 10,
        focusBorderColor: Color(0xff222222),

        // 输入完成后，默认键盘消失，设置为不消失
        // unfocus: false,
        //验证码输入完成后回调onSubmitted
        // onSubmitted: (value) {
        //   print(" ---> 验证码输入完成 ${value}");

        // },
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
