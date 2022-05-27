///
/// Author       : zhongaidong
/// Date         : 2022-05-26 19:56:00
/// Description  : Tab数据类
///
import 'package:flutter/material.dart';
import 'package:flutter_badged/badge_position.dart';
import 'package:flutter_badged/flutter_badge.dart';

import '../home/home_agent_page.dart';
import '../merchant_info/merchant_info_page.dart';
import '../my/my_page.dart';
import '../settlement_info/settlement_info_page.dart';
import '../trade_info/trade_info_page.dart';

class TabDatas {
  /// Page页面
  static List<Widget> pageList = const [
    HomeAgentPage(), // 首页
    MerchantInfoPage(), // 商户
    TradeInfoPage(), // 交易
    SettlementInfoPage(), // 结算
    MyPage() // 我的
  ];

  /// Tab标题
  static List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Image.asset(
        "images/sh_app_home_image_normal.png",
        fit: BoxFit.cover,
      ),
      label: '首页',
      activeIcon: Image.asset(
        "images/sh_app_home_image_selected.png",
        fit: BoxFit.cover,
      ),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        "images/sh_app_business_image_normal.png",
        fit: BoxFit.cover,
      ),
      label: '商户',
      activeIcon: Image.asset(
        "images/sh_app_business_image_selected.png",
        fit: BoxFit.cover,
      ),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        "images/sh_app_store_image_normal.png",
        fit: BoxFit.cover,
      ),
      label: '交易',
      activeIcon: Image.asset(
        "images/sh_app_store_image_selected.png",
        fit: BoxFit.cover,
      ),
    ),
    BottomNavigationBarItem(
      icon: FlutterBadge(
        icon: Image.asset(
          "images/sh_app_message_image_normal.png",
          fit: BoxFit.cover,
        ),
        itemCount: 0, //***消息数量小红点***
        badgeColor: Colors.red,
        position: BadgePosition.topRight(),
        borderRadius: 20.0,
      ),
      label: '结算',
      activeIcon: Image.asset(
        "images/sh_app_message_image_selected.png",
        fit: BoxFit.cover,
      ),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        "images/sh_app_my_image_normal.png",
        fit: BoxFit.cover,
      ),
      label: '我的',
      activeIcon: Image.asset(
        "images/sh_app_my_image_selected.png",
        fit: BoxFit.cover,
      ),
    ),
  ];
}
