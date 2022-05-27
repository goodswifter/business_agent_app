/*
 * @Author: lixiao
 * @Date: 2019-10-18 14:52:44
 * @LastEditTime: 2020-12-10 13:03:54
 * @LastEditors: Please set LastEditors
 * @Description: 状态管理类
 * @FilePath: 
 */

import 'package:flutter/material.dart' as prefix;
import 'package:provider/provider.dart';

import 'CheckOut.dart';
import 'pay_password_alert_textfield_provider.dart';
import 'pay_password_provider.dart';
import 'real_name_provider.dart';

class ProviderManager {
  static late prefix.BuildContext context;

  ///  将会在main.dart中runAPP实例化init
  static init({context, child}) {
    context = context;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CheckOut()),
        //实名认证
        ChangeNotifierProvider(create: (_) => RealNameProvider()),
        //支付密码
        ChangeNotifierProvider(create: (_) => PayPasswordProvider()),
        //alert 输入图形验证码
        ChangeNotifierProvider(
            create: (_) => PayPasswordAlertTextFieldProvider()),
      ],
      child: child,
    );
  }

  ///  通过Provider.value<T>(context)获取状态数据
  static T value<T>(context) {
    return Provider.of(context);
  }

  ///  通过Consumer获取状态数据
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }
}
