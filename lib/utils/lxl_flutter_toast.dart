/*
 * @Author: your name
 * @Date: 2020-11-17 09:49:21
 * @LastEditTime: 2020-11-24 09:57:32
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /app-station-flutter/lib/utils/SHFlutterToast.dart
 */



import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LXLFlutterToast {

  late String message;

  static setToast(message) {
    Fluttertoast.showToast(
      msg: '${message}',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  static showCheckNullValueToast(String tipStr) {
    Fluttertoast.showToast(
        msg: tipStr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xff999999),
        textColor: Colors.white,
        fontSize: 16.0);
  }
  
}
      //   msg: "提示信息",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIos: 1,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      //   fontSize: 16.0