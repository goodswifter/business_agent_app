// ignore_for_file: unnecessary_brace_in_string_interps

/*
 * @Author: lixiao
 * @Date: 2021-06-15 12:19:36
 * @LastEditTime: 
 * @LastEditors: 
 * @Description: 登录(验证码、 密码)
 * @FilePath: 
 */

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umpay_crossborder_app/core/config/lxl_key_define.dart';
import 'package:umpay_crossborder_app/model/agent_data_info_model.dart';
import 'package:umpay_crossborder_app/pages/tabs/tab_page.dart';

import '../../dao/login_dao.dart';
import '../../dao/user_info_dao.dart';
import '../../model/login_info_model.dart';
import '../../model/user_info_model.dart';
import '../../network/network_message_code.dart';
import '../../pages/login_and_register/forget_password_page.dart';
import '../../utils/lxl_easy_loading.dart';
import '../../utils/lxl_screen.dart';
import '../../utils/navigator_util.dart';
import '../../utils/regexp_utils.dart';
import '../../widget/custom_user_agree_widget.dart';
import '../../widget/navigation_custom_appbar_widget.dart';

typedef CallBack = Function(Object obj);

class LoginVersionPage extends StatefulWidget {
  //是否展示登录返回
  bool? isShowLoginBack;
  //验证码登录
  bool? isVerificationLogin;
  //密码登录
  bool? isPasswordLogin;

  LoginVersionPage({
    Key? key,
    this.isShowLoginBack,
    this.isVerificationLogin,
    this.isPasswordLogin,
  }) : super(key: key);

  @override
  _LoginVersionPageState createState() => _LoginVersionPageState();
}

class _LoginVersionPageState extends State<LoginVersionPage> {
  //默认为验证码登录
  bool _isVerificationLogin = true;
  //密码登录
  bool _isPasswordLogin = false;
  //是否展示密码
  bool _isEntryOn = true;
  //是否选中协议
  bool _isSelectedAgree = false;
  //是否展示登录返回
  bool _isShowLoginBack = false;
  //是否展示密码提示(密码6-16位，由数字、字母组成)
  bool _isShowPasswordPrompt = false;
  //登录按钮是否可点击了
  bool _isHaveSelected = false;

  //编辑控制器
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _verificationController = TextEditingController();
  //图形验证码
  final _graphicVerificationController = TextEditingController();

  bool isSendCode = false;
  int seconds = 60;
  bool isClickValidate = true;
  bool isStart = false;
  late Timer? t;

  // 图片验证码
  late Uint8List? _bytes;
  // 图片验证码id
  // final String _imageID = "";

  /// 代理商app验证码
  String agentVerificaitonData = "";

