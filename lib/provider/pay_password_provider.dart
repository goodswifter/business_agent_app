import 'package:flutter/material.dart';

class PayPasswordProvider with ChangeNotifier {
 
  //身份证号
  String _idCardStr = "";
  //营业执照号
  String _businessNoStr = "";

  get idCardStr => _idCardStr;
  get businessNoStr => _businessNoStr;

  //设置支付密码参数：
  void setPayPasswordData(String idCard, String businessNo) async {
    this._idCardStr = idCard;
    this._businessNoStr = businessNo;

    notifyListeners();
  }
}
