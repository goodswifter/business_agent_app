

import 'package:flutter/material.dart';
import '../../utils/verification_box/verification_box.dart';
import '../../utils/verification_box/verification_box_item.dart';

typedef CallBack = void Function(String str);

class PayPasswordVerificationBoxUtils extends StatefulWidget {
  var onSubmitted;

  PayPasswordVerificationBoxUtils({Key? key, this.onSubmitted})
      : super(key: key);

  @override
  _PayPasswordVerificationBoxUtilsState createState() =>
      _PayPasswordVerificationBoxUtilsState();
}

class _PayPasswordVerificationBoxUtilsState
    extends State<PayPasswordVerificationBoxUtils> {
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
          fontWeight: FontWeight.w900,
        ),
        showCursor: true,
        cursorWidth: 1,
        cursorColor: Color(0xff222222),
        cursorIndent: 10,
        cursorEndIndent: 10,
        focusBorderColor: Color(0xff222222),
        // autoFocus: true,
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
