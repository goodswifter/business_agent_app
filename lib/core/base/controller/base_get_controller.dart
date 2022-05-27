///
/// Author       : zhongaidong
/// Date         : 2022-05-27 13:00:18
/// Description  :
///
///
/// Author       : zhongaidong
/// Date         : 2022-04-22 22:07:52
/// Description  : 基类Getx控制器
///
// import 'package:business_agent/core/http/repository/complex_request.dart';
// import 'package:business_agent/core/http/repository/login_request.dart';
// import 'package:business_agent/core/http/repository/mine_request.dart';
// import 'package:business_agent/core/http/repository/project_request.dart';
// import 'package:business_agent/core/http/repository/userinfo_request.dart';
// import 'package:business_agent/entity/userinfo_entity.dart';
// import 'package:business_agent/utils/sp_util/sp_util.dart';
import 'package:get/get.dart';

class BaseGetController extends GetxController {
  /// 用户信息
  // UserinfoEntity? userinfo;

  // bool get isLogin => userinfo != null;

  // /// 登录模块请求仓库
  // late LoginRequest loginRequest;

  // /// 综合模块请求仓库
  // late ComplexRequest complexRequest;

  // /// 项目模块请求仓库
  // late ProjectRequest projectRequest;

  // /// 我的模块请求仓库
  // late MineRequest mineRequest;

  // /// 用户信息模块请求仓库
  // late UserinfoRequest userinfoRequest;

  @override
  void onInit() {
    super.onInit();
    // loginRequest = Get.find<LoginRequest>();
    // complexRequest = Get.find<ComplexRequest>();
    // projectRequest = Get.find<ProjectRequest>();
    // mineRequest = Get.find<MineRequest>();
    // userinfoRequest = Get.find<UserinfoRequest>();
    // userinfo = SpUtil.getUserinfo();
  }
}
