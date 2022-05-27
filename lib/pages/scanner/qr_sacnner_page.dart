/*
 * @Author: lixiao
 * @Date: 
 * @LastEditTime: 
 * @LastEditors: 
 * @Description: 扫一扫页面
 * @FilePath: 
 */

import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan/scan.dart';
import 'package:umpay_crossborder_app/pages/scanner/sh_transaction_successful_page.dart';
import '../../../dao/qr_sacanner_dao.dart';
import '../../../network/network_message_code.dart';
import '../../pages/scanner/qr_scanner_page_config.dart';
import '../../utils/lxl_easy_loading.dart';
import '../../utils/lxl_screen.dart';
import '../../utils/navigator_util.dart';
import '../../widget/base_navi_appbar_widget.dart';

class QRScannerPage extends StatefulWidget {
  final QRScannerPageConfig? config;

  //传入设置金额
  String? accountBalance;

  QRScannerPage({Key? key, this.config, this.accountBalance}) : super(key: key);

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String _platformVersion = 'Unknown';

  ScanController controller = ScanController();
  String qrcode = 'Unknown';
  late StateSetter stateSetter;

  IconData lightIcon = Icons.flash_on;
  List<String> result = [];

  final ImagePicker _picker = ImagePicker();
  //设置金额
  late String accountBalance;

  @override
  void initState() {
    super.initState();

    if (widget.accountBalance != null) {
      accountBalance = widget.accountBalance!;
    } else {
      accountBalance = "0";
    }

    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: BaseViewBar(
      //   childView: BaseTitleBar(
      //     "收款",
      //     leftClick: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   preferredSize: Size.fromHeight(50.0),
      // ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff333333),
        leading: IconButton(
          icon: Image.asset(
            "images/navi_back_images.png",
            fit: BoxFit.cover,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "收款",
          style: TextStyle(
            color: Color(0xffffffff),
            fontSize: 18.0,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        ScanView(
          controller: controller,
          // scanAreaScale: 1.0, //.7,
          scanAreaScale: .7,
          scanLineColor: Colors.white,
          // scanLineColor: Colors.green.shade400,
          //  scanAreaScale: widget.config.scanAreaSize,
          // scanLineColor: widget.config.scanLineColor,
          onCapture: (String data) async {
            // await showResult(content: '扫码结果: \t$data');

            LogUtil.e("data ---> ${data}");

            _scannerCodeSuccessAfterAndJumpTradeTypePage(data);
          },
        ),
        Positioned(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            alignment: Alignment.topCenter,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text(
                    "总金额",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  child: Text(
                    "${this.accountBalance}元",
                    style: const TextStyle(
                      fontSize: 27,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          left: LXLScreen.width / 2.0 - 50,
          bottom: 130,
          child: Container(
            // color: Colors.red,
            alignment: Alignment.center,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                stateSetter = setState;
                return MaterialButton(
                    child: Icon(
                      lightIcon,
                      size: 30,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      controller.toggleTorchMode();
                      if (lightIcon == Icons.flash_on) {
                        lightIcon = Icons.flash_off;
                      } else {
                        lightIcon = Icons.flash_on;
                      }
                      stateSetter(() {});
                    });
              },
            ),
          ),
        ),

        //可以识别图片
        // Positioned(
        //   right: 50,
        //   bottom: 100,
        //   child: MaterialButton(
        //       child: Icon(
        //         Icons.image,
        //         size: 30,
        //         color: Color.fromRGBO(4, 184, 67, 1),
        //       ),
        //       onPressed: () async {
        //         await pickImage();
        //         // DialogUtil.showCommonDialog(context, '$result');
        //       }),
        // ),

        Positioned(
          bottom: 100,
          child: Container(
            width: LXLScreen.width,
            // color: Colors.red,
            alignment: Alignment.center,
            height: 36,
            child: const Text(
              "请顾客出示微信、支付宝、云闪付、数字人民币付款码",
              style: TextStyle(fontSize: 14, color: Color(0xffffffff)),
            ),
          ),
        ),

        Positioned(
          bottom: 50,
          child: Container(
            width: LXLScreen.width,
            // color: Colors.red,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                      "images/sh_scanner_code_prompt_image_1.png",
                      fit: BoxFit.cover),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: const Text(
                    "收款二维码",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<Object?> showResult({required String content}) async {
    return showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Container();
        },
        barrierColor: Colors.black.withOpacity(.6),
        barrierDismissible: true,
        barrierLabel: "",
        transitionDuration: const Duration(milliseconds: 150),
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.scale(
              scale: anim1.value,
              child: Opacity(
                  opacity: anim1.value,
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Material(
                          type: MaterialType.transparency,
                          child: Container(
                              height: 450,
                              width: 300,
                              decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ))),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        content,
                                        style:
                                            const TextStyle(height: 1, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  DividerHorizontal(),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '确认',
                                              style: TextStyle(
                                                  color: Color(0xFFFF7B85),
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ))
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        )),
                  )));
        });
  }

  Future pickImage() async {
    if (Platform.isAndroid) {
      if (await Permission.camera.request().isGranted) {
      } else {
        LXLEasyLoading.showToast("请打开照相机权限");
        return;
      }
    } else {}

    // final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    // var image =
    //     await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 400);

    if (image == null) {
      return;
    }

    if (image.path != null) {
      String? value = await Scan.parse(image.path);

      // result.clear();
      // result.add(value);
      // showResult(content: result.toString());

      // controller.pause();
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             ScannerCodeAfterPage(codeMessage: value!))).then((value) {
      //   controller.resume();
      // });
    }

    // setState(() {
    //   if (image != null) {
    //     // _image = image;
    //   } else {
    //     print('No image selected.');
    //   }
    // });
  }

  /// 扫码成功后,跳转交易是否成功界面
  /// 交易处理中   交易成功  交易失败

  _scannerCodeSuccessAfterAndJumpTradeTypePage(String codeData) {
    //支付状态： 0 - 支付中  1-支付成功  2-支付失败
    int payType = 1;
    TradeType tradeType = TradeType.waiting;

    switch (payType) {
      case 0:
        tradeType = TradeType.waiting;
        break;
      case 1:
        tradeType = TradeType.success;
        break;
      case 2:
        tradeType = TradeType.failed;
        break;
      default:
    }

    ///微信支付类型：10,11,12,13,14，15开头
    ///支付宝支付类型：25,26,27,28,29，30开头
    ///银联二维码支付：其他

    //跳转商户交易成功界面
    // NavigatorUtil.push(context, SHTransactionSuccessfulPage());
    controller.pause();
    //跳转扫码后付款界面
    // NavigatorUtil.push(context, ScannerCodeAfterPage(codeMessage: data));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SHTransactionSuccessfulPage(
                  codeMessage: codeData,
                  tradeType: tradeType,
                  accountBalance: this.accountBalance,
                ))).then((value) {
      controller.resume();
    });
  }
}
