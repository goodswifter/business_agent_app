/*
 * @Author: lixiao
 * @Date: 2021-06-15 12:19:36
 * @LastEditTime: 
 * @LastEditors: 
 * @Description: 忘记密码
 * @FilePath: 
 */

import 'dart:convert';
import 'dart:typed_data';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../dao/login_dao.dart';
import '../../model/graphic_verification_model.dart';
import '../../network/network_message_code.dart';
import '../../pages/login_and_register/verification_page.dart';
import '../../utils/lxl_easy_loading.dart';
import '../../utils/lxl_screen.dart';
import '../../utils/navigator_util.dart';

typedef CallBack = void Function(Object obj);

class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _phoneController = TextEditingController();
  //图形验证码
  final _graphicVerificationController = TextEditingController();
  late Uint8List? bytes = null;
  String _imageID = "";
  bool _isHaveSelected = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      //获取图形验证码
      _getRequestImageVerificationData();
    });
  }

  Widget buildTextField(TextEditingController controller, String hintText,
      bool enabled, bool obscureText, TextInputType textInputType) {
    return Container(
      child: TextField(
        controller: controller,
        // maxLength: 30, //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
        maxLines: 1, //最大行数
        autocorrect: true, //是否自动更正
        // autofocus: true, //是否自动对焦
        obscureText: obscureText, //true, //是否是密码
        textAlign: TextAlign.left, //文本对齐方式
        style: TextStyle(
          fontSize: 15.0,
          color: Color(0xff222222),
        ), //输入文本的样式
        // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],//允许的输入格式
        keyboardType: textInputType,
        decoration: InputDecoration(
          // fillColor:
          //     Color(0xffEBEDF1), //Color(0xfff8f8f8), //Colors.blue.shade100,
          // filled: true,
          // labelText: "",

          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xff999999),
            fontSize: 15,
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
        ),
        // enableInteractiveSelection: true,
        onChanged: (text) {
          //内容改变的回调
          print('change $text');
          //判断按钮颜色变化的逻辑
          setState(() {
            if ((this._phoneController.text.length > 0 &&
                this._graphicVerificationController.text.length > 0)) {
              this._isHaveSelected = true;
            } else {
              this._isHaveSelected = false;
            }
          });
        },
        onSubmitted: (text) {
          //内容提交(按回车)的回调
          print('submit $text');
        },
        enabled: enabled, //true, //是否禁用
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              // child: _naviInfoWidget(),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: Column(
                  children: [
                    Container(
                      width: LXLScreen.width,
                      child: Text(
                        "手机号找回",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Color(0xff151515),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: Column(
                        children: [
                          // buildTextField(_phoneController, "请输入手机号", true, false,
                          //     TextInputType.number),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "+86",
                                    style: TextStyle(
                                      color: Color(0xff222222),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: buildTextField(
                                      _phoneController,
                                      "请输入手机号",
                                      true,
                                      false,
                                      TextInputType.number),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            color: Color(0xffeeeeee),
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    _graphicVerificationCode(),
                    SizedBox(height: 50),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        height: 50,
                        decoration: BoxDecoration(
                          // color: Color(0xffFF5B5D),
                          color: this._isHaveSelected == true
                              ? Color(0xffFF5B5D)
                              : Color.fromRGBO(255, 91, 93, 0.3),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            "下一步",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());

                        //获取短信验证码
                        _requestSmsCodeData((obj) {
                          String value = obj as String;
                          //value  1-跳转下一个界面   0-重新获取图形验证码
                          if (value == "1") {
                            //跳转验证码页面
                            NavigatorUtil.push(
                                context,
                                VerificationPage(
                                    phone: this._phoneController.text));
                          } else if (value == "0") {
                            //获取图形验证码
                            _getRequestImageVerificationData();
                          }
                        });

                        // //跳转验证码页面
                        // NavigatorUtil.push(context, VerificationPage());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 图形验证码 widget
  _graphicVerificationCode() {
    return InkWell(
      onTap: () {
        //点击获取图形验证码
        _getRequestImageVerificationData();
      },
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   width: 90,
                  //   // color: Colors.cyan,
                  //   child: Text(
                  //     "图形验证码",
                  //     textAlign: TextAlign.left,
                  //     style: TextStyle(
                  //       color: Color(0xff333333),
                  //       fontSize: 15.0,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Container(
                      // color: Colors.red,
                      padding: EdgeInsets.only(right: 10),
                      child: buildTextField(_graphicVerificationController,
                          "请输入图形验证码", true, false, TextInputType.number),
                    ),
                  ),
                  //图形验证码
                  Container(
                    width: 80, //120,
                    height: 28, //40,
                    // color: Colors.red,
                    child: bytes != null
                        ? (Image.memory(this.bytes!, fit: BoxFit.cover))
                        : Container(),
                    // Image.network(
                    //     "http://jd.itying.com/public/upload/UObZahqPYzFvx_C9CQjU8KiX.png",
                    //     fit: BoxFit.cover)
                  ),
                ],
              ),
            ),
            // Flexible(child: Container()),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: Color(0xffeeeeee),
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  /// 获取图形验证码数据
  _getRequestImageVerificationData() async {
    // var response = await LXLDioHttpManager.getRequestData(
    //     "http://10.10.56.167:8080/app/verificationCode/get");
    // var response = await LXLDioHttpManager.getRequestData(
    //     "app/verificationCode/get");

    // LXLEasyLoading.show();
    var response = await LoginDao.doImageVerificationData();
    // LXLEasyLoading.dismiss();

    // print("${graphicVerificationModel.data}");
    // print("${graphicVerificationModel.data.imgId}");
    if (response == null) return;
    var graphicVerificationModel = GraphicVerificationModel.fromJson(response);

    var base64 = graphicVerificationModel.data!.img!
        .replaceAll('\r', '')
        .replaceAll('\n', '');
    base64 = base64.split(',')[1];
    var bytes = Base64Decoder().convert(base64);

    setState(() {
      // this.imageBase64Str = graphicVerificationModel.data.img;
      this._imageID = graphicVerificationModel.data!.imgId!;
      this.bytes = bytes;
    });
  }

  /// 发送短信验证码
  _requestSmsCodeData(CallBack callback) async {
    if (this._phoneController.text == null ||
        this._phoneController.text == "") {
      LXLEasyLoading.showToast("请输入手机号");
      return;
    }

    if (this._graphicVerificationController.text == null ||
        this._graphicVerificationController.text == "") {
      LXLEasyLoading.showToast("请输入图形验证码");
      return;
    }

    Map params = {
      "imgId": this._imageID,
      "verifyCode": this._graphicVerificationController.text,
      "phone": this._phoneController.text,
      "type": RequestMessage.getUserInfoType(UserInfoType.forgetType),
    };

    var response = await LoginDao.doSendSmsCodeData(params);
    LogUtil.e("response = ${response}");
    if (response == null) return;
    String code = response["code"];
    String message = response["message"];
    if (code == ResponseMessage.SUCCESS_CODE) {
      //成功
      callback("1"); //回调 1、跳转下一个界面
    } else {
      String msg = ResponseMessage.getResponseMessageCode(code, message);
      if (msg == "" || msg == null) {
        return;
      }
      LXLEasyLoading.showToast(msg);
      callback("0"); //0 重新获取
    }
  }
}
