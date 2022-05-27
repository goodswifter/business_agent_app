import 'package:flutter/material.dart';

class ReceiveCodeModel {
  String? code;
  String? message;
  String? requestId;
  Data? data;

  ReceiveCodeModel({this.code, this.message, this.requestId, this.data});

  ReceiveCodeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    requestId = json['requestId'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    data['requestId'] = requestId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? ordNo;
  String? ordType;
  String? ordOwn;
  Object? amt;
  String? qrCode;
  String? payNo;
  String? tranFlag;
  String? qrType;
  String? payTime;
  String? productName;

  Data(
      {this.ordNo,
      this.ordType,
      this.ordOwn,
      this.amt,
      this.qrCode,
      this.payNo,
      this.tranFlag,
      this.qrType,
      this.payTime,
      this.productName});

  Data.fromJson(Map<String, dynamic> json) {
    ordNo = json['ordNo'];
    ordType = json['ordType'];
    ordOwn = json['ordOwn'];

    // amt = json['amt'];

    // if (json['amt'] is int || json['amt'] is double || json['amt'] is String) {
    //   amt = double.parse(json['amt']);
    // }

    qrCode = json['qrCode'];
    payNo = json['payNo'];
    tranFlag = json['tranFlag'];
    qrType = json['qrType'];
    payTime = json['payTime'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ordNo'] = ordNo;
    data['ordType'] = ordType;
    data['ordOwn'] = ordOwn;
    data['amt'] = amt;
    data['qrCode'] = qrCode;
    data['payNo'] = payNo;
    data['tranFlag'] = tranFlag;
    data['qrType'] = qrType;
    data['payTime'] = payTime;
    data['productName'] = productName;
    return data;
  }
}
