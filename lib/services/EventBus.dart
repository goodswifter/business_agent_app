import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

//Bus 初始化
EventBus eventBus = EventBus();

//**********************惠商代理商事件***************************/

///新增商户alert跳转界面事件
class MerchantAlertEvent {
  //小微企业-0 个体户-1 普通企业-2 事业单位-3 其他组织-4
  late int index;
  MerchantAlertEvent(this.index);
}

//////////////////////////////////////////////////////

//首页top header event（扫一扫、付款码、收款码）
class HomeTopDidSelectedEvent {
  late BuildContext context;
  late int index;
  HomeTopDidSelectedEvent(this.context, this.index);
}

//用户登录广播
///根据接口中code值，跳转登录界面数据
class RequestDataToLoginPageEvent {
  late Object obj;
  RequestDataToLoginPageEvent(this.obj);
}

///设置支付密码后，通知设置页面中的登录密码、支付密码“未设置” 显示 或者 消失
class SetNotificatonEvent {
  late bool isHidden;

  SetNotificatonEvent(this.isHidden);
}

///获取用户信息event ： 用于更新用户使用
class UserInfoEvent {
  UserInfoEvent() {
    print("用户信息event广播了。。。");
  }
}

///实名的图片
class RealNameImageEvent {
  String image1 = "";
  String image2 = "";

  RealNameImageEvent(this.image1, this.image2);
}

///自定义键盘
///点击按钮后，通知的数据传递。。。
class SetAmountNotificatonEvent {
  late String data;
  bool? isConfirm; //是否点击确定了

  SetAmountNotificatonEvent(this.data, this.isConfirm);
}
