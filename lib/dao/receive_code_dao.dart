import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import '../../../network/http_manager.dart';
import '../core/config/config.dart';

/*
 * 1、收款码接口相关
 * 
 */

class ReceiveCodeDao {
  //获取 被扫 二维码信息接口
  static Future<Map<String, dynamic>?> doGetQRCodeAppOrderCreateData(
      Map paramsMap) async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    HttpManager.instance.baseUrl = Config.baseUrl;

    ValidateResult result = await HttpManager.instance
        .request(await Api.apiGetQRCodeAppOrderCreateData(paramsMap));

    switch (result.validateType) {
      case ValidateType.validating:
        break;
      case ValidateType.success:

        /// 对数据进行处理
        try {
          resultSubject
              .add(ValidateResult(ValidateType.success, data: "处理好的数据"));
          // Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
          // var result = json.decode(utf8decoder.convert(result.data));
          if (result.data.toString().length == 0) {
            return null;
          }
          Map<String, dynamic> resultModel = result.data;
          return resultModel;
        } catch (e) {
          print(e);
        }
        break;
      case ValidateType.failed:
        resultSubject
            .add(ValidateResult(ValidateType.failed, errorMsg: "网络请求错误"));
        break;
    }
  }

  //获取订单查询 列表接口
  static Future<Map<String, dynamic>?> doGetAppOrderQueryListData(
      Map paramsMap) async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    HttpManager.instance.baseUrl = Config.baseUrl;

    ValidateResult result = await HttpManager.instance
        .request(await Api.apiGetAppOrderQueryListData(paramsMap));

    switch (result.validateType) {
      case ValidateType.validating:
        break;
      case ValidateType.success:

        /// 对数据进行处理
        try {
          resultSubject
              .add(ValidateResult(ValidateType.success, data: "处理好的数据"));
          // Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
          // var result = json.decode(utf8decoder.convert(result.data));
          if (result.data.toString().length == 0) {
            return null;
          }
          Map<String, dynamic> resultModel = result.data;
          return resultModel;
        } catch (e) {
          print(e);
        }
        break;
      case ValidateType.failed:
        resultSubject
            .add(ValidateResult(ValidateType.failed, errorMsg: "网络请求错误"));
        break;
    }
  }

  //查询订单二维码 被查询的接口
  //注：二维码被扫，下单成功后，轮询查询订单中状态
  static Future<Map<String, dynamic>?> doQueryOrderStatusData(
      Map paramsMap) async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    HttpManager.instance.baseUrl = Config.baseUrl;

    ValidateResult result = await HttpManager.instance
        .request(await Api.apiQueryOrderStatusData(paramsMap));

    switch (result.validateType) {
      case ValidateType.validating:
        break;
      case ValidateType.success:

        /// 对数据进行处理
        try {
          resultSubject
              .add(ValidateResult(ValidateType.success, data: "处理好的数据"));
          // Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
          // var result = json.decode(utf8decoder.convert(result.data));
          if (result.data.toString().length == 0) {
            return null;
          }
          Map<String, dynamic> resultModel = result.data;
          return resultModel;
        } catch (e) {
          print(e);
        }
        break;
      case ValidateType.failed:
        resultSubject
            .add(ValidateResult(ValidateType.failed, errorMsg: "网络请求错误"));
        break;
    }
  }
}
