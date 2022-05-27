import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:umpay_crossborder_app/dao/merchant_dao.dart';
import 'package:umpay_crossborder_app/pages/tabs/tab_page.dart';

import './network/lxl_dio_http_manager.dart';
import './utils/print_utils.dart';
import '../../pages/login_and_register/login_version_page.dart';
import '../../services/UserServices.dart';
import '../../utils/custom_device_info_utils.dart';
import '../../utils/lxl_easy_loading.dart';
import '../../utils/package_info_utils.dart';
import 'pages/provider/provider_manager.dart';
import 'routers/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //初始化sp
  await SpUtil.getInstance();

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _token = "";
  // 手机号
  String mobile = "";

  @override
  void initState() {
    super.initState();

    requestTest();

    LXLEasyLoading();
    //初始化数据
    _initDataInfo();
    //获取设备信息
    _getPackageInfo();

    //设置app的badge数量
    // _setAppBadgeNumber();

    //设置屏幕方向
    // _setDeviceDirection();

    // _requestTestData();
  }

  requestTest() async {
    // var response = await MerchantDao.requestBusinessCategory();
    // print(response);
  }

  _requestTestData() async {
    var response = await LXLDioHttpManager.getRequestData("");
    printLong("response data = $response");
  }

  ///设置app图标的app_badge
  _setAppBadgeNumber() async {
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        _addBadge();

        // _removeBadge();
      } else {}
    } on PlatformException {
      print('Failed to get badge support.');
    }
  }

  void _addBadge() {
    FlutterAppBadger.updateBadgeCount(1);
  }

  void _removeBadge() {
    FlutterAppBadger.removeBadge();
  }

  ///初始化数据
  _initDataInfo() async {
    // bool success = await Storage.getInstance();
    // print("Storage init-" + success.toString());

    mobile = UserServices.getAgentPhone();
    if (mobile == "") {
      mobile = "";
    }

    /////////////////////////////////////////////////////////

    //获取用户token
    _token = UserServices.getToken();
    if (_token == "") {
      _token = "";
    }

    //获取设备运行信息(uuid 安卓-androidID iOS-identifierID)
    String? uuid = SpUtil.getString("uuid");
    if (uuid == null || uuid.isEmpty) {
      uuid = await CustomDeviceInfoUtils.getDeviceInfo();
    }

    // 随机数生成设备uuid
    SpUtil.putString("uuid", uuid);
  }

  //获取设备信息
  _getPackageInfo() async {
    await PackageInfoUtil.initPackageInfo();

    LogUtil.e(PackageInfoUtil.appName);
    LogUtil.e(PackageInfoUtil.packageName);
    LogUtil.e(PackageInfoUtil.version);
    LogUtil.e(PackageInfoUtil.buildNumber);

    SpUtil.putString("appName", PackageInfoUtil.appName);
    SpUtil.putString("packageName", PackageInfoUtil.packageName);
    SpUtil.putString("version", PackageInfoUtil.version);
    SpUtil.putString("buildNumber", PackageInfoUtil.buildNumber);
  }

  // //设置屏幕方向
  // _setDeviceDirection() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   if (Platform.isIOS) {
  //     await LimitingDirectionCsx.setScreenDirection(
  //         DeviceDirectionMask.Portrait);
  //   } else {
  //     await SystemChrome.setPreferredOrientations(
  //         [DeviceOrientation.portraitUp]);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      builder: (_, __) => ProviderManager.init(
        child: RefreshConfiguration(
          child: MaterialApp(
            navigatorKey: navigatorKey,
            home: mobile.isEmpty || mobile == ""
                ? LoginVersionPage()
                : const TabPage(),
            debugShowCheckedModeBanner: false,
            // initialRoute: '/',
            onGenerateRoute: onGenerateRoute,
            theme: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: Colors.white, // appbar背景颜色
                    onPrimary: Colors.black, // appbar文字颜色
                    brightness: Brightness.light,
                  ),
              highlightColor: const Color.fromRGBO(0, 0, 0, 0),
              splashColor: const Color.fromRGBO(0, 0, 0, 0), //取消点击tabbar的底部点击颜色
            ),
            localizationsDelegates: const [
              RefreshLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: const Locale('zh'),
            supportedLocales: const [
              // 支持的语言
              Locale('zh', 'CN'), // Chinese
              Locale('en', 'US'),
            ],
            // Locale? locale
            localeResolutionCallback:
                (Locale? locale, Iterable<Locale> supportedLocales) {
              return locale;
            },

            // builder: FlutterBoost.init(postPush: _onRoutePushed),
            // builder: EasyLoading.init(),
            //解决builder支持多种调用方式
            builder: (context, child) {
              child = EasyLoading.init()(context, child);
              // child = FlutterBoost.init(postPush: _onRoutePushed)(context, child),
              return child;
            },
          ),
        ),
      ),
    );
  }
}
