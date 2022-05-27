import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umpay_crossborder_app/pages/provider/pay_password_alert_textfield_provider.dart';
import '../../dao/login_dao.dart';
import '../../model/graphic_verification_model.dart';
import '../../utils/lxl_easy_loading.dart';
import '../pages/provider/provider_manager.dart';

/*
 * 自定义 alert dialog
 */

typedef AlertConfirmCallBack = void Function(
    int value, String imageID, String verificationCode);
typedef CallBack = void Function(Uint8List bytes, String imageID);

class LXLAlertCustomTextFieldDialog {
  //图片验证码
  static Uint8List? bytes;
  //图片验证码id
  static String? imageID = "";

  /// 获取图形验证码数据
  static getRequestImageVerificationData(CallBack callback) async {
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
    var bytes = const Base64Decoder().convert(base64);

    // setState(() {
    //   // this.imageBase64Str = graphicVerificationModel.data.img;
    //   this._bytes = bytes;
    //   this._imageID = graphicVerificationModel.data.imgId;
    // });

    // //provider更新数据
    // Provider.of<PayPasswordAlertTextFieldProvider>(context, listen: false)
    //     .setGraphicCodeData(bytes, graphicVerificationModel.data.imgId);

    callback(bytes, graphicVerificationModel.data!.imgId!);
  }

  static showAlertDialog(context, Uint8List bytes, String imageID,
      AlertConfirmCallBack confirmCallBack) {
    //图形验证码
    final _graphicVerificationController = TextEditingController();

    late PayPasswordAlertTextFieldProvider _snapshot;

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
          fontSize: 14.0,
          color: Color(0xff333333),
        ), //输入文本的样式
        // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],//允许的输入格式
        keyboardType: textInputType,
        decoration: InputDecoration(
          // fillColor:
          //     Color(0xffEBEDF1), //Color(0xfff8f8f8), //Colors.blue.shade100,
          // filled: true,
          // labelText: "",

          hintText: hintText,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
        ),
        // enableInteractiveSelection: true,
        onChanged: (text) {
          //内容改变的回调
          print('change $text');
        },
        onSubmitted: (text) {
          //内容提交(按回车)的回调
          print('submit $text');
        },
        enabled: enabled, //true, //是否禁用
      );
    }

    /// 图形验证码 widget
    _graphicVerificationCode() {
      return InkWell(
        onTap: () {
          //点击获取图形验证码
          getRequestImageVerificationData((bytes, imageID) {
            // //provider更新数据
            Provider.of<PayPasswordAlertTextFieldProvider>(context,
                    listen: false)
                .setGraphicCodeData(bytes, imageID);
          });
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      // color: Colors.red,
                      padding: const EdgeInsets.only(right: 10),
                      child: buildTextField(_graphicVerificationController,
                          "请输入图形验证码", true, false, TextInputType.number),
                    ),
                  ),
                  //图形验证码
                  Container(
                    width: 80, //120,
                    height: 28, //40,
                    color: Colors.red,
                    child: _snapshot.graphicBytes != null
                        ? (Image.memory(_snapshot.graphicBytes,
                            fit: BoxFit.cover))
                        : Container(),

                    // child: Image.network(
                    //     "http://jd.itying.com/public/upload/UObZahqPYzFvx_C9CQjU8KiX.png",
                    //     fit: BoxFit.cover),
                  ),
                ],
              ),
            ),

            // Container(
            //   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            //   color: Color(0xffE2E4EA),
            //   height: 1,
            // ),
          ],
        ),
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProviderManager.connect<PayPasswordAlertTextFieldProvider>(
            builder: (context, PayPasswordAlertTextFieldProvider snapshot,
                Widget child) {
          _snapshot = snapshot;

          return Container(
            color: const Color.fromRGBO(0, 0, 0, 0.3), //Colors.black12,
            child: GestureDetector(
              //解决showModalBottomSheet点击消失的问题
              behavior: HitTestBehavior.translucent,
              onTap: () {
                print("123");
                // Navigator.of(context).pop();
                // FocusScope.of(context).requestFocus(FocusNode());
                return;
              },
              child: SimpleDialog(
                contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                title: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    // '${title}',
                    "输入图形验证码",
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 18,
                    ),
                  ),
                ),
                children: [
                  // SizedBox(height: 10),
                  Container(
                    child: _graphicVerificationCode(),
                  ),

                  const SizedBox(height: 10),
                  Container(
                    color: const Color(0xffeeeeee),
                    height: 1,
                  ),
                  const SizedBox(height: 5),
                  SimpleDialogOption(
                    // padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 50,
                          child: SimpleDialogOption(
                            child: const Center(
                              child: Text(
                                '取消',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(
                                      0xff333333), // Color(0xff00be7e), //19ba6c
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            onPressed: () {
                              //回调事件
                              confirmCallBack(0, "", "");
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
                          color: const Color(0xffeeeeee),
                          width: 1,
                          height: 50,
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 120,
                          height: 50,
                          child: SimpleDialogOption(
                            child: const Center(
                              child: Text(
                                '确定',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xffFF5B5D),
                                  // color: Colors.blue[500],
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            onPressed: () {
                              print("----alert  确定点击了-------");

                              if (_graphicVerificationController.text ==
                                      null ||
                                  _graphicVerificationController.text == "" ||
                                  _graphicVerificationController
                                          .text.length ==
                                      0) {
                                LXLEasyLoading.showToast("请输入图形验证码");
                                return;
                              }

                              //回调事件
                              confirmCallBack(1, _snapshot.imageID,
                                  _graphicVerificationController.text);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 10),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
