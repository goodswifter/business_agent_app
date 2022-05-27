import 'package:flustars/flustars.dart';
import 'package:umpay_crossborder_app/core/config/lxl_key_define.dart';
import 'package:umpay_crossborder_app/model/agent_data_info_model.dart';
import '../services/Storage.dart';

/*
 * 用户信息相关：
 * 保存用户信息
 * 获取用户信息
 */
class UserServices {
  // static String token = "";
  // static String refreshToken = "";

  ///获取商户信息
  static getAgentDataInfo() {
    late AgentDataInfoModel? agentDataInfoModel;
    try {
      agentDataInfoModel = SpUtil.getObj(LXLKeyDefine.agentUserDataInfoKey,
          (v) => AgentDataInfoModel.fromJson(v as Map<String, dynamic>));
    } catch (e) {
      agentDataInfoModel = AgentDataInfoModel();
    }
    return agentDataInfoModel;
  }

  ///登录成功获取手机号
  static String getAgentPhone() {
    String? mobile = SpUtil.getString(LXLKeyDefine.agentUserMobileKey);

    return mobile != null ? mobile : "";
  }

  ///////////////////////////////////////////////////////////////

  //登录成功保存token
  static String getToken() {
    //登录成功保存token、refreshToken
    String? token = SpUtil.getString("token");

    // String token = Storage.getString("token");

    return token != null ? token : "";
  }

  //登录成功保存refreshToken
  static String getRefreshToken() {
    String? refreshToken = SpUtil.getString("refreshToken");
    return refreshToken != null ? refreshToken : "";
  }

  /*
   * 获取用户信息
   */
  static getUserInfo() {
    // late UserInfoModel? uerInfoModel;
    // try {
    //   uerInfoModel = SpUtil.getObj(LXLKeyDefine.USER_INFO_ITEM_KEY,
    //       (v) => UserInfoModel.fromJson(v as Map<String, dynamic>));
    // } catch (e) {
    //   uerInfoModel = UserInfoModel(code: '', message: '');
    // }
    // return uerInfoModel;
  }

  /*
   * 获取用户登录状态
   */
  static getUserLoginState() {
    var token = UserServices.getToken();
    if (token != null && token.length > 0 && token != "") {
      return true;
    }
    return false;
  }

  static loginOut() {
    Storage.remove('userInfo');
  }
}
