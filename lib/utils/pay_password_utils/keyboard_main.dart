// import 'package:flustars/flustars.dart';
// import 'package:flutter/material.dart';
// import '../../config/lxl_key_define.dart';
// import '../../dao/set_password_dao.dart';
// import '../../dao/user_info_dao.dart';
// import '../../model/user_info_model.dart';
// import '../../network/network_message_code.dart';
// import '../../pages/my/my_setting/my_setting.dart';
// import '../../pages/my/pay_password/pay_password_forget_phone_page.dart';
// import '../../pages/my/pay_password/pay_password_item_input_widget.dart';
// import '../../pages/my/pay_password/pay_password_main_keyboard_page.dart';
// import '../../pages/tabs/Tabs.dart';
// import '../../provider/pay_password_provider.dart';
// import '../../provider/provider_manager.dart';
// import '../../services/EventBus.dart';
// import '../../utils/determine_user_real_name_status_utils.dart';
// import '../../utils/lxl_easy_loading.dart';
// import '../../utils/lxl_flutter_toast.dart';
// import '../../utils/lxl_screen.dart';
// import '../../utils/navigator_util.dart';
// import '../../utils/pay_password_utils/custom_password_field_widget.dart';
// import '../../utils/pay_password_utils/keyboard_widget.dart';
// import '../../utils/pay_password_utils/pay_password.dart' as prefix;
// import '../../widget/lxl_alert_custom_dialog.dart';
// import '../../widget/lxl_alert_single_dialog.dart';

// typedef CallBack = void Function(String str);
// typedef UserCallBack = void Function(Object obj);

// // enum MainKeyboardType {
// //   DEFAULT_FIRST_SET_PASSWORD, //默认第一次设置密码
// //   DEFAULT_SECOND_SET_PASSWORD, //默认第二次设置密码
// //   MODIFY_OLD_PASSWORD, //修改原密码
// //   MODIFY_FIRST_PASSWORD, //第一次修改新密码
// //   MODIFY_SECOND_PASSWORD, //第二次修改新密码
// //   FORGET_FIRST_PASSWORD, //忘记密码 第一次密码
// //   FORGET_SECOND_PASSWORD, //忘记密码 第二次密码
// // }

// /// 支付密码  +  自定义键盘
// class main_keyboard extends StatefulWidget {
//   //支付文案类型
//   MainKeyboardType type;

//   main_keyboard({Key? key, required this.type});

//   @override
//   State<StatefulWidget> createState() {
//     return keyboardState();
//   }
// }

// class keyboardState extends State<main_keyboard> {
//   String pwdData = '';
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   // late VoidCallback _showBottomSheetCallback;
//   late var _showBottomSheetCallback;

//   //支付文案类型
//   MainKeyboardType _type = MainKeyboardType.DEFAULT_FIRST_SET_PASSWORD;

//   String? firstPasswordStr = "";
//   String? secondPasswordStr = "";
//   String? oldPassword = "";

//   late UserInfoModel _userItemModel;
//   late PayPasswordProvider _snapshot;
//   late String _idCardNumberStr;

//   @override
//   void initState() {
//     _showBottomSheetCallback = _showBottomSheet;

//     //文案类型赋值
//     this._type = widget.type;

//     //获取用户信息
//     _requestGetUserInfoData((obj) {
//       this._userItemModel = obj as UserInfoModel;
//     });

