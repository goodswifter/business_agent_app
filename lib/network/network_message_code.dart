

import '../services/EventBus.dart';

/// 上传接口时，传递的type配型参数
enum UserInfoType {
  loginType, //登录
  forgetType, //忘记密码，修改密码
  modifyType, //修改手机号
}

/// 请求信息配置
class RequestMessage {
  /// 根据传入不同的类型返回相应的type类型
  /// 主要用于接口请求
  static String? getUserInfoType(UserInfoType type) {
    switch (type) {
      case UserInfoType.loginType:
        return "L";
      case UserInfoType.forgetType:
        return "F";
        break;
      case UserInfoType.modifyType:
        return "U";
        break;
      default:
    }
  }
}

/// 返回响应信息配置
class ResponseMessage {
  ///惠商代理商app
  static const String SUCCESS_CODE = "0000";





  static const String SUCCESS_MESSAGE = "成功";

  static const String FAIL_CODE = "00000001";
  static const String FAIL_MESSAGE = "请求异常";

  static const String REFRESH_TOKTN_CODE = "00000007";
  static const String REFRESH_TOKTN_MESSAGE = "刷新refreshToken,获取新的token";
 
  //输入原密码错误弹框提示
  static const String PAYPASSWORD_ALERT_DIALOG_CODE = "00030002";


  /// 根据response响应返回的code --> toast提示用户响应的信息
  static String getResponseMessageCode(String code, String message) {
    switch (code) {
      case SUCCESS_CODE:
        return SUCCESS_MESSAGE;
        break;
      case REFRESH_TOKTN_CODE: //刷新refreshToken
        //eventBus通知跳转到登录
        eventBus.fire(RequestDataToLoginPageEvent(REFRESH_TOKTN_CODE));
        return "";
        break;
      // case FAIL_CODE:
      //   return FAIL_MESSAGE;
      //   break;
      default:
        return message;
        break;
    }
  }
}
