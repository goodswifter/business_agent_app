import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:rxdart/rxdart.dart';

import '../../../model/user_info_model.dart';
import '../../../network/network_message_code.dart';
import '../../../utils/lxl_easy_loading.dart';
import '../core/config/config.dart';
import '../network/http_manager.dart';

typedef CallBack = Function(Object obj);

/*
   获取用户相关接口
   1、获取用户信息接口
   2、验证修改手机号短信 -绑定手机号
   3、修改用户头像接口、上传图片的接口
   4、实名认证接口
 */
class UserInfoDao {
  /// 统一封装为了便于在项目中使用
  /// *** 获取用户信息 ***
  static requestGetUserInfoData(CallBack callback) async {
    var response = await doGetUserInfoData();
    LogUtil.e("response = $response");
    if (response == null) return;
    UserInfoModel userItemModel = UserInfoModel.fromJson(response);

    if (userItemModel.code == ResponseMessage.SUCCESS_CODE) {
      //保存用户信息
      // SpUtil.putObject(LXLKeyDefine.USER_INFO_ITEM_KEY, userItemModel);
      callback(userItemModel);
    } else {
      // LXLEasyLoading.showToast(ResponseMessage.getResponseMessageCode(
      //     userItemModel.code, userItemModel.message));

      String msg = ResponseMessage.getResponseMessageCode(
          userItemModel.code, userItemModel.message);
      if (msg == "") return;

      LXLEasyLoading.showToast(msg);
    }
  }

  /// 1、获取用户信息接口
  static Future<Map<String, dynamic>?> doGetUserInfoData() async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    HttpManager.instance.baseUrl = Config.baseUrl;

    ValidateResult result =
        await HttpManager.instance.request(await Api.apiGetUserInfoData());

    switch (result.validateType) {
      case ValidateType.validating:
        break;
      case ValidateType.success:
        // 对数据进行处理
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

  ///2、验证修改手机号短信 -绑定手机号
  static Future<Map<String, dynamic>?> doBindPhoneData(Map paramsMap) async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    HttpManager.instance.baseUrl = Config.baseUrl;

    ValidateResult result = await HttpManager.instance
        .request(await Api.apiBindPhoneData(paramsMap));

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

  ///3、修改用户头像接口、上传图片的接口
  static Future<Map<String, dynamic>?> doUploadToUserImageData(
      Map paramsMap) async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    HttpManager.instance.baseUrl = Config.baseUrl;

    ValidateResult result = await HttpManager.instance
        .request(await Api.apiSetPayPasswordData(paramsMap));

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

  /// 4、实名认证接口  B2B  企业
  static Future<Map<String, dynamic>?> apiRealNameAuthencationToBData(
      Map paramsMap) async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    HttpManager.instance.baseUrl = Config.baseUrl;

    ValidateResult result = await HttpManager.instance
        .request(await Api.apiRealNameAuthencationToBData(paramsMap));

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

  ///4、实名认证接口  B2C  个人
  static Future<Map<String, dynamic>?> apiRealNameAuthencationToCData(
      Map paramsMap) async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    HttpManager.instance.baseUrl = Config.baseUrl;

    ValidateResult result = await HttpManager.instance
        .request(await Api.apiRealNameAuthencationToCData(paramsMap));

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
