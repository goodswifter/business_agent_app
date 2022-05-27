import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/badge_position.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:umpay_crossborder_app/pages/home/home_agent_page.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_info_page.dart';
import 'package:umpay_crossborder_app/pages/settlement_info/settlement_info_page.dart';
import 'package:umpay_crossborder_app/pages/trade_info/trade_info_page.dart';
import '../../dao/login_dao.dart';
import '../../model/login_info_model.dart';
import '../../network/network_message_code.dart';
import '../../pages/login_and_register/login_version_page.dart';
import '../../pages/message/message_center.dart';
import '../../pages/my/my_page.dart';
import '../../services/EventBus.dart';
import '../../services/Storage.dart';
import '../../services/UserServices.dart';
import '../../utils/lxl_easy_loading.dart';
import '../../utils/navigator_util.dart';
import '../../services/ScreenAdapter.dart';
// import 'Category.dart';

typedef CallBack = Function(Object obj);

class Tabs extends StatefulWidget {
  final int? indexPage;

  Tabs({Key? key, this.indexPage}) : super(key: key);

  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();

    if (widget.indexPage != null) {
      this._currentIndex = widget.indexPage!;
    }
    // this._currentIndex = widget.indexPage;

    this._pageController = PageController(initialPage: this._currentIndex);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      eventBus.on<RequestDataToLoginPageEvent>().listen((event) {
        // All events are of type UserLoggedInEvent (or subtypes of it).
        print("event bus refresh code ---> ${event.obj}");

        //获取刷新refreshToken
        _requestAuthRefreshTokenData((obj) {
          //跳转登录界面
          // NavigatorUtil.push(context, LoginVersionPage(isShowLoginBack: true));
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(
                  builder: (context) => new LoginVersionPage()),
              (route) => route == null);
        });
      });
    });
  }

  List<Widget> _pageList = [
    HomeAgentPage(),     //首页
    MerchantInfoPage(),  //商户
    TradeInfoPage(), //交易
    SettlementInfoPage(), //结算
    MyPage() //我的
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _currentIndex!=3?:AppBar(
      //   title: Text("用户中心"),
      // ),
      body: PageView(
        controller: this._pageController,
        children: this._pageList,
        onPageChanged: (index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        physics: NeverScrollableScrollPhysics(), //禁止pageView滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
            this._pageController.jumpToPage(index);
          });
        },
        iconSize: 20.0,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          // BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.category), title: Text("分类")),
          // BottomNavigationBarItem(icon: Icon(Icons.message), title: Text("消息")),
          // BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("我的"))

          BottomNavigationBarItem(
            icon: Image.asset(
              "images/sh_app_home_image_normal.png",
              fit: BoxFit.cover,
            ),
            // title: Container(
            //   margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            //   child: Text("首页"),
            // ),
            label: "首页",
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
            // title: Container(
            //   margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            //   child: Text("商户"),
            // ),
            label: "商户",
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
            // title: Container(
            //   margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            //   child: Text("交易"),
            // ),
            label: "交易",
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
            // title: Container(
            //   margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            //   child: Text("结算"),
            // ),
            label: "结算",
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
            // title: Container(
            //   margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            //   child: Text("我的"),
            // ),
            label: "我的",
            activeIcon: Image.asset(
              "images/sh_app_my_image_selected.png",
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  ///调用刷新rereshToken的接口
  /// 刷新 refreshToken登录
  _requestAuthRefreshTokenData(CallBack callback) async {
    //获取刷新token
    String refreshToken = UserServices.getRefreshToken();
    Map params = {
      "refreshToken": refreshToken,
    };

    var response = await LoginDao.doAuthRefreshTokenData(params);
    LogUtil.e("response = ${response}");
    if (response == null) return;
    LoginInfoModel loginModel = LoginInfoModel.fromJson(response);

    if (loginModel.code == ResponseMessage.SUCCESS_CODE) {
      //成功
      String? token = loginModel.data!.token;
      String? refreshToken = loginModel.data!.refreshToken;

      //登录成功保存token、refreshToken
      SpUtil.putString("token", token!);
      SpUtil.putString("refreshToken", refreshToken!);
    } else {
      callback("跳转登录");
      // String msg = ResponseMessage.getResponseMessageCode(
      //     loginModel.code, loginModel.message);
      // if (msg == "" || msg == null) {
      //   callback("跳转登录");
      //   return;
      // }
      // LXLEasyLoading.showToast(msg);

    }
  }
}
