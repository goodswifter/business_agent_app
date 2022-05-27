import 'package:flutter/material.dart';
import '../../model/user_info_model.dart';
import '../../utils/determine_user_real_name_status_utils.dart';

class RealNameProvider with ChangeNotifier {
  // 个人信息
  final List _dataList = [
    {
      "type": "类型",
      "value": "个人",
    },
    {
      "type": "用户姓名",
      "value": "",
    },
    {
      "type": "身份证号",
      "value": "",
    },
    {
      "type": "实名状态",
      "value": "",
    }
  ];

  // //企业信息
  // List _enterpriseDataList = [
  //   {
  //     "type": "类型",
  //     "value": "企业",
  //   },
  //   {
  //     "type": "企业名称",
  //     "value": "联动优势",
  //   },
  //   {
  //     "type": "营业执照",
  //     "value": "123456789",
  //   },
  //   {
  //     "type": "企业性质",
  //     "value": "有限责任公司",
  //   },
  //   {
  //     "type": "营业执照",
  //     "value": "图片缩略图",
  //   },
  //   {
  //     "type": "开户许可证",
  //     "value": "图片缩略图",
  //   },
  //   {
  //     "type": "实名状态",
  //     "value": "认证中",
  //   }
  // ];

  final List _enterpriseDataList = [
    {
      "type": "",
      "value": "企业",
      "rmk": "类型",
    },
    {
      "type": DetermineUserRealNameStatusUtils.ENTERPRISE_0201,
      "value": "",
      "rmk": DetermineUserRealNameStatusUtils.B_BUSINESS_NAME,
    },
    {
      "type": DetermineUserRealNameStatusUtils.ENTERPRISE_0202,
      "value": "",
      "rmk": DetermineUserRealNameStatusUtils.B_BUSINESS_LICENSE_NO,
    },
    {
      "type": DetermineUserRealNameStatusUtils.ENTERPRISE_0203,
      "value": "",
      "rmk": DetermineUserRealNameStatusUtils.B_BUSINESS_NATURE,
    },
    {
      "type": DetermineUserRealNameStatusUtils.ENTERPRISE_0204,
      "value": "", //营业执照
      "rmk": DetermineUserRealNameStatusUtils.B_BUSINESS_LICENSE,
    },
    {
      "type": DetermineUserRealNameStatusUtils.ENTERPRISE_0205,
      "value": "", //开户许可证
      "rmk": DetermineUserRealNameStatusUtils.B_OPENING_PERMIT,
    },
    {
      "type": "",
      "value": "未实名",
      "rmk": "实名状态",
    },
  ];

  //营业执照图片链接
  String _businessLicenseImageStr = "";
  //开户许可证图片链接
  String _openingPermitImageStr = "";

  // //营业执照图片---全链接
  // String _businessLicenseImageAllStr = "";
  // //开户许可证图片---全链接
  // String _openingPermitImageAllStr = "";

  List get dataList => _dataList;
  List get enterpriseDataList => _enterpriseDataList;
  String get businessLicenseImageStr => _businessLicenseImageStr;
  String get openingPermitImageStr => _openingPermitImageStr;
  // String get businessLicenseImageAllStr => this._businessLicenseImageAllStr;
  // String get openingPermitImageAllStr => this._openingPermitImageAllStr;

  ///更新图片信息 营业执照图片、开户许可证图片
  void updateImageData(
      String businessLicenseImageStr, String openingPermitImageStr) {
    _businessLicenseImageStr = businessLicenseImageStr;
    _openingPermitImageStr = openingPermitImageStr;

    // this._businessLicenseImageAllStr =
    //     "${Config.imageAvatarBaseUrl}" + businessLicenseImageStr;
    // this._openingPermitImageAllStr =
    //     "${Config.imageAvatarBaseUrl}" + openingPermitImageStr;

    notifyListeners();
  }

