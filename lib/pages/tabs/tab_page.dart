import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:umpay_crossborder_app/pages/tabs/tab_data.dart';

import '../../dao/login_dao.dart';
import '../../model/login_info_model.dart';
import '../../network/network_message_code.dart';
import '../../pages/login_and_register/login_version_page.dart';
import '../../services/EventBus.dart';
import '../../services/UserServices.dart';
// import 'Category.dart';

typedef CallBack = Function(Object obj);

class TabPage extends StatefulWidget {
  final int? indexPage;

  const TabPage({Key? key, this.indexPage}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();

    if (widget.indexPage != null) {
      _currentIndex = widget.indexPage!;
    }

    _pageController = PageController(initialPage: _currentIndex);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      eventBus.on<RequestDataToLoginPageEvent>().listen((event) {
        // All events are of type UserLoggedInEvent (or subtypes of it).
        print("event bus refresh code ---> ${event.obj}");

        // 获取刷新refreshToken
        _requestAuthRefreshTokenData((obj) {
          // 跳转登录界面
          // NavigatorUtil.push(context, LoginVersionPage(isShowLoginBack: true));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginVersionPage()),
              (route) => route == null);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: TabDatas.pageList,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(), // 禁止pageView滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        iconSize: 20.0,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: TabDatas.items,
      ),
    );
  }

  /// 调用刷新rereshToken的接口
  /// 刷新 refreshToken登录
  _requestAuthRefreshTokenData(CallBack callback) async {
    // 获取刷新token
    String refreshToken = UserServices.getRefreshToken();
    Map params = {
      "refreshToken": refreshToken,
    };

    var response = await LoginDao.doAuthRefreshTokenData(params);
    LogUtil.e("response = $response");
    if (response == null) return;
    LoginInfoModel loginModel = LoginInfoModel.fromJson(response);

    if (loginModel.code == ResponseMessage.SUCCESS_CODE) {
      // 成功
      String? token = loginModel.data!.token;
      String? refreshToken = loginModel.data!.refreshToken;

      // 登录成功保存token、refreshToken
      SpUtil.putString("token", token!);
      SpUtil.putString("refreshToken", refreshToken!);
    } else {
      callback("跳转登录");
    }
  }
}
