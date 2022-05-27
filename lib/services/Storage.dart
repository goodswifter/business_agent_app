

import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';

class Storage {
  static late SharedPreferences preferences;
  static late PackageInfo packageInfo;

  static Future<bool> getInstance() async {
    preferences = await SharedPreferences.getInstance();
    packageInfo = await PackageInfo.fromPlatform();
    return true;
  }

  static setString(key, value) {
    //  SharedPreferences sp=await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static getString(key) {
    //  SharedPreferences sp=await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  static remove(key) {
    //  SharedPreferences sp=await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  static clear() {
    //  SharedPreferences sp=await SharedPreferences.getInstance();
    preferences.clear();
  }

  static getAppNameString() {
    String appNameStr = '';

    if (packageInfo.appName != null) appNameStr = packageInfo.appName;

    return appNameStr;
  }

  static getPackageNameString() {
    String packageNameStr = '';

    if (packageInfo.packageName != null)
      packageNameStr = packageInfo.packageName;

    return packageNameStr;
  }

  static getAppVersionString() {
    String appVersionStr = '';

    if (packageInfo.version != null) appVersionStr = packageInfo.version;

    return appVersionStr;
  }

  static getAppBuildNumberString() {
    String appBuildNumberStr = '';

    if (packageInfo.buildNumber != null)
      appBuildNumberStr = packageInfo.buildNumber;

    return appBuildNumberStr;
  }
}
