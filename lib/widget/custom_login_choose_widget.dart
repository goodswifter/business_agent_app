

import 'package:flutter/material.dart';

typedef CallBack = void Function(bool isVerification, bool isPassword);

class CustomLoginChooseWidget extends StatefulWidget {
  //默认为验证码登录
  bool isVerificationLogin = true;
  //密码登录
  bool isPasswordLogin = false;
  //验证码登录事件
  var didSelectedVerificationLoginAction;
  //密码登录事件
  var didSelectedPasswordLoginAction;
  CallBack callback;

  CustomLoginChooseWidget({
    Key? key,
    required this.isVerificationLogin,
    required this.isPasswordLogin,
    required this.callback,
  }) : super(key: key);

  @override
  _CustomLoginChooseWidgetState createState() =>
      _CustomLoginChooseWidgetState();
}

class _CustomLoginChooseWidgetState extends State<CustomLoginChooseWidget> {
  //默认为验证码登录
  late bool _isVerificationLogin;
  //密码登录
  late bool _isPasswordLogin;

  @override
  void initState() {
    super.initState();

    this._isVerificationLogin = widget.isVerificationLogin;
    this._isPasswordLogin = widget.isPasswordLogin;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      // color: Colors.cyan,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              print("验证码登录点击了");

              setState(() {
                this._isVerificationLogin = true;
                this._isPasswordLogin = false;
              });

              widget.callback(true,false);
            },
            child: Container(
              // color: Colors.red,
              // width: 150,
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "验证码登录",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: this._isVerificationLogin == true ? 20 : 15,
                        fontWeight: this._isVerificationLogin == true
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: this._isVerificationLogin == true ? 2 : 0,
                    width: this._isVerificationLogin == true ? 100 : 80,
                    color: this._isVerificationLogin == true
                        ? Color(0xffff2653)
                        : null,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              print("密码登录点击了");

              setState(() {
                this._isVerificationLogin = false;
                this._isPasswordLogin = true;
              });

              widget.callback(false, true);
            },
            // onTap: widget.didSelectedPasswordLoginAction,
            child: Container(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "密码登录",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: this._isPasswordLogin == true ? 20 : 15,
                        fontWeight: this._isPasswordLogin == true
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: this._isPasswordLogin == true ? 2 : 0,
                    width: this._isPasswordLogin == true ? 80 : 60,
                    color:
                        this._isPasswordLogin == true ? Color(0xffff2653) : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
