/*
 * @Author: lixiao
 * @Date: 2020-05-17 20:48:36
 * @LastEditTime: 2020-12-21 13:21:46
 * @LastEditors: Please set LastEditors
 * @Description: 网络接口API，方法名为实际请求接口作用
 * @FilePath: /lib/HttpManager/Api.dart
 */

import 'dart:io';

import 'package:flustars/flustars.dart';

import '../core/config/config.dart';
import '../services/UserServices.dart';
import '../utils/package_info_utils.dart';
import 'http_manager.dart';
import 'target_type.dart';

class Api {
  static Map apiGetHeader() {
    String token = UserServices.getToken();
    if (token == "" || token.isEmpty) {
      token = "";
    }

    PackageInfoUtil.initPackageInfo();
    // String? uuid = SpUtil.getString("uuid");
    // String appName = SpUtil.getString("appName");
    // String packageName = SpUtil.getString("packageName");
    String? version = SpUtil.getString("version");
    String? buildNumber = SpUtil.getString("buildNumber");

    var userAgentParamMap = {
      // 'appName': utf8.encode(appName),
      // 'packageName': packageName,
      'appVersion': version,
      'appBuildNumber': buildNumber,
      'appDevelopTool': 'flutter'
    };
    if (Platform.isIOS) {
      // ios相关代码
      userAgentParamMap["platform"] = 'iOS ' + Platform.version;
    } else if (Platform.isAndroid) {
      // android相关代码
      userAgentParamMap["platform"] = 'Android ' + Platform.version;
    }

    var requestParamsMap = {
      "accept": "application/json",
      'content-type': 'application/json',
      // 'content-type': 'image/jpeg',
      // "content-type": "application/x-www-form-urlencoded",
      // "Authorization": token,
      // "uuid": uuid,
      "User-Agent": userAgentParamMap.toString(),
    };

    return requestParamsMap;
  }

