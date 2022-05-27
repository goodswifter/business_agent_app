///
/// Author       : zhongaidong
/// Date         : 2022-04-22 21:04:41
/// Description  : Toast工具类
///
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ToastUtil {
  /// 初始化
  static init() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..fontSize = 16.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  /// 显示toast
  static show(String name,
      {EasyLoadingToastPosition position = EasyLoadingToastPosition.center}) {
    EasyLoading.showToast(
      name,
      toastPosition: position,
    );
  }
}
