

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

typedef StatusCallback = void Function(EasyLoadingStatus status);

class LXLEasyLoading {
  static late Timer _timer;
  static late double _progress;

  //在main函数中初始化调用配置信息
  LXLEasyLoading() {
    configLoading();
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring //fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
      
      // ..customAnimation = CustomAnimation();
  }

  static show() {
    // configLoading();
    // EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ring;
    EasyLoading.show(
        // status: 'loading...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false);
  }

  static dismiss() {
    EasyLoading.dismiss();
  }

  static showToast(String toast) {
    EasyLoading.showToast(toast);
  }

  static showInfo(String toast) {
    // EasyLoading.showInfo('Useful Information.');
    EasyLoading.showInfo(toast);
  }

  static showSuccess(String toast) {
    // EasyLoading.showSuccess('Great Success!');
    EasyLoading.showSuccess(toast);
  }

  static showError(String toast) {
    // EasyLoading.showError('Failed with Error');
    EasyLoading.showError(toast);
  }

  //加载进度
  //例如： EasyLoading.showProgress(0.3, status: 'downloading...');
  static showProgress(double value) {
    _progress = 0;
    _timer.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      EasyLoading.showProgress(_progress,
          status: '${(_progress * 100).toStringAsFixed(0)}%');
      // _progress += 0.03;
      _progress += value;

      if (_progress >= 1) {
        _timer.cancel();
        EasyLoading.dismiss();
      }
    });
  }
 
 //添加状态回调
  static addStatusCallback(StatusCallback callback) {
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');

      callback(status);
    });
  }
 
  //移除状态回调
  static removeCallback(StatusCallback callback) {
    EasyLoading.removeCallback((status) {
      print('EasyLoading Status $status');

      callback(status);
    });
  }

  static removeAllCallbacks() {
    EasyLoading.removeAllCallbacks();
  }
}
