import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../dao/login_dao.dart';
import '../../model/login_info_model.dart';
import '../../network/network_message_code.dart';
import '../../pages/login_and_register/login_version_page.dart';
import '../../utils/lxl_easy_loading.dart';
import '../../utils/lxl_screen.dart';
import '../../utils/navigator_util.dart';
import '../../utils/regexp_utils.dart';
import '../../widget/navigation_custom_appbar_widget.dart';

class ForgetSettingNewPasswordPage extends StatefulWidget {
  String phone;

  ForgetSettingNewPasswordPage({Key? key, required this.phone})
      : super(key: key);

  @override
  _ForgetSettingNewPasswordPageState createState() =>
      _ForgetSettingNewPasswordPageState();
}

class _ForgetSettingNewPasswordPageState
    extends State<ForgetSettingNewPasswordPage> {
  // final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController1 = TextEditingController();
  //是否展示密码
  bool _isEntryOn1 = true;
  bool _isEntryOn2 = true;
  bool _isHaveSelected = false;

  @override
  void initState() {
    super.initState();
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

          //判断登录按钮颜色变化的逻辑
          setState(() {
            if ((this._passwordController.text.length > 0 &&
                this._passwordController1.text.length > 0)) {
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: _setNewPasswordLoginWidget(),
      ),
    );
  }

  ///设置新的密码widget
  _setNewPasswordLoginWidget() {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Container(
                    width: LXLScreen.width,
                    child: Text(
                      "设置新的登录密码",
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
                    child: Text(
                      "密码为6~16位，由字母和数字组合",
                      style: TextStyle(
                        color: Color(0xff8F8F8F),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                // color: Colors.red,
                                child: Text(
                                  "密码",
                                  style: TextStyle(
                                    color: Color(0xff222222),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              SizedBox(width: 40),
                              Expanded(
                                child: Container(
                                  child: buildTextField(
                                      _passwordController,
                                      "请输入新密码",
                                      true,
                                      this._isEntryOn1,
                                      TextInputType.text),
                                ),
                              ),
                              Container(
                                // color: Colors.cyan,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      this._isEntryOn1 = !this._isEntryOn1;
                                    });
                                  },
                                  icon: Image.asset(
                                    _isEntryOn1 == true
                                        ? "images/lxl_entry_on.png"
                                        : "images/lxl_entry_off.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          color: Color(0xffeeeeee),
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                // color: Colors.red,
                                child: Text(
                                  "确认密码",
                                  style: TextStyle(
                                    color: Color(0xff222222),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  child: buildTextField(
                                      _passwordController1,
                                      "再次输入新密码",
                                      true,
                                      this._isEntryOn2,
                                      TextInputType.text),
                                ),
                              ),
                              Container(
                                // color: Colors.cyan,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      this._isEntryOn2 = !this._isEntryOn2;
                                    });
                                  },
                                  icon: Image.asset(
                                    _isEntryOn2 == true
                                        ? "images/lxl_entry_on.png"
                                        : "images/lxl_entry_off.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                  SizedBox(height: 50),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                          "确认",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      //跳转验证码页面
                      // NavigatorUtil.push(context, VerificationPage());

                      //忘记密码修改
                      _doForgetPasswordLoginData();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 忘记密码修改
  _doForgetPasswordLoginData() async {
    if (this._passwordController.text == null ||
        this._passwordController.text.length == 0) {
      LXLEasyLoading.showToast("请输入新密码");
      return;
    }
    if (this._passwordController1.text == null ||
        this._passwordController1.text.length == 0) {
      LXLEasyLoading.showToast("请再次输入新密码");
      return;
    }

    if (this._passwordController.text != this._passwordController1.text) {
      LXLEasyLoading.showToast("两次输入密码不一致,请重新输入");
      return;
    }
    print("password text length = ${this._passwordController.text.length}");
    if (this._passwordController.text.length < 6 ||
        this._passwordController.text.length > 16) {
      LXLEasyLoading.showToast("密码6-16位，由数字、字母组成");
      return;
    }
    bool isPasswordTrue =
        RegExpUtils.isLoginPassword(this._passwordController.text);
    if (isPasswordTrue == true) {
      print("密码正确");
    } else {
      print("输入错误");
      LXLEasyLoading.showToast("请正确输入密码");
      return;
    }

    Map params = {
      "pwd": this._passwordController.text,
    };

    LXLEasyLoading.show();
    var response = await LoginDao.doForgetPasswordLoginData(params);
    LogUtil.e("response = ${response}");
    LXLEasyLoading.dismiss();
    if (response == null) return;
    String code = response["code"];
    String message = response["message"];

    if (code == ResponseMessage.SUCCESS_CODE) {
      //成功
      //登录界面
      NavigatorUtil.pushAndRemoveUntil(
          context,
          LoginVersionPage(
              isShowLoginBack: false,
              isVerificationLogin: true,
              isPasswordLogin: false));
    } else {
      // LXLEasyLoading.showToast(
      //     ResponseMessage.getResponseMessageCode(code, message));

      String msg = ResponseMessage.getResponseMessageCode(code, message);
      if (msg == "" || msg == null) {
        return;
      }
      LXLEasyLoading.showToast(msg);
      // LXLEasyLoading.showToast(loginModel.message);
    }
  }
}
