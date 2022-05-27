import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../core/config/config.dart';
import '../network/http_manager.dart';

/// 主要包括以下接口：
/// 1、获取图片验证码接口
/// 2、验证码登录
/// 3、密码登录
/// 4、忘记密码
/// 5、发送短信
/// 6、登录过期校验，刷新refreshToken
/// 7、退出登录

class LoginDao {
  /// 1、获取图片验证码接口
  static Future<Map<String, dynamic>?> doImageVerificationData() async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    HttpManager.instance.baseUrl = Config.baseUrl;

    ValidateResult result = await HttpManager.instance
        .request(await Api.apiImageVerificationData());

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
          if (result.data.toString().isEmpty) {
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
    return null;
  }

  /// 5、发短信接口
  static Future<Map<String, dynamic>?> doSendSmsCodeData(Map paramsMap) async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));

    ValidateResult result = await HttpManager.instance
        .request(await Api.apiSendSmsCodeData(paramsMap));

    switch (result.validateType) {
      case ValidateType.validating:
        break;
      case ValidateType.success:

        /// 对数据进行处理
        try {
          resultSubject
              .add(ValidateResult(ValidateType.success, data: "处理好的数据"));
          if (result.data.toString().isEmpty) {
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
    return null;
  }

  /// 2、验证码登录接口
  static Future<Map<String, dynamic>?> doVerificationLoginData(
      Map paramsMap) async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));

    ValidateResult result = await HttpManager.instance
        .request(await Api.apiVerificationLoginData(paramsMap));

    switch (result.validateType) {
      case ValidateType.validating:
        break;
      case ValidateType.success:

        /// 对数据进行处理
        try {
          resultSubject
              .add(ValidateResult(ValidateType.success, data: "处理好的数据"));
          if (result.data.toString().isEmpty) {
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
    return null;
  }

  /// 3、密码登录接口
  static Future<Map<String, dynamic>?> doPasswordLoginData(
      Map paramsMap) async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    // HttpManager.instance.baseUrl =
    //     'https://uatfx.soopay.net/dev176/digitalRmb/';

    ValidateResult result = await HttpManager.instance
        .request(await Api.apiPasswordLoginData(paramsMap));

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
          if (result.data.toString().isEmpty) {
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
    return null;
  }

  ///4、忘记密码接口
  /// 验证忘记/修改密码短信   共用接口
  static Future<Map<String, dynamic>?> doForgetPasswordLoginData(
      Map paramsMap) async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    HttpManager.instance.baseUrl = Config.baseUrl;

    ValidateResult result = await HttpManager.instance
        .request(await Api.apiForgetPasswordData(paramsMap));

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
          if (result.data.toString().isEmpty) {
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
    return null;
  }

  /// 6、登录过期校验，刷新refreshToken
  static Future<Map<String, dynamic>?> doAuthRefreshTokenData(
      Map paramsMap) async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    // HttpManager.instance.baseUrl =
    //     'https://uatfx.soopay.net/dev176/digitalRmb/';
    HttpManager.instance.baseUrl = Config.baseUrl;

    ValidateResult result = await HttpManager.instance
        .request(await Api.apiAuthRefreshTokenData(paramsMap));

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
          if (result.data.toString().isEmpty) {
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
    return null;
  }

  //退出登录
  static Future<Map<String, dynamic>?> doUserLoginOutData() async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    HttpManager.instance.baseUrl = Config.baseUrl;

    ValidateResult result =
        await HttpManager.instance.request(await Api.apiUserLoginOutData());

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
          if (result.data.toString().isEmpty) {
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
    return null;
  }
}
