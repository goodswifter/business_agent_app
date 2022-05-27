/*
 * @Author: lixiao
 * @Date: 2021-06-15 12:19:36
 * @LastEditTime: 
 * @LastEditors: 
 * @Description: 验证码页面
 * @FilePath: 
 */

import 'dart:async';
import 'dart:ffi';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dao/login_dao.dart';
import '../../model/login_info_model.dart';
import '../../network/network_message_code.dart';
import '../../pages/login_and_register/forget_setting_new_password_page.dart';
import '../../services/Storage.dart';
import '../../utils/lxl_easy_loading.dart';
import '../../utils/lxl_screen.dart';
import '../../utils/navigator_util.dart';
import '../../utils/verification_box/verification_box_utils.dart';
import '../../widget/lxl_alert_custom_textfield_widget.dart';
import '../../widget/navigation_custom_appbar_widget.dart';
import '../provider/pay_password_alert_textfield_provider.dart';
import '../provider/provider_manager.dart';

typedef CallBack = void Function(Object obj);

class VerificationPage extends StatefulWidget {
  String phone;

  VerificationPage({Key? key, required this.phone}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool isSendCode = false;
  int seconds = 60;
  bool isClickValidate = true;
  bool isStart = false;
  late Timer? t = null;
  late PayPasswordAlertTextFieldProvider _snapshot;
  late String _imgId; //图形id
  late String _verifyCode; //验证码

  //验证码
  String _smsCode = "";

  @override
  void initState() {
    super.initState();

    //获取验证码方法点击事件
    _getVerificationAction();
    //获取短信验证码
    // _requestSmsCodeData();
  }

  //倒计时
  _showTimer() {
    t = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        this.seconds--;
      });
      if (this.seconds == 0) {
        // t!.cancel(); //清除定时器
        if (t != null) {
          if (t!.isActive) t!.cancel();
        }
        setState(() {
          this.isSendCode = true;

          this.isClickValidate = false;
          this.isStart = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderManager.connect<PayPasswordAlertTextFieldProvider>(builder:
        (context, PayPasswordAlertTextFieldProvider snapshot, Widget child) {
      _snapshot = snapshot;
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          leading: Visibility(
            visible: true,
            child: IconButton(
              icon: Image.asset(
                "images/navi_back_images.png",
                fit: BoxFit.cover,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _smsCodeWidget(),
        ),
      );
    });
  }

  //短信验证码widget
  _smsCodeWidget() {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Container(
                  width: LXLScreen.width,
                  child: Text(
                    "输入验证码",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xff151515),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  // width: LXLScreen.width,
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          "短信验证码已经发送至",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xff8F8F8F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        // width: LXLScreen.width,
                        child: Text(
                          // "+86 137****1234",
                          "+86 ${TextUtil.hideNumber(widget.phone)}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xff333333),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Container(
                //   // width: LXLScreen.width,
                //   child: Text(
                //     // "+86 137****1234",
                //     widget.phone,
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //       fontSize: 18.0,
                //       color: Color(0xff333333),
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                SizedBox(height: 30),

                ///获取验证码页面
                VerificationBoxUtils(
                  onSubmitted: (value) {
                    print("~~验证码在页面中回调 value ==> ${value}");

                    //跳转设置新密码页面
                    _toSettingNewPasswordPage(value);
                  },
                ),
                SizedBox(height: 30),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment(-1, 0),
                      child: this.isSendCode == true
                          ? InkWell(
                              child: Container(
                                // color: Colors.red,
                                height: 40,
                                width: 150,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "重新获取验证码",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color(0xffF15A5B),
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                              onTap: () {
                                //重新获取
                                this._sendValidateCode();
                              },
                            )
                          : InkWell(
                              child: Container(
                                // color: Colors.red,
                                height: 40,
                                width: 150,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  // "获取验证码",
                                  this.isClickValidate
                                      ? "获取验证码"
                                      : '${this.seconds}秒后重新获取验证码',

                                  style: TextStyle(
                                    color: this.isClickValidate == true
                                        ? Color(0xffF15A5B)
                                        : Color(0xff222222),
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                              onTap: () {
                                //获取验证码方法点击事件
                                _getVerificationAction();
                              },
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //获取验证码方法
  _getVerificationAction() {
    LogUtil.e("获取验证码按钮点击事件~~~");
    // //跳转验证码页面
    // NavigatorUtil.push(context, VerificationPage());

    if (this.isStart == true) return;

    _getValidateCode();
  }

  ///重新发送验证码
  _sendValidateCode() async {
    // setState(() {
    //   this.isSendCode = false;
    //   this.isClickValidate = false;
    //   this.isStart = true;

    //   this.seconds = 60;
    //   this._showTimer();
    // });

    LXLAlertCustomTextFieldDialog.getRequestImageVerificationData(
        (bytes, imageID) {
      Provider.of<PayPasswordAlertTextFieldProvider>(context, listen: false)
          .setGraphicCodeData(bytes, imageID);
      LXLAlertCustomTextFieldDialog.showAlertDialog(context, bytes, imageID,
          (value, imageID, verifiCode) {
        print("imageID = ${imageID}");
        print("verifiCode = ${verifiCode}");

        if (value == 1) {
          this._imgId = imageID;
          this._verifyCode = verifiCode;
          //获取短信验证码
          _requestSmsCodeData();
        }
      });
    });

    // _getValidateCode();
  }

  ///获取验证码
  _getValidateCode() async {
    this.isClickValidate = false;
    this.isStart = true;
    this._showTimer();
  }

  /*
   * 去设置 新密码 页面
   */
  _toSettingNewPasswordPage(String value) {
    // t.cancel();
    if (t != null) {
      if (t!.isActive) t!.cancel();
    }
    this.isSendCode = true;
    this.isClickValidate = false;
    this.isStart = false;
    setState(() {});

    //复制验证码
    this._smsCode = value;

    //使用验证码登录接口，验证验证码是否正确
    _requestVerificationLoginData((obj) {
      String token = obj as String;
      //跳转设置新密码页面
      NavigatorUtil.push(
          context, ForgetSettingNewPasswordPage(phone: widget.phone));
    });
  }

  /*
   * 验证码登录
   */
  _requestVerificationLoginData(CallBack callback) async {
    Map params = {
      "smsCode": this._smsCode,
      "phone": widget.phone,
    };

    var response = await LoginDao.doVerificationLoginData(params);
    LogUtil.e("response = ${response}");
    if (response == null) return;

    LoginInfoModel loginModel = LoginInfoModel.fromJson(response);

    if (loginModel.code == ResponseMessage.SUCCESS_CODE) {
      //成功
      String? token = loginModel.data!.token;
      String? refreshToken = loginModel.data!.refreshToken;

      //登录成功保存token、refreshToken
      SpUtil.putString("token", token!);
      SpUtil.putString("refreshToken", refreshToken!);

      callback(token);
    } else {
      // LXLEasyLoading.showToast(ResponseMessage.getResponseMessageCode(
      //     loginModel.code, loginModel.message));
      String msg = ResponseMessage.getResponseMessageCode(
          loginModel.code!, loginModel.message!);
      if (msg == "" || msg == null) {
        return;
      }
      LXLEasyLoading.showToast(msg);
    }
  }

  /// 发送短信验证码
  _requestSmsCodeData() async {
    Map params = {
      // "imgId": widget.imgId,
      // "verifyCode": widget.verifyCode,
      "imgId": this._imgId,
      "verifyCode": this._verifyCode,
      "phone": widget.phone,
      "type": RequestMessage.getUserInfoType(UserInfoType.forgetType),
    };

    var response = await LoginDao.doSendSmsCodeData(params);
    LogUtil.e("response = ${response}");
    if (response == null) return;

    String code = response["code"];
    String message = response["message"];
    if (code == ResponseMessage.SUCCESS_CODE) {
      //成功
      LXLEasyLoading.showToast("验证码已发送");

      setState(() {
        this.isSendCode = false;
        this.isClickValidate = false;
        this.isStart = true;

        this.seconds = 60;
        this._showTimer();
      });
    } else {
      String msg = ResponseMessage.getResponseMessageCode(code, message);
      if (msg == "" || msg == null) {
        return;
      }
      LXLEasyLoading.showToast(msg);
    }
  }

  @override
  void dispose() {
    super.dispose();
    // t.cancel();

    if (t != null) {
      if (t!.isActive) t!.cancel();
    }
  }
}
