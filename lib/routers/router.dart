/*
 * // @dart=2.9 
 */

import 'package:flutter/material.dart';
import 'package:umpay_crossborder_app/pages/tabs/tab_page.dart';

// 配置路由
final Map<String, Function> routes = {
  '/': (context) => const TabPage(),

  //  LXLKeyDefine.SearchKey: (context) => SearchPage(),
  // '/login': (context) => LoginPage(),
  // '/registerSecond': (context,{arguments}) => RegisterSecondPage(arguments: arguments),
};

// 固定写法
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};