  ///更新个人用户信息
  void updateInfoData(UserInfoModel userItemModel) async {
    String? currentType = userItemModel.userItem!.type;
    if (currentType == "C") {
      _dataList[0]["value"] = "个人";
    } else {
      _dataList[0]["value"] = "企业";
    }

    // String status = DetermineUserRealNameStatusUtils.getUserRealStatus(userItemModel);
    String? currentStatus = userItemModel.userItem!.status;
    //用户实名状态   U:初始未认证  S:实名审核通过   W:认证提交未审核  F:用户销毁  R:实名审核拒绝
    if (currentStatus == "S") {
      _dataList[3]["value"] = "已实名";
    }

    List userExtsList = userItemModel.userItem!.userExts;
    userExtsList.forEach((element) {
      UserExts userExts = element;
      print("name = ${userExts.value}");
      if (userExts.type == DetermineUserRealNameStatusUtils.C_0101) {
        //用户名
        _dataList[1]["value"] = userExts.value;
      } else if (userExts.type == DetermineUserRealNameStatusUtils.C_0102) {
        //身份证号
        _dataList[2]["value"] = userExts.value;
      }
    });

    notifyListeners();
  }

  ///更新企业用户信息
  void updateEnterpriseInfoData(UserInfoModel userItemModel) async {
    String? currentType = userItemModel.userItem!.type;
    if (currentType == DetermineUserRealNameStatusUtils.TYPE_C) {
      //"C"
      _enterpriseDataList[0]["value"] = "个人";
    } else {
      _enterpriseDataList[0]["value"] = "企业";
    }

    // String status = DetermineUserRealNameStatusUtils.getUserRealStatus(userItemModel);
    String? currentStatus = userItemModel.userItem!.status;
    //用户实名状态   U:初始未认证  S:实名审核通过   W:认证提交未审核  F:用户销毁  R:实名审核拒绝
    if (currentStatus == "S") {
      _enterpriseDataList[6]["value"] = "已实名";
    } else if (currentStatus == "P") {
      _enterpriseDataList[6]["value"] = "认证中";
    } else if (currentStatus == "R") {
      _enterpriseDataList[6]["value"] = "实名审核拒绝";
    } else if (currentStatus == "W") {
      _enterpriseDataList[6]["value"] = "认证提交未审核";
    }

    List userExtsList = userItemModel.userItem!.userExts;
    userExtsList.forEach((element) {
      UserExts userExts = element;
      print("name = ${userExts.value}");

      if (userExts.type == DetermineUserRealNameStatusUtils.ENTERPRISE_0201) {
        _enterpriseDataList[1]["value"] = userExts.value; //"企业名称";
      } else if (userExts.type ==
          DetermineUserRealNameStatusUtils.ENTERPRISE_0202) {
        _enterpriseDataList[2]["value"] = userExts.value; //"营业执照号";
      } else if (userExts.type ==
          DetermineUserRealNameStatusUtils.ENTERPRISE_0203) {
        _enterpriseDataList[3]["value"] = userExts.value; // "企业性质";
      } else if (userExts.type ==
          DetermineUserRealNameStatusUtils.ENTERPRISE_0204) {
        // this._enterpriseDataList[4]["value"] =
        //     "${Config.imageAvatarBaseUrl}" + userExts.value; //"营业执照";

        if (userExts.value == null ||
            userExts.value == "" ||
            userExts.value!.length == 0) {
          _enterpriseDataList[4]["value"] = "";
        } else {
          _enterpriseDataList[4]["value"] = userExts.value; //"开户许可证";
        }
      } else if (userExts.type ==
          DetermineUserRealNameStatusUtils.ENTERPRISE_0205) {
        // this._enterpriseDataList[5]["value"] =
        //     "${Config.imageAvatarBaseUrl}" + userExts.value; //"开户许可证";

        if (userExts.value == null ||
            userExts.value == "" ||
            userExts.value!.length == 0) {
          _enterpriseDataList[5]["value"] = "";
        } else {
          _enterpriseDataList[5]["value"] = userExts.value; //"开户许可证";
        }
      }
    });

    notifyListeners();
  }
}