  @override
  void initState() {
    super.initState();

    // 页面不同逻辑展示的方法事件
    _fromToJudgePageDisplay();

    // SpUtil.putBool("isSelectedAgree", this._isSelectedAgree);
    bool? isSelectedAgree = SpUtil.getBool("isSelectedAgree");
    if (isSelectedAgree != null) {
      _isSelectedAgree = isSelectedAgree;
    }

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      //需要创建的小组件
      //这里获取图形验证码接口
      _getRequestImageVerificationData();
    });
  }

  /// 判断页面展示逻辑
  _fromToJudgePageDisplay() {
    //判断是否展示登录页面的返回按钮
    if (widget.isShowLoginBack == true) {
      _isShowLoginBack = widget.isShowLoginBack!;
    }

    //验证码登录  密码登录
    if (widget.isVerificationLogin == true || widget.isPasswordLogin == true) {
      _isVerificationLogin = widget.isVerificationLogin!;
      _isPasswordLogin = widget.isPasswordLogin!;
    }
  }

  //倒计时
  _showTimer() {
    t = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        seconds--;
      });
      if (seconds == 0) {
        t!.cancel(); //清除定时器
        setState(() {
          isSendCode = true;

          isClickValidate = false;
          isStart = false;
          //重新获取图形验证码
          _getRequestImageVerificationData();
        });
      }
    });
  }

  Widget buildTextField(TextEditingController controller, String hintText,
      bool enabled, bool obscureText, TextInputType textInputType) {
    return TextField(
      controller: controller,
      // maxLength: 30, //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
      maxLines: 1, //最大行数
      autocorrect: true, //是否自动更正
      // autofocus: true, //是否自动对焦
      obscureText: obscureText, //true, //是否是密码
      textAlign: TextAlign.left, //文本对齐方式
      style: const TextStyle(
        fontSize: 15.0,
        color: Color(0xff222222),
      ), //输入文本的样式
      // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],//允许的输入格式
      cursorColor: const Color(0xff222222), //光标颜色
      cursorWidth: 1,
      cursorHeight: 15.0,
      //键盘获取验证码，点击键盘上面的验证码数字，自动补全。。。
      inputFormatters: hintText == "请输入验证码"
          ? [
              // WhitelistingTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ]
          : [],

      keyboardType: textInputType,
      decoration: InputDecoration(
        // fillColor:
        //     Color(0xffEBEDF1), //Color(0xfff8f8f8), //Colors.blue.shade100,
        // filled: true,
        // labelText: "",

        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xff999999),
          fontSize: 15,
        ),
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
      ),
      // enableInteractiveSelection: true,
      onChanged: (text) {
        //内容改变的回调
        print('change $text');

        //判断登录按钮颜色变化的逻辑
        setState(() {
          if ((_phoneController.text.isNotEmpty &&
                  _verificationController.text.isNotEmpty &&
                  _graphicVerificationController.text.isNotEmpty) ||
              (_phoneController.text.isNotEmpty &&
                  _passwordController.text.isNotEmpty)) {
            _isHaveSelected = true;
          } else {
            _isHaveSelected = false;
          }
        });
      },
      onSubmitted: (text) {
        //内容提交(按回车)的回调
        print('submit $text');
      },
      enabled: enabled, //true, //是否禁用
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: _naviInfoWidget(),
      ),
    );
  }

  Widget _naviInfoWidget() {
    return Container(
      // color: Color(0xfff3f3f3),
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 211, //150,
            child: Container(
              width: LXLScreen.width,
              // height: 100,
              decoration: const BoxDecoration(color: Colors.white),
              child: _isShowLoginBack == true
                  ? NavigationCustomAppBarWidget(
                      title: "登录",
                      backAction: () {
                        Navigator.pop(context); //返回上一页
                      })
                  : Container(),
            ),
          ),
          // 主要信息展示widget
          _topInfoWidget(),
        ],
      ),
    );
  }

  ///上部分内容信息widget
  Widget _topInfoWidget() {
    return Positioned(
      top: 0, //130,
      left: 0,
      right: 0,
      height: LXLScreen.height, //- 110,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
          // physics: const NeverScrollableScrollPhysics(), //禁用滑动事件
          children: [
            Container(
              color: Colors.transparent,
              height: 130,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "你好",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Color(0xff151515),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "欢迎登录",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Color(0xff151515),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SizedBox(height: 20),
                  // 验证码登录 或者  密码登录  widget
                  _chooseVerificationOrPasswordLoginWidget(),
                  const SizedBox(height: 30),
                  // SizedBox(height: 50),
                  //登录按钮
                  _loginBtnAction(),
                  const SizedBox(height: 20),
                  //切换密码登录还是验证码登录  -----  惠商户app 一期支持验证码登录
                  // _passwordLoginAndVerificationLoginWidget(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //第三方登录信息的widget
            // _thirdLoginWidget(),

            const SizedBox(height: 10),

            // 自定义同意用户协议和隐私政策
            // _customUserAgreeWidget(),

            const SizedBox(
              height: 300,
            ),
          ],
        ),
        // ),
      ),
    );
  }

  //自定义同意用户协议和隐私政策
  Widget _customUserAgreeWidget() {
    return CustomUserAgreeWidget(
      isSelectedAgree: _isSelectedAgree,
      didSelectedCheckAction: () {
        print("check--check");
        setState(() {
          _isSelectedAgree = !_isSelectedAgree;

          SpUtil.putBool("isSelectedAgree", _isSelectedAgree);
        });
      },
      didSelectedUserAgreeAction: () {
        print("用户协议点击方法回调");
        // String url = "${Config.baseUrl}${LXLKeyDefine.USER_AGREE}";
        // NavigatorUtil.push(
        //     context, MySettingPrivacyPolicyPage(url: url, title: "用户协议"));
      },
      didSelectedPrivacyPolicyAction: () {
        print("隐私政策点击方法回调");
        // String url = "${Config.baseUrl}${LXLKeyDefine.SYSTEM_AGREE}";
        // NavigatorUtil.push(
        //     context, MySettingPrivacyPolicyPage(url: url, title: "隐私政策"));

        // String localUrl = 'assets/1.html';
        // String url = "https://webapp.xinwenda.net/privacy";

        // NavigatorUtil.push(
        //     context, WebViewPage(url: url, isLocalUrl: false, title: '加载本地文件'));

        // NavigatorUtil.push(
        //     context, WebViewPage(url: localUrl, isLocalUrl: true, title: '加载本地文件'));
      },
    );
  }

  ///选择密码登录、还是验证码登录widget
  _passwordLoginAndVerificationLoginWidget() {
    return InkWell(
      onTap: () {
        print("密码点击了");

        setState(() {
          //验证码登录
          _isVerificationLogin = !_isVerificationLogin;
          //密码登录
          _isPasswordLogin = !_isPasswordLogin;
        });
      },
      child: Container(
        // color: Colors.cyan,
        height: 30,
        width: 100,
        alignment: Alignment.center,
        child: Text(
          // "密码登录",
          _isVerificationLogin == false && _isPasswordLogin == true
              ? "验证码登录"
              : "密码登录",
          style: const TextStyle(
            color: Color(0xff5878B4),
            fontSize: 14,
          ),
        ),
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
              margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
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
                      padding: const EdgeInsets.only(right: 10),
                      child: buildTextField(_graphicVerificationController,
                          "请输入验证码", true, false, TextInputType.number),
                    ),
                  ),
                  // 图形验证码
                  Visibility(
                    visible: agentVerificaitonData.isNotEmpty,
                    // visible: true,
                    child: Container(
                      width: 80, //120,
                      height: 28, //40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: agentVerificaitonData != null
                            ? const Color(0xffFF5B5D)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: agentVerificaitonData != null
                          ? Text(
                              agentVerificaitonData,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Container(),
                    ),
                  ),
                ],
              ),
            ),
            // Flexible(child: Container()),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: const Color(0xffE2E4EA),
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  /// 登录按钮事件
  Widget _loginBtnAction() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: 50,
        decoration: BoxDecoration(
          // color: Color.fromRGBO(255, 91, 93, 0.3), //Color(0xffFF5B5D),
          color: _isHaveSelected == true
              ? const Color(0xffFF5B5D)
              : const Color.fromRGBO(255, 91, 93, 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "登录",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
      onTap: () {
        //点击登录按钮的方法
        _didSelectedLoginMethods();
      },
    );
  }

  // 验证码、密码登录的content widget
  Widget _chooseVerificationOrPasswordLoginWidget() {
    // 验证码和密码登录选择
    return _isVerificationLogin == true && _isPasswordLogin == false
        ? _verificationLoginContent()
        : _passwordLoginContent();
  }

  /// 验证码登录 widget
  _verificationLoginContent() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: buildTextField(_phoneController, "请输入手机号", true,
                      false, TextInputType.number),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: const Color(0xffE2E4EA),
              height: 1,
            ),
          ],
        ),
        // SizedBox(height: 10),
        // 图形验证码
        _graphicVerificationCode(),
        const SizedBox(height: 10),
        Column(
          children: [
            // buildTextField(_passwordController, "请输入验证码", true,
            //     false, TextInputType.text),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    // color: Colors.cyan,
                    // width: 180,
                    height: 50,
                    child: buildTextField(_verificationController,
                        "请输入短信验证码", true, false, TextInputType.number),
                  ),
                ),
                // Flexible(child: Container()),
                isSendCode == true
                    ? InkWell(
                        child: Container(
                          // color: Colors.red,
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          height: 40,
                          width: 130,
                          alignment: Alignment.centerRight,
                          child: const Text(
                            "重新获取验证码",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xffff2653),
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        onTap: () {
                          //重新获取
                          _sendValidateCode();
                        },
                      )
                    : InkWell(
                        child: Container(
                          // color: Colors.red,
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          height: 40,
                          width: 130,
                          alignment: Alignment.centerRight,
                          child: Text(
                            // "获取验证码",
                            isClickValidate ? "获取验证码" : '${seconds}s后重新获取',
                            style: TextStyle(
                              color: isClickValidate == true
                                  ? const Color(0xffff5b5d)
                                  : const Color(0xff999999),
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        onTap: () {
                          //获取验证码方法点击事件
                          _getVerificationAction();
                        },
                      ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: const Color(0xffE2E4EA),
              height: 1,
            ),
          ],
        ),
      ],
    );
  }

  /// 密码登录 widget
  _passwordLoginContent() {
    return Column(
      // 密码登录
      children: [
        Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  child: const Text(
                    "+86",
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: buildTextField(_phoneController, "请输入手机号", true, false,
                      TextInputType.number),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: const Color(0xffE2E4EA),
              height: 1,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 50,
                  child: buildTextField(
                    _passwordController,
                    "请输入密码",
                    true,
                    _isEntryOn,
                    TextInputType.text,
                  ),
                )),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isEntryOn = !_isEntryOn;
                    });
                  },
                  icon: Image.asset(
                    _isEntryOn == true
                        ? "images/lxl_entry_on.png"
                        : "images/lxl_entry_off.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: const Color(0xffE2E4EA),
              height: 1,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
          child: Stack(
            children: [
              Align(
                alignment: const Alignment(-1, 0),
                child: Visibility(
                    visible: _isShowPasswordPrompt,
                    child: Container(
                      // color: Colors.red,
                      height: 25,
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "密码6-16位，由数字、字母组成",
                        style: TextStyle(
                          color: Color(0xffF15A5B),
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ),
              Align(
                alignment: const Alignment(1, 0),
                child: InkWell(
                  child: Container(
                    height: 25,
                    width: 60,
                    // color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: const Text(
                      "忘记密码",
                      style: TextStyle(
                        color: Color(0xff858585),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  onTap: () {
                    // 跳转忘记密码页面
                    NavigatorUtil.push(context, ForgetPasswordPage());
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 获取验证码方法
  _getVerificationAction() {
    LogUtil.e("获取验证码按钮点击事件~~~");
    // //跳转验证码页面
    // NavigatorUtil.push(context, VerificationPage());

    if (_phoneController.text == "") {
      LXLEasyLoading.showToast("请输入手机号");
      return;
    }

    if (_graphicVerificationController.text == "") {
      LXLEasyLoading.showToast("请输入图形验证码");
      return;
    }

    if (isStart == true) return;

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

    _getValidateCode();
  }

  ///获取验证码
  _getValidateCode() async {
    // this.isClickValidate = false;
    // this.isStart = true;
    // this._showTimer();

    _requestSmsCodeData();
  }

  /// 点击登录按钮的方法
  _didSelectedLoginMethods() {
    LogUtil.e("点击登录按钮");

    //惠商 商户app 暂时没有用户协议  暂时取消
    // if (!this._isSelectedAgree) {
    //   LXLEasyLoading.showToast("请先勾选用户协议和隐私政策");
    //   return;
    // }

    //验证码登录
    if (_isVerificationLogin == true && _isPasswordLogin == false) {
      LogUtil.e("验证码登录");

      _requestVerificationLoginData((obj) {
        ///惠商登录信息。
        AgentDataInfoModel agentInfoModel = obj as AgentDataInfoModel;
        //返回到根-进入首页
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const TabPage(indexPage: 0)),
            (route) => route == null);

        // String token = obj as String;
        // //获取用户信息，跳转首页
        // _requestGetUserInfoData(token);
      });
    } else if (_isVerificationLogin == false && _isPasswordLogin == true) {
      LogUtil.e("密码登录");

      //密码登录
      _requestPasswordLoginData((obj) {
        String token = obj as String;
        //获取用户信息，跳转首页
        _requestGetUserInfoData(token);
      });
    }
  }

  /// 获取图形验证码数据
  _getRequestImageVerificationData() async {
    var response = await LoginDao.doImageVerificationData();
    LogUtil.e("response = ${response}");

    if (response != null) {
      if (response["resData"] is String) {
        var jsonData = jsonDecode(response["resData"]);
        String verificationData = jsonData[0]["code"];
        setState(() {
          agentVerificaitonData = verificationData;
        });
      }
    }
  }

  /// 发送短信验证码
  _requestSmsCodeData() async {
    Map params = {
      "telNumber": _phoneController.text,
      "imageCode": agentVerificaitonData,
      "userImageCode": _graphicVerificationController.text,
    };

    var response = await LoginDao.doSendSmsCodeData(params);
    LogUtil.e("response = ${response}");
    if (response == null) return;
    String code = response["retCode"];
    String message = response["retMsg"];
    if (code == ResponseMessage.SUCCESS_CODE) {
      // 成功
      LXLEasyLoading.showToast(message);

      setState(() {
        isSendCode = false;
        isClickValidate = false;
        isStart = true;

        seconds = 60;
        _showTimer();
      });
    } else {
      LXLEasyLoading.showToast(message);
    }
  }

  /// 验证码登录
  _requestVerificationLoginData(CallBack callback) async {
    if (_phoneController.text == "") {
      LXLEasyLoading.showToast("请输入手机号");
      return;
    }

    if (!RegexUtil.isMobileSimple(_phoneController.text)) {
      LXLEasyLoading.showToast("请正确输入手机号");
      return;
    }

    if (_graphicVerificationController.text == "") {
      LXLEasyLoading.showToast("请输入图形验证码");
      return;
    }

    if (_verificationController.text == "") {
      LXLEasyLoading.showToast("请输入验证码");
      return;
    }

    Map params = {
      "phoneCode": _verificationController.text,
      "telNumber": _phoneController.text,
    };

    LXLEasyLoading.show();
    var response = await LoginDao.doVerificationLoginData(params);
    LXLEasyLoading.dismiss();
    LogUtil.e("response = ${response}");
    if (response == null) return;
    String code = response["retCode"];
    String message = response["retMsg"];
    // LoginInfoModel loginModel = LoginInfoModel.fromJson(response);

    //  {"retCode":"0000","retMsg":"处理成功",
    //  "resData":"[{\"agentId\":\"001\",\"password\":\"123456\",\"loginType\":0,
    // \"mobile\":\"13716139232\",\"agentName\":\"代理商01\",\"userName\":\"测试0524\",\"status\":1}]"}

    if (code == ResponseMessage.SUCCESS_CODE) {
      var resJsonDataStr = response["resData"];
      if (resJsonDataStr is String) {
        var resData = jsonDecode(resJsonDataStr);
        Map resDataMap = resData[0];
        AgentDataInfoModel agentDataInfoModel =
            AgentDataInfoModel.fromJson(resDataMap as Map<String, dynamic>);
        // LogUtil.e("${agentDataInfoModel.mobile}");

        //本地保存代理商信息
        SpUtil.putObject(LXLKeyDefine.agentUserDataInfoKey, agentDataInfoModel);
        //存储手机号
        if (agentDataInfoModel.mobile != null) {
          SpUtil.putString(
              LXLKeyDefine.agentUserMobileKey, agentDataInfoModel.mobile!);
        }
        callback(agentDataInfoModel);
      }
    } else {
      LXLEasyLoading.showToast(message);

      // 这里获取图形验证码接口
      _getRequestImageVerificationData();
    }
  }

  /// 密码登录
  _requestPasswordLoginData(CallBack callback) async {
    if (_phoneController.text == "") {
      LXLEasyLoading.showToast("请输入手机号");
      return;
    }

    if (!RegexUtil.isMobileSimple(_phoneController.text)) {
      LXLEasyLoading.showToast("请正确输入手机号");
      return;
    }

    if (_passwordController.text == "") {
      LXLEasyLoading.showToast("请输入密码");
      return;
    }

    // 设置密码是否正确
    print("password text length = ${_passwordController.text.length}");
    if (_passwordController.text.length < 6 ||
        _passwordController.text.length > 16) {
      setState(() {
        _isShowPasswordPrompt = true;
      });
      LXLEasyLoading.showToast("密码6-16位，由数字、字母组成");
      return;
    }
    bool isPasswordTrue = RegExpUtils.isLoginPassword(_passwordController.text);
    if (isPasswordTrue == true) {
      print("密码正确");
      setState(() {
        _isShowPasswordPrompt = false;
      });
    } else {
      print("输入错误");
      setState(() {
        _isShowPasswordPrompt = true;
      });
      LXLEasyLoading.showToast("请正确输入密码");
      return;
    }

    // String passwordEncode = EncryptUtil.encodeMd5(this._phoneController.text);

    Map params = {
      // "phone": passwordEncode,
      "phone": _phoneController.text,
      "password": _passwordController.text,
    };

    LXLEasyLoading.show();
    var response = await LoginDao.doPasswordLoginData(params);
    LXLEasyLoading.dismiss();
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
      if (msg == "") {
        return;
      }
      LXLEasyLoading.showToast(msg);
    }
  }

  /// 获取用户信息
  _requestGetUserInfoData(String token) async {
    Map params = {
      // "token": token,
    };

    var response = await UserInfoDao.doGetUserInfoData();
    LogUtil.e("response = ${response}");
    if (response == null) return;
    UserInfoModel userItemModel = UserInfoModel.fromJson(response);

    if (userItemModel.code == ResponseMessage.SUCCESS_CODE) {
      //保存用户信息
      // SpUtil.putObject(LXLKeyDefine.USER_INFO_ITEM_KEY, userItemModel);

      //返回到根-进入首页
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const TabPage(indexPage: 0)),
          (route) => route == null);
    } else {
      // LXLEasyLoading.showToast(ResponseMessage.getResponseMessageCode(
      //     userItemModel.code, userItemModel.message));

      String msg = ResponseMessage.getResponseMessageCode(
          userItemModel.code, userItemModel.message);
      if (msg == "") {
        return;
      }
      LXLEasyLoading.showToast(msg);
      // LXLEasyLoading.showToast(loginMode l.message);
    }
  }

  @override
  void dispose() {
    super.dispose();

    if (t != null) {
      if (t!.isActive) t!.cancel();
    }
  }
}
