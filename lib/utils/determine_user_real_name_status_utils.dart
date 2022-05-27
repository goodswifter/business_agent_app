

import 'package:flutter/material.dart';
import '../../model/user_info_model.dart';

//判断用户实名状态
class DetermineUserRealNameStatusUtils {
  // 用户实名状态  U:初始未认证(可编辑)  S:实名审核通过
  // W:认证提交未审核  F:用户销毁  R:实名审核拒绝（可编辑）
  // String status;
  static const String STATUS_U = "U";
  static const String STATUS_S = "S";
  static const String STATUS_W = "W";
  static const String STATUS_R = "R";
  static const String STATUS_F = "F";
  static const String STATUS_P = "P";

  // 是个人还是企业  C 个人  B 企业
  // String type
  static const String TYPE_C = "C";
  static const String TYPE_B = "B";

  //实名企业类型 (B)
  // 0201(企业名称)
  // 0202(营业执照号)
  // 0203(企业性质)
  // 0204(营业执照)
  // 0205(开户许可证)
  static const String ENTERPRISE_0201 = "0201";
  static const String ENTERPRISE_0202 = "0202";
  static const String ENTERPRISE_0203 = "0203";
  static const String ENTERPRISE_0204 = "0204";
  static const String ENTERPRISE_0205 = "0205";

  static const String B_BUSINESS_NAME = "企业名称";
  static const String B_BUSINESS_LICENSE_NO = "营业执照号";
  static const String B_BUSINESS_NATURE = "企业性质";
  static const String B_BUSINESS_LICENSE = "营业执照";
  static const String B_OPENING_PERMIT = "开户许可证";

  //个人（C）
  // 0101(用户姓名)
  // 0102(身份证号)
  static const String C_0101 = "0101";
  static const String C_0102 = "0102";

  static const String C_NAME = "姓名";
  static const String C_ID = "身份证";

  //获取用户实名状态
  static String? getUserRealStatus(UserInfoModel userItemModel) {
    if (userItemModel.userItem!.status == STATUS_U) {
      return STATUS_U;
    } else if (userItemModel.userItem!.status == STATUS_S) {
      return STATUS_S;
    } else if (userItemModel.userItem!.status == STATUS_W) {
      return STATUS_W;
    } else if (userItemModel.userItem!.status == STATUS_R) {
      return STATUS_R;
    } else if (userItemModel.userItem!.status == STATUS_F) {
      return STATUS_F;
    } else if (userItemModel.userItem!.status == STATUS_P) {
      return STATUS_P;
    }
  }

  //是个人还是企业  C 个人  B 企业
  //获取是个人，还是企业
  static String? getUserISPersionalOrEnterprise(UserInfoModel userItemModel) {
    if (userItemModel.userItem!.type == TYPE_C) {
      return TYPE_C;
    } else if (userItemModel.userItem!.type == TYPE_B) {
      return TYPE_B;
    }
  }
}