//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       //需要创建的小组件
//       _showBottomSheet(); //弹出键盘
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ProviderManager.connect<PayPasswordProvider>(
//         builder: (context, PayPasswordProvider snapshot, Widget child) {
//       this._snapshot = snapshot;

//       return Scaffold(
//         key: _scaffoldKey,
//         body: InkWell(
//           onTap: () {
//             //收回键盘
//             // Navigator.pop(context);
//           },
//           child: _buildContent(context),
//         ),
//       );
//     });
//   }

//   Widget _buildContent(BuildContext c) {
//     return Container(
//       // width: double.maxFinite,
//       // height: 300.0,
//       width: LXLScreen.width,
//       height: LXLScreen.height,
//       color: Color(0xffffffff),
//       child: Column(
//         children: [
//           SizedBox(height: 50),
//           Container(
//             alignment: Alignment.centerLeft,
//             margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
//             child: Text(
//               // "请设置新的支付密码",
//               this._getSettingPasswordKeyboardType(this._type),
//               style: TextStyle(
//                 color: Color(0xff151515),
//                 fontSize: 25.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           Container(
//             alignment: Alignment.centerLeft,
//             margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
//             child: Text(
//               "请牢记您的支付密码，将用于支付及身份验证",
//               style: TextStyle(
//                 color: Color(0xff999999),
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.only(top: 30.0),
//           //   child: Text(
//           //     // '请输入6位支付密码',
//           //     this._getSettingPasswordKeyboardType(this._type), //获取提醒信息
//           //     style: TextStyle(fontSize: 15.0, color: Color(0xff222222)),
//           //   ),
//           // ),
//           SizedBox(height: 30),

//           ///密码框
//           Padding(
//             padding: const EdgeInsets.only(top: 15.0),
//             child: _buildPwd(pwdData),
//           ),

//           Visibility(
//             visible: this._type == MainKeyboardType.MODIFY_OLD_PASSWORD
//                 ? true
//                 : false,
//             child: Padding(
//               // padding: const EdgeInsets.only(top: 20.0),
//               padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
//               child: InkWell(
//                 child: Container(
//                   height: 30,
//                   // width: 200,
//                   // color: Colors.red,
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     '短信验证码验证',
//                     style:
//                         TextStyle(fontSize: 12.0, color: Colors.blue[500]),
//                   ),
//                 ),
//                 onTap: () {
//                   LogUtil.e("短信验证码验证点击了");
//                   //跳转忘记支付密码
//                   //忘记6位数字支付密码
//                   // NavigatorUtil.push(context, PayPasswordForgetPhonePage());
//                   NavigatorUtil.pushReplacement(
//                       context, PayPasswordForgetPhonePage());
//                 },
//               ),
//             ),
//           ),

// //          Padding(
// //            padding: const EdgeInsets.only(top: 30.0), //0xffff0303
// //            child: Text(
// //              '密码输入错误，还可输入2次，超出将锁定账户。',
// //              style: TextStyle(fontSize: 12.0, color: Color(0xffffffff)),
// //            ),
// //          ),
//         ],
//       ),
//     );
//   }

//   /// 密码键盘 确认按钮 事件
//   void onAffirmButton() {
//     print("确定点击了---- ${pwdData}");
//     //收回键盘
//     Navigator.pop(context);

//     //点击确认密码事件
//     _didConfirmPasswordAction();
//   }

//   void _onKeyDown(prefix.KeyEvent data) {
//     if (data.isDelete()) {
//       if (pwdData.length > 0) {
//         pwdData = pwdData.substring(0, pwdData.length - 1);
//         setState(() {});
//       }
//     } else if (data.isCommit()) {
//       if (pwdData.length != 6) {
//         //  Fluttertoast.showToast(msg: "密码不足6位，请重试", gravity: ToastGravity.CENTER);
//         // LXLFlutterToast.setToast("密码不足6位，请重试");
//         return;
//       }
//       onAffirmButton();
//     } else {
//       if (pwdData.length < 6) {
//         pwdData += data.key;
//       }
//       if (pwdData.length > 5) {
//         onAffirmButton();
//       }

//       setState(() {});
//     }
//   }

//   /// 底部弹出 自定义键盘  下滑消失
//   void _showBottomSheet() {
//     setState(() {
//       // disable the button
//       _showBottomSheetCallback = null;
//     });
//     _scaffoldKey.currentState!
//         .showBottomSheet<void>(
//           (BuildContext context) {
//             return MyKeyboard(_onKeyDown);
//           },
//         )
//         .closed
//         .whenComplete(() {
//           if (mounted) {
//             setState(() {
//               // re-enable the button
//               _showBottomSheetCallback = _showBottomSheet;
//             });
//           }
//         });
//   }

//   Widget _buildPwd(var pwd) {
//     return GestureDetector(
//       child: Container(
//         width: 300.0,
//         height: 50.0,
//         //  color: Colors.red,
//         child: CustomJPasswordField(pwd),
//       ),
//       onTap: () {
//         _showBottomSheetCallback();
//       },
//     );
//   }

//   /*
//    * 点击确认密码事件
//    */
//   _didConfirmPasswordAction() {
//     //判断输入是否当前为原密码
//     if (this._type == MainKeyboardType.MODIFY_OLD_PASSWORD) {
//       //原密码暂存赋值
//       // this.oldPassword = pwdData;
//       SpUtil.putString("oldPassword", pwdData);
//     }

//     //******* 第二次 设置密码
//     //以下逻辑判断，是为了控制输入密码的次数，便于返回设置页面和接口调试
//     if (this._type == MainKeyboardType.DEFAULT_SECOND_SET_PASSWORD ||
//         this._type == MainKeyboardType.FORGET_SECOND_PASSWORD ||
//         this._type == MainKeyboardType.MODIFY_SECOND_PASSWORD) {
//       //已经输入两次了，可以调用接口用于验证延段支付是否正确
//       // this.secondPasswordStr = pwdData;
//       SpUtil.putString("secondPasswordStr", pwdData);

//       //lixiao add ...获取各个密码
//       //获取原密码
//       this.oldPassword = SpUtil.getString("oldPassword");
//       //获取第一次输入的密码
//       this.firstPasswordStr = SpUtil.getString("firstPassword");
//       //获取第二次输入的密码
//       this.secondPasswordStr = SpUtil.getString("secondPasswordStr");

//       LogUtil.e("old password = ${this.oldPassword}");
//       LogUtil.e("first password = ${this.firstPasswordStr}");
//       LogUtil.e("second password = ${this.secondPasswordStr}");

//       //判断密码是否相同
//       if (this.firstPasswordStr != this.secondPasswordStr) {
//         //alert 弹框提示用户
//         LXLAlertSingleDialog.showAlertDialog(
//             context, "温馨提示", "您两次输入的密码不一致，请重试", "重新输入", (value) {
//           LogUtil.e("log 确认按钮回调了");
//           _showBottomSheet(); //弹出键盘
//         });
//         return;
//       }

//       //设置支付密码成功 0 未设置  1 已经设置
//       //用于在我的设置页面判断，点击支付密码跳转界面
//       SpUtil.putInt("isSetPayPassword", 1);

//       //根据不同类型，请求不同参数的接口形式
//       _requestPayPasswordData(this._type, this.firstPasswordStr!,
//           this.secondPasswordStr!, this.oldPassword!);

//       // Navigator.pop(context);
//       //返回到根-进入我的界面
//       // Navigator.of(context).pushAndRemoveUntil(
//       //     MaterialPageRoute(builder: (context) => Tabs(indexPage:3)),
//       //     (route) => route == null);
//       return;
//     }

//     //******* 第一次 设置密码，暂存第一次密码，再跳转第二次确认密码
//     // this.firstPasswordStr = pwdData;
//     SpUtil.putString("firstPassword", pwdData);
//     //替换路由的方式进行页面跳转，便于修改密码后返回设置页面
//     _jumpToSecondPayPasswordMainKeyboardPage();
//   }

//   /*
//    * 根据不同类型进行跳转界面
//    * 根据上一个界面判断跳转下一个界面
//    */
//   _jumpToSecondPayPasswordMainKeyboardPage() {
//     switch (this._type) {
//       case MainKeyboardType.DEFAULT_FIRST_SET_PASSWORD:
//         NavigatorUtil.pushReplacement(
//             context,
//             PayPasswordMainKeyboardPage(
//                 type: MainKeyboardType.DEFAULT_SECOND_SET_PASSWORD));
//         break;
//       case MainKeyboardType.FORGET_FIRST_PASSWORD:
//         NavigatorUtil.pushReplacement(
//             context,
//             PayPasswordMainKeyboardPage(
//                 type: MainKeyboardType.FORGET_SECOND_PASSWORD));
//         break;
//       case MainKeyboardType.MODIFY_FIRST_PASSWORD:
//         NavigatorUtil.pushReplacement(
//             context,
//             PayPasswordMainKeyboardPage(
//                 type: MainKeyboardType.MODIFY_SECOND_PASSWORD));
//         break;
//       case MainKeyboardType.MODIFY_OLD_PASSWORD:
//         NavigatorUtil.pushReplacement(
//             context,
//             PayPasswordMainKeyboardPage(
//                 type: MainKeyboardType.MODIFY_FIRST_PASSWORD));
//         break;
//       default:
//         break;
//     }
//   }

//   /*
//    * 获取支付密码提示信息文案
//    * currentPromptStr 当前文案信息
//    */
//   String _getSettingPasswordKeyboardType(MainKeyboardType type) {
//     String currentPromptStr = "";
//     switch (type) {
//       case MainKeyboardType.DEFAULT_FIRST_SET_PASSWORD:
//         // currentPromptStr = "请设置6位支付密码";
//         currentPromptStr = "请设置新的支付密码";
//         break;
//       case MainKeyboardType.DEFAULT_SECOND_SET_PASSWORD:
//         // currentPromptStr = "请再次输入6位支付密码";
//         currentPromptStr = "请再次输入支付密码";
//         break;
//       case MainKeyboardType.MODIFY_OLD_PASSWORD:
//         // currentPromptStr = "请输入6位原支付密码";
//         currentPromptStr = "请输入原支付密码";
//         break;
//       case MainKeyboardType.MODIFY_FIRST_PASSWORD:
//         // currentPromptStr = "请设置6位支付密码";
//         currentPromptStr = "请设置新的支付密码";
//         break;
//       case MainKeyboardType.MODIFY_SECOND_PASSWORD:
//         currentPromptStr = "请再次输入支付密码";
//         break;
//       case MainKeyboardType.FORGET_FIRST_PASSWORD:
//         // currentPromptStr = "请设置6位支付密码";
//         currentPromptStr = "请设置新的支付密码";
//         break;
//       case MainKeyboardType.FORGET_SECOND_PASSWORD:
//         currentPromptStr = "请再次输入支付密码";
//         break;
//       default:
//         break;
//     }

//     return currentPromptStr;
//   }

//   /*
//    * 根据不同类型进行传递参数， 便于接口传递
//    * 
//    * type 分别为 
//    * DEFAULT_SECOND_SET_PASSWORD
//    * FORGET_SECOND_PASSWORD
//    * MODIFY_SECOND_PASSWORD
//    * 
//    * 区分不同接口
//    */
//   _requestPayPasswordData(MainKeyboardType type, String firstPassword,
//       String secondPassword, String oldPassword) {
//     LogUtil.e("---> old password = ${this.oldPassword}");
//     LogUtil.e("--->first password = ${this.firstPasswordStr}");
//     LogUtil.e("--->second password = ${this.secondPasswordStr}");

//     switch (type) {
//       case MainKeyboardType.DEFAULT_SECOND_SET_PASSWORD:
//         //第一次支付密码
//         print("第一次支付密码");
//         Map params = {
//           "payPwd": this.secondPasswordStr,
//         };
//         _doPayPasswwordData(params, (str) {
//           Navigator.pop(context);
//           //获取用户信息
//           _requestGetUserInfoData((obj) {
//             //事件广播通知不展示未设置了。。。
//             eventBus.fire(SetNotificatonEvent(true));
//           });
//         });
//         break;
//       case MainKeyboardType.FORGET_SECOND_PASSWORD:
//         {
//           //忘记支付密码
//           print("忘记支付密码");
//           String type = "";
//           String value = "";

//           String? typeStr = this._userItemModel.userItem!.type;
//           if (typeStr == "C") {
//             //个人身份证号
//             type = DetermineUserRealNameStatusUtils.C_0102;
//             value = this._snapshot.idCardStr;
//           } else {
//             //企业营业执照号
//             type = DetermineUserRealNameStatusUtils.ENTERPRISE_0202;
//             value = this._snapshot.businessNoStr;
//           }

//           List userExts = [
//             {"type": type, "value": value}
//           ];

//           Map params = {
//             "payPwd": this.secondPasswordStr,
//             "userExts": userExts,
//           };

//           _doModifyPayPasswwordData(params, (str) {
//             Navigator.pop(context);
//             //获取用户信息
//             _requestGetUserInfoData((obj) {});
//           });
//         }
//         break;
//       case MainKeyboardType.MODIFY_SECOND_PASSWORD:
//         //修改支付密码
//         print("修改支付密码");
//         Map params = {
//           "oldPayPwd": this.oldPassword,
//           "payPwd": this.secondPasswordStr,
//         };
//         _doModifyPayPasswwordData(params, (str) {
//           Navigator.pop(context);
//           //获取用户信息
//           _requestGetUserInfoData((obj) {});
//         });
//         break;
//       default:
//     }

//     // Navigator.pop(context);
//   }

//   //设置、忘记 - 支付密码接口请求
//   _doPayPasswwordData(Map params, CallBack callback) async {
//     LXLEasyLoading.show();
//     var response = await SetPasswordDao.doPayPasswwordData(params);
//     LogUtil.e("response = ${response}");
//     LXLEasyLoading.dismiss();
//     if (response == null) return;
//     String code = response["code"];
//     String message = response["message"];

//     if (code == ResponseMessage.SUCCESS_CODE) {
//       //成功

//       LXLEasyLoading.showToast("支付密码设置成功！");
//       callback("去获取用户信息");
//     } else {
//       String msg = ResponseMessage.getResponseMessageCode(code, message);
//       if (msg == "" || msg == null) {
//         return;
//       }
//       LXLEasyLoading.showToast(msg);
//     }
//   }

//   //修改支付密码接口请求
//   _doModifyPayPasswwordData(Map params, CallBack callback) async {
//     LXLEasyLoading.show();
//     var response = await SetPasswordDao.doModifyPayPasswwordData(params);
//     LogUtil.e("response = ${response}");
//     LXLEasyLoading.dismiss();
//     if (response == null) return;
//     String code = response["code"];
//     String message = response["message"];

//     if (code == ResponseMessage.SUCCESS_CODE) {
//       //成功

//       LXLEasyLoading.showToast("支付密码修改成功！");
//       callback("去获取用户信息");
//     } else {
//       String msg = ResponseMessage.getResponseMessageCode(code, message);
//       if (msg == "" || msg == null) {
//         return;
//       }
//       LXLEasyLoading.showToast(msg);
//     }
//   }

//   /// 获取用户信息
//   _requestGetUserInfoData(UserCallBack callback) async {
//     var response = await UserInfoDao.doGetUserInfoData();
//     LogUtil.e("response = ${response}");
//     if (response == null) return;
//     UserInfoModel userItemModel = UserInfoModel.fromJson(response);

//     if (userItemModel.code == ResponseMessage.SUCCESS_CODE) {
//       //保存用户信息
//       SpUtil.putObject(LXLKeyDefine.USER_INFO_ITEM_KEY, userItemModel);
//       callback(userItemModel);
//     } else {
//       String msg = ResponseMessage.getResponseMessageCode(
//           userItemModel.code, userItemModel.message);
//       if (msg == "" || msg == null) {
//         return;
//       }
//       LXLEasyLoading.showToast(msg);
//     }
//   }
// }
