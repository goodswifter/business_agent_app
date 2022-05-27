

import 'dart:typed_data';

import 'package:flutter/material.dart';

class PayPasswordAlertTextFieldProvider with ChangeNotifier {
  //图片验证码
  late Uint8List? _graphicBytes = null;
  //图片验证码id
  String _imageID = "";

  get graphicBytes => _graphicBytes;
  get imageID => _imageID;

  //设置支付密码参数：
  void setGraphicCodeData(Uint8List graphicBytes, String imageID) async {
    this._graphicBytes = graphicBytes;
    this._imageID = imageID;

    notifyListeners();
  }
}
