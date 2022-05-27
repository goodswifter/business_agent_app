/*
 * @Author: lixiao
 * @Date:
 * @LastEditTime: 
 * @LastEditors: 
 * @Description: 设备信息 获取uuid
 * @FilePath: 
 */

import 'dart:io';
import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:device_info/device_info.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDeviceInfoUtils {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  static Future<String> getDeviceInfo() async {
    String? uuid = await _initPlatformState();
    return uuid != null ? uuid : "";
  }

  static Future<String?> _initPlatformState() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);

        String currentUUID = deviceData["androidId"];
        return currentUUID;
        // SpUtil.putString("androidUUID", currentUUID);

      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);

        print("ios uuid = ${deviceData["identifierForVendor"]}");

        String currentUUID = deviceData["identifierForVendor"];
        List list = currentUUID.split("-");
        String uuidStr = "";
        list.forEach((element) {
          uuidStr += element;
        });
        print("iOS 拼接 uuid = ${uuidStr}");

        return uuidStr;
        // SpUtil.putString("iosUUID", deviceData["identifierForVendor"]);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
  }

  static Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  static Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  //方法暂未使用
  /**
   * 获取随机数可用于标识设备唯一id
   * 
   */
  static String getRandomNumber() {
    // String alphabet =
    //     'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    String alphabet = 'qwertyuiopasdfghjklzxcvbnm1234567890';
    int strlenght = 30;

    /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < strlenght; i++) {
//    right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    print(left);
    return left;
  }
}
