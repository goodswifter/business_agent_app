/*
 * @Author: your name
 * @Date: 2020-10-28 13:26:36
 * @LastEditTime: 2020-11-13 14:44:28
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: /app-station-flutter/lib/utils/sh_sign_services.dart
 */
import 'dart:convert';
import 'package:crypto/crypto.dart';

class SignServices {
  static getSign(Map json) {
    
    String secret = "take2019bbdj";

    List attrKeys = json.keys.toList();
    attrKeys.sort(); //排序  ASCII 字符顺序进行升序排列
    String str = '';
    for (var i = 0; i < attrKeys.length; i++) {
      str += "${attrKeys[i]}${json[attrKeys[i]]}";
    }

    // print(">>>>>>>> ${str}");
    String tempStr = str + secret;
    var bytes = utf8.encode(tempStr);
    var digest = sha1.convert(bytes);

    String s = md5.convert(utf8.encode(digest.toString())).toString();

    // print(s.toUpperCase());
    return s.toUpperCase();

    // return md5.convert(utf8.encode(str)).toString();
  }
}
