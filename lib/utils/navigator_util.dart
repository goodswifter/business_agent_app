import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef CallBack = void Function();

class NavigatorUtil {
  static void pushPage(
    BuildContext context,
    Widget page, {
    required String pageName,
    bool needLogin = false,
  }) {
    if (context == null || page == null) return;
    // if (needLogin && !Common.isLogin()) {
    // pushPage(context, LoginPage());
    // return;
    // }
    Navigator.push(context, CupertinoPageRoute<void>(builder: (ctx) => page));
  }

  ///不带参数跳转
  static push(BuildContext context, Widget widgetPage) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => widgetPage));
  }

  ///跳转下一页有回调
  static pushHaveResult(
      BuildContext context, Widget widgetPage, CallBack callback) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widgetPage))
        .then((value) => callback());
  }

  ///带参数跳转
  static pushParams(BuildContext context, dynamic widgetPage, dynamic params) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => widgetPage(argument: params)));
  }

  ///进入到指定界面-可以多层进行返回跳转
  static pushSpecifiedPage(
      BuildContext context, dynamic pageName, Widget widgetPage) {
    Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(name: pageName),
        builder: (context) => widgetPage));
  }

  ///跳出到指定界面和上面的方法搭配使用
  static popSpecifiedPage(BuildContext context, dynamic pageName) {
    Navigator.popUntil(context, ModalRoute.withName(pageName));
  }

  ///不带参数的路由表跳转
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  ///跳转新页面并且替换，比如登录页跳转主页
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  ///跳转新页面并关闭当前页面
  static pushReplacement(BuildContext context, Widget widgetPage) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return widgetPage;
    }));
  }

  ///移除之前的界面(跳转到新的路由，并且关闭给定路由的之前的所有页面)
  static pushAndRemoveUntil(BuildContext context, Widget widgetPage) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widgetPage),
        (route) => route == null);
  }

  ///不带参数的路由跳转，并且监听返回
  static pushNoParamsResult(
      BuildContext context, dynamic widgetPage, Function callBack) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widgetPage))
        .then((result) {
      callBack(result);
    });
  }

  ///带参数的路由跳转，并且监听返回
  static pushParamsResult(BuildContext context, dynamic widgetPage,
      dynamic params, Function callBack) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widgetPage))
        .then((result) {
      callBack(result);
    });
  }
}
