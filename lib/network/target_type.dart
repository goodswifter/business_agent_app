/*
 * @Author: lixiao
 * @Date: 2020-05-17 20:48:36
 * @LastEditTime: 2020-10-28 15:40:16
 * @LastEditors: Please set LastEditors
 * @Description: 网络请求参数配置类
 * @FilePath: 
 */

import 'package:common_utils/common_utils.dart';

enum MSNetServiceMethod {
  POST,
  GET,
  PATCH,
  DELETE,
  UPLOAD,
  DOWNLOAD,
}

enum ParameterEncoding {
  /// 参数放在URL中
  URLEncoding,

  /// 参数放在body中
  BodyEncoding
}

class TargetType {
  /// 接口地址
  String? path;

  /// 请求方法
  MSNetServiceMethod? method;

  /// 参数
  Object? parameters;

  /// 参数放置位置(仅有参数时 需要传)
  ParameterEncoding? encoding;

  /// 请求头
  Map? headers;

  config(
      {required String path,
      MSNetServiceMethod method = MSNetServiceMethod.GET,
      required Object parameters,
      required ParameterEncoding encoding,
      required Map headers}) {
    this.path = path;
    this.method = method;
    Map<String, dynamic> paramsMap = parameters as Map<String, dynamic>;
    String nowDateTime =
        DateUtil.formatDate(DateTime.now(), format: DateFormats.full);
    List dateTimeList = nowDateTime.split(" ");

    String time = dateTimeList[0];
    String str1 = time.substring(0, 4);
    String str2 = time.substring(5, 7);
    String str3 = time.substring(8);
    paramsMap["reqDate"] = "$str1$str2$str3";

    paramsMap["reqTime"] = dateTimeList[1];
    this.parameters = paramsMap;
    //end by lixiao

    // this.parameters = parameters;
    this.encoding = encoding;
    this.headers = headers;
    return this;
  }
}