  // 获取图形验证码数据
  ///新惠商项目
  static apiImageVerificationData() async {
    Map<String, dynamic> requestParamsMap = {};

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    Map headerMap = apiGetHeader();
    // headerMap["content-type"] = "image/jpeg";

    return TargetType().config(
        path: "${Config.baseUrl}agent/validate",
        headers: headerMap,
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  // 发送短信数据
  static apiSendSmsCodeData(Map paramsMap) async {
    Map<String, dynamic> requestParamsMap = {
      "telNumber": paramsMap['telNumber'],
      "imageCode": paramsMap['imageCode'],
      "userImageCode": paramsMap['userImageCode'],
    };

    return TargetType().config(
        path: "${Config.baseUrl}agent/agent/phonecode",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  // 验证码登录
  static apiVerificationLoginData(Map paramsMap) async {
    Map<String, dynamic> requestParamsMap = {
      "telNumber": paramsMap['telNumber'],
      "phoneCode": paramsMap['phoneCode'],
    };

    return TargetType().config(
        path: "${Config.baseUrl}agent/agent/login",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  ///
  // 商户入驻信息接口 - 基本信息接口
  static apiAgentMerchantEnterBasicData(Map paramsMap) async {
    // 请求路径
    String requestPath = "agent/merchant/enter";

    // 商户基本信息选项
    Map<String, dynamic> subInfoParamsMap = {
      "merchantName": paramsMap['merchantName'],
      "merchantShortName": paramsMap['merchantShortName'],
      "servicePhone": paramsMap['servicePhone'],
      "mcc": paramsMap['mcc'],
      "microBizType": paramsMap['microBizType'],
      "email": paramsMap['email'],
      "contactName": paramsMap['contactName'],
      "contactIdCardNum": paramsMap['contactIdCardNum'],
      "contactMobile": paramsMap['contactMobile'],
    };

    Map<String, dynamic> requestParamsMap = {
      "funCode": requestPath,
      "agentId": paramsMap['agentId'],
      "applicationId":
          paramsMap['applicationId'], //若type=2-提交商户资料，application_id必填
      "type": paramsMap['type'], //类型：1-保存商户资料；2-提交商户资料
      "merchantType": paramsMap['merchantType'], //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType":
          paramsMap['merchantChildType'], //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "merchantBasicInfo": subInfoParamsMap,
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}${requestPath}",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //商户入驻信息接口 - 店铺信息接口
  static apiAgentShopInfoData(Map paramsMap) async {
    //请求路径
    String requestPath = "agent/merchant/enter";

    //商户基本信息选项
    Map<String, dynamic> subInfoParamsMap = {
      "storeFrontImg": paramsMap['storeFrontImg'],
      "checkStandPic": paramsMap['checkStandPic'],
      "indoorPic": paramsMap['indoorPic'],
      "businessStartTime": paramsMap['businessStartTime'],
      "businessFinishTime": paramsMap['businessFinishTime'],
      "provinceCode": paramsMap['emprovinceCodeail'],
      "cityCode": paramsMap['cityCode'],
      "distinctCode": paramsMap['distinctCode'],
      "businessAddress": paramsMap['businessAddress'],
    };

    Map<String, dynamic> requestParamsMap = {
      "funCode": requestPath,
      "agentId": paramsMap['agentId'],
      "applicationId":
          paramsMap['applicationId'], //若type=2-提交商户资料，application_id必填
      "type": paramsMap['type'], //类型：1-保存商户资料；2-提交商户资料
      "merchantType": paramsMap['merchantType'], //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType":
          paramsMap['merchantChildType'], //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "shopInfo": subInfoParamsMap,
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}${requestPath}",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //商户入驻信息接口 - 营业执照信息接口
  static apiAgentBusinessLicenseInfoData(Map paramsMap) async {
    //请求路径
    String requestPath = "agent/merchant/enter";

    //商户基本信息选项
    Map<String, dynamic> subInfoParamsMap = {
      "licenseType": paramsMap['licenseType'],
      "businessLicenseImg": paramsMap['businessLicenseImg'],
      "businessLicense": paramsMap['businessLicense'],
      "licenseName": paramsMap['licenseName'],
      "registerProvinceCode": paramsMap['registerProvinceCode'],
      "registerCityCode": paramsMap['registerCityCode'],
      "registerDistinctCode": paramsMap['registerDistinctCode'],
      "registerAddress": paramsMap['registerAddress'],
      "businessExpiry": paramsMap['businessExpiry'],
      "regCapitalCurrency": paramsMap['regCapitalCurrency'],
      "regCapital": paramsMap['regCapital'],
      "companyProveCopy": paramsMap['companyProveCopy'],
    };

    Map<String, dynamic> requestParamsMap = {
      "funCode": requestPath,
      "agentId": paramsMap['agentId'],
      "applicationId":
          paramsMap['applicationId'], //若type=2-提交商户资料，application_id必填
      "type": paramsMap['type'], //类型：1-保存商户资料；2-提交商户资料
      "merchantType": paramsMap['merchantType'], //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType":
          paramsMap['merchantChildType'], //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "businessLicenseInfo": subInfoParamsMap,
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}${requestPath}",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //商户入驻信息接口 - 法人信息接口
  static apiAgentLegalPersionInfoData(Map paramsMap) async {
    //请求路径
    String requestPath = "agent/merchant/enter";

    //商户基本信息选项
    Map<String, dynamic> subInfoParamsMap = {
      "legalCardType": paramsMap['legalCardType'],
      "legalIdCardHeadsPic": paramsMap['legalIdCardHeadsPic'],
      "legalIdCardTailsPic": paramsMap['legalIdCardTailsPic'],
      "legalName": paramsMap['legalName'],
      "legalIdCardNum": paramsMap['legalIdCardNum'],
      "legalIdCardExpiry": paramsMap['legalIdCardExpiry'],
      "legalMobile": paramsMap['legalMobile'],
      "controllerCardType": paramsMap['controllerCardType'],
      "controllerIdCardHeadsPic": paramsMap['controllerIdCardHeadsPic'],
      "controllerIdCardTailsPic": paramsMap['controllerIdCardTailsPic'],
      "controllerName": paramsMap['controllerName'],
      "controllerIdCardNum": paramsMap['controllerIdCardNum'],
      "controllerIdCardExpiry": paramsMap['controllerIdCardExpiry'],
      "controllerMobile": paramsMap['controllerMobile'],
      "lawyerCardType": paramsMap['lawyerCardType'],
      "lawyerIdCardHeadsPic": paramsMap['lawyerIdCardHeadsPic'],
      "lawyerIdCardTailsPic": paramsMap['lawyerIdCardTailsPic'],
      "lawyerName": paramsMap['lawyerName'],
      "lawyerIdCardNum": paramsMap['lawyerIdCardNum'],
      "lawyerIdCardExpiry": paramsMap['lawyerIdCardExpiry'],
      "lawyerMobile": paramsMap['lawyerMobile'],
    };

    Map<String, dynamic> requestParamsMap = {
      "funCode": requestPath,
      "agentId": paramsMap['agentId'],
      "applicationId":
          paramsMap['applicationId'], //若type=2-提交商户资料，application_id必填
      "type": paramsMap['type'], //类型：1-保存商户资料；2-提交商户资料
      "merchantType": paramsMap['merchantType'], //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType":
          paramsMap['merchantChildType'], //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "legalPersonInfo": subInfoParamsMap,
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}${requestPath}",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //商户入驻信息接口 - 结算信息接口
  static apiAgentBillingInfoData(Map paramsMap) async {
    //请求路径
    String requestPath = "agent/merchant/enter";

    //商户基本信息选项
    Map<String, dynamic> subInfoParamsMap = {
      "accountType": paramsMap['accountType'],
      "cardType": paramsMap['cardType'],
      "settleCardType": paramsMap['settleCardType'],
      "settleIdCardHeadsPic": paramsMap['settleIdCardHeadsPic'],
      "settleIdCardTailsPic": paramsMap['settleIdCardTailsPic'],
      "settleName": paramsMap['settleName'],
      "settleIdCardNum": paramsMap['settleIdCardNum'],
      "settleIdCardExpiry": paramsMap['settleIdCardExpiry'],
      "bankCardPic": paramsMap['bankCardPic'],
      "authorCertificatePic": paramsMap['authorCertificatePic'],
      "bankNo": paramsMap['bankNo'],
      "openBank": paramsMap['openBank'],
      "openBankCity": paramsMap['openBankCity'],
      "bankAccountOpeningCertificate":
          paramsMap['bankAccountOpeningCertificate'],
      "bankBrhName": paramsMap['bankBrhName'],
    };

    Map<String, dynamic> requestParamsMap = {
      "funCode": requestPath,
      "agentId": paramsMap['agentId'],
      "applicationId":
          paramsMap['applicationId'], //若type=2-提交商户资料，application_id必填
      "type": paramsMap['type'], //类型：1-保存商户资料；2-提交商户资料
      "merchantType": paramsMap['merchantType'], //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType":
          paramsMap['merchantChildType'], //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "settleInfo": subInfoParamsMap,
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}${requestPath}",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //商户入驻信息接口 - 编辑费率信息接口
  static apiAgentEditRateInfoData(Map paramsMap) async {
    //请求路径
    String requestPath = "agent/merchant/enter";

    //商户基本信息选项
    Map<String, dynamic> subInfoParamsMap = {
      "aliMerchantRate": paramsMap['aliMerchantRate'],
      "wxMerchantRate": paramsMap['wxMerchantRate'],
      "unionCreditRate": paramsMap['unionCreditRate'],
      "unionDebitRate": paramsMap['unionDebitRate'],
      "unionUpCreditRate": paramsMap['unionUpCreditRate'],
      "unionUpDebitRate": paramsMap['unionUpDebitRate'],
      "unionUpDebitLimit": paramsMap['unionUpDebitLimit'],
      "pos1CreditRate": paramsMap['pos1CreditRate'],
      "pos1DebitRate": paramsMap['pos1DebitRate'],
      "pos1DebitLimit": paramsMap['pos1DebitLimit'],
      "pos2CreditRate": paramsMap['pos2CreditRate'],
      "pos2DebitRate": paramsMap['pos2DebitRate'],
      "merchantPosLimit": paramsMap['merchantPosLimit'],
      "pos3CreditRate": paramsMap['pos3CreditRate'],
      "pos3DebitRate": paramsMap['pos3DebitRate'],
      "pos3DebitLimit": paramsMap['pos3DebitLimit'],
      "pos4CreditRate": paramsMap['pos4CreditRate'],
      "pos4DebitRate": paramsMap['pos4DebitRate'],
      "pos4DebitLimit": paramsMap['pos4DebitLimit'],
    };

    Map<String, dynamic> requestParamsMap = {
      "funCode": requestPath,
      "agentId": paramsMap['agentId'],
      "applicationId":
          paramsMap['applicationId'], //若type=2-提交商户资料，application_id必填
      "type": paramsMap['type'], //类型：1-保存商户资料；2-提交商户资料
      "merchantType": paramsMap['merchantType'], //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType":
          paramsMap['merchantChildType'], //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "rateInfo": subInfoParamsMap,
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}${requestPath}",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }


//商户入驻信息接口 - 其他信息接口
  static apiAgentOtherInfoData(Map paramsMap) async {
    //请求路径
    String requestPath = "agent/merchant/enter";

    //商户基本信息选项
    Map<String, dynamic> subInfoParamsMap = {
      "industryQualificationImg": paramsMap['industryQualificationImg'],
      "operationCopyImg": paramsMap['operationCopyImg'],
      "elseImg1": paramsMap['elseImg1'],
      "elseImg2": paramsMap['elseImg2'],
      "elseImg3": paramsMap['elseImg3'],     
    };

    Map<String, dynamic> requestParamsMap = {
      "funCode": requestPath,
      "agentId": paramsMap['agentId'],
      "applicationId":
          paramsMap['applicationId'], //若type=2-提交商户资料，application_id必填
      "type": paramsMap['type'], //类型：1-保存商户资料；2-提交商户资料
      "merchantType": paramsMap['merchantType'], //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType":
          paramsMap['merchantChildType'], //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "elseInfo": subInfoParamsMap,
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}${requestPath}",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }





//商户入驻信息接口 - submit 提交信息接口
  static apiAgentSubmitInfoData(Map paramsMap) async {
    //请求路径
    String requestPath = "agent/merchant/enter";

    //商户基本信息选项
    Map<String, dynamic> subInfoParamsMap = {
      // "industryQualificationImg": paramsMap['industryQualificationImg'],
      // "operationCopyImg": paramsMap['operationCopyImg'],
      // "elseImg1": paramsMap['elseImg1'],
      // "elseImg2": paramsMap['elseImg2'],
      // "elseImg3": paramsMap['elseImg3'],     
    };

    Map<String, dynamic> requestParamsMap = {
      "funCode": requestPath,
      "agentId": paramsMap['agentId'],
      "applicationId":
          paramsMap['applicationId'], //若type=2-提交商户资料，application_id必填
      "type": paramsMap['type'], //类型：1-保存商户资料；2-提交商户资料
      "merchantType": paramsMap['merchantType'], //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType":
          paramsMap['merchantChildType'], //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "elseInfo": subInfoParamsMap,
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}${requestPath}",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }








  ////////////////********以上为代理商app请求接口*******//////////////

  //密码登录
  static apiPasswordLoginData(Map paramsMap) async {
    Map<String, dynamic> requestParamsMap = {
      "phone": paramsMap['phone'],
      "password": paramsMap['password'],
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}auth/oauth/token",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //忘记密码登录 、 验证忘记/修改密码短信
  static apiForgetPasswordData(Map paramsMap) async {
    Map<String, dynamic> requestParamsMap = {
      "oldPwd": paramsMap['oldPwd'],
      "pwd": paramsMap['pwd'],
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}user/sms/forget",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //验证修改手机号短信
  static apiBindPhoneData(Map paramsMap) async {
    Map<String, dynamic> requestParamsMap = {
      "smsCode": paramsMap['smsCode'],
      "newPhone": paramsMap['newPhone'],
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}user/sms/bingPhone",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //获取用户信息参数
  static apiGetUserInfoData() async {
    Map<String, dynamic> requestParamsMap = {
      // "token": paramsMap['token'],
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}user/user/info",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.GET,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //刷新refreshToken
  static apiAuthRefreshTokenData(Map paramsMap) async {
    Map<String, dynamic> requestParamsMap = {
      "refreshToken": paramsMap['refreshToken'],
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}auth/oauth/refreshToken",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //退出登录信息
  static apiUserLoginOutData() async {
    Map<String, dynamic> requestParamsMap = {
      // "token": paramsMap['token'],
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}user/user/loginOut",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.GET,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //设置支付密码、更新头像
  static apiSetPayPasswordData(Map paramsMap) async {
    String oldPayPwd = paramsMap['oldPayPwd'];
    String payPwd = paramsMap['payPwd'];
    String avatar = paramsMap['avatar'];

    List userExtsList = paramsMap['userExts'];
    Map<String, dynamic> requestParamsMap;

    if (userExtsList != null && userExtsList.isNotEmpty) {
      requestParamsMap = {
        "payPwd": paramsMap['payPwd'],
        "avatar": paramsMap['avatar'],
        "userExts": paramsMap['userExts'],
      };
    } else {
      requestParamsMap = {
        "oldPayPwd": oldPayPwd != null && oldPayPwd.isNotEmpty ? oldPayPwd : "",
        "payPwd": payPwd != null && payPwd.isNotEmpty ? payPwd : "",
        "avatar": avatar != null && avatar.isNotEmpty ? avatar : "",
      };
    }

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}user/user/update_basic",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //修改支付密码   忘记支付密码
  static apiModifyPayPasswordData(Map paramsMap) async {
    String oldPayPwd = paramsMap['oldPayPwd'];
    String payPwd = paramsMap['payPwd'];
    String avatar = paramsMap['avatar'];

    List userExtsList = paramsMap['userExts'];
    Map<String, dynamic> requestParamsMap;

    if (userExtsList != null && userExtsList.isNotEmpty) {
      requestParamsMap = {
        "payPwd": paramsMap['payPwd'],
        "avatar": paramsMap['avatar'],
        "userExts": paramsMap['userExts'],
      };
    } else {
      requestParamsMap = {
        "oldPayPwd": oldPayPwd != null && oldPayPwd.isNotEmpty ? oldPayPwd : "",
        "payPwd": payPwd != null && payPwd.isNotEmpty ? payPwd : "",
        "avatar": avatar != null && avatar.isNotEmpty ? avatar : "",
      };
    }

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}user/user/update_pay_pwd",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //实名认证的接口参数  B2B实名认证
  static apiRealNameAuthencationToBData(Map paramsMap) async {
    Map<String, dynamic> requestParamsMap = {
      "userExts": paramsMap['userExts'],
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}user/user/verifyUserInfo/B",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //实名认证的接口参数  B2C实名认证
  static apiRealNameAuthencationToCData(Map paramsMap) async {
    Map<String, dynamic> requestParamsMap = {
      "userExts": paramsMap['userExts'],
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}user/user/verifyUserInfo/C",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //获取 主扫 - app/order/create
  static apiAppOrderCreateData(Map paramsMap) async {
    Map<String, dynamic> requestParamsMap = {
      "amt": paramsMap['amt'],
      "ordType": paramsMap['ordType'],
      "qrCode": paramsMap['qrCode'],
      "productName": paramsMap['productName'],
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}app/order/create",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //获取 被扫 二维码  - app/order/create
  static apiGetQRCodeAppOrderCreateData(Map paramsMap) async {
    Map<String, dynamic> requestParamsMap = {
      "amt": paramsMap['amt'],
      "ordType": paramsMap['ordType'],
      "productName": paramsMap['productName'],
      "qrType": paramsMap['qrType'],
      "ordOwn": paramsMap['ordOwn'],
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path: "${Config.baseUrl}app/order/create",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //获取订单查询列表api
  static apiGetAppOrderQueryListData(Map paramsMap) async {
    Map<String, dynamic> requestParamsMap = {
      // "page": paramsMap['page'],
      // "pageSize": paramsMap['pageSize'],
    };

    // var sign = SignServices.getSign(requestParamsMap);
    // print(sign);
    // requestParamsMap["signature"] = sign;
    // print(requestParamsMap);

    return TargetType().config(
        path:
            "${Config.baseUrl}app/order/queryList?page=${paramsMap['page']}&pageSize=${paramsMap['pageSize']}",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.GET,
        encoding: ParameterEncoding.BodyEncoding);
  }

  //获取订单查询列表api
  static apiQueryOrderStatusData(Map paramsMap) async {
    Map<String, dynamic> requestParamsMap = {
      // "orderNo": paramsMap['orderNo'],
    };

    String orderNo = paramsMap['orderNo'];

    return TargetType().config(
        path: "${Config.baseUrl}app/order/queryOne/${orderNo}",
        headers: apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.GET,
        encoding: ParameterEncoding.BodyEncoding);
  }
}

final HttpManager httpManager = HttpManager.instance;
