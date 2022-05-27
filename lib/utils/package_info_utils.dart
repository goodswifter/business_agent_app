


import 'package:package_info/package_info.dart';

class PackageInfoUtil {
  static late PackageInfo packageInfo;
  static late String appName;
  static late  String packageName;
  static late String version;
  static late String buildNumber;

  static initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

}
