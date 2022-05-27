import 'dart:async';

import 'package:flutter/material.dart';

import '../../pages/login_and_register/login_version_page.dart';
import '../../services/UserServices.dart';
import '../tabs/tab_page.dart';

class WelcomeNewPage extends StatefulWidget {
  WelcomeNewPage({Key? key}) : super(key: key);

  @override
  _WelcomeNewPageState createState() => _WelcomeNewPageState();
}

class _WelcomeNewPageState extends State<WelcomeNewPage> {
  PageController _pageController = PageController();
  int _pageIndex = 0;
  GlobalKey<_WelcomeNewPageState> _pageIndicatorKey = GlobalKey();
  bool _isShowJump = true;

  int changeIndex = 0;
  late Timer? timer = null;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(milliseconds: 100), (sd) {
      setState(() {
        changeIndex += 1;
      });
      if (changeIndex >= 100) {
        //跳转到主页
        _didJumpToMainPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            _createPageView(),
            // _createPageIndicator(),
            _jumpBtnWidget(),
          ],
        ),
      ),
    );
  }

  Widget _jumpBtnWidget() {
    return Container(
      alignment: Alignment.topRight,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
//       color: Colors.green,//设置背景色，为了看清控件位置设置，在界面完成之后屏蔽此代码
          borderRadius: BorderRadius.all(Radius.circular(30)), //设置圆角
        ),
        alignment: Alignment.center, //居中显示
        margin: EdgeInsets.fromLTRB(0, 30, 20, 0), //EdgeInsets.all(20), //设置外边距
        child: GestureDetector(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  value: changeIndex / 100,
                  strokeWidth: 1,
                  color: Colors.white,
                  backgroundColor: Color(0xffc4c4c4), //Colors.white,
                ),
              ),
              Container(
                // margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                // color: Color(0xffc4c4c4),
                child: Text(
                  "跳过",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff333333),
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            //跳转到主页
            _didJumpToMainPage();
          },
        ),
      ),
    );

    // return Align(
    //   alignment: Alignment(1, -0.9),
    //   child: Visibility(
    //     visible: this._isShowJump, //true,
    //     child: GestureDetector(
    //       behavior: HitTestBehavior.opaque,
    //       onTap: () {
    //         //跳转到主页
    //         _didJumpToMainPage();
    //       },
    //       child: Container(
    //         height: 25,
    //         width: 50,
    //         margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
    //         alignment: Alignment.center,
    //         decoration: BoxDecoration(
    //           color: Color(0xffc4c4c4),
    //           borderRadius: BorderRadius.circular(13),
    //         ),
    //         child: Text(
    //           "跳过",
    //           style: TextStyle(
    //             color: Color(0xffffffff),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _createPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (pageIndex) {
        setState(() {
          _pageIndex = pageIndex;
          //是否展示跳转，隐藏跳过
          // pageIndex == 2 ? this._isShowJump = false : this._isShowJump = true;

          print(_pageController.page);
          print(pageIndex);
        });
      },
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _scrollToNextPage();
          },
          child: Container(
            child: Center(
              child:
                  Image.asset("images/welcome_image_1.png", fit: BoxFit.cover),
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _scrollToNextPage();
          },
          child: Container(
            child: Center(
              child:
                  Image.asset("images/welcome_image_2.png", fit: BoxFit.cover),
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Container(
            child: Center(
              child:
                  Image.asset("images/welcome_image_3.png", fit: BoxFit.cover),
            ),
          ),
          onTap: () {
            //跳转到主页
            _didJumpToMainPage();
          },
        ),
      ],
    );
  }

  // _createPageIndicator() {
  //   return Opacity(
  //     opacity: 0.7,
  //     child: Align(
  //       alignment: FractionalOffset.bottomCenter,
  //       child: Container(
  //         margin: EdgeInsets.only(bottom: 60),
  //         height: 40,
  //         width: 80,
  //         padding: EdgeInsets.all(0),
  //         decoration: BoxDecoration(
  //             // color: Colors.grey, //.withAlpha(128),
  //             borderRadius: BorderRadius.all(const Radius.circular(6.0))),
  //         child: GestureDetector(
  //           behavior: HitTestBehavior.translucent,
  //           onTapUp: (detail) => _handlePageIndicatorTap(detail),
  //           child: Row(
  //               key: _pageIndicatorKey,
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 _dotWidget(0),
  //                 _dotWidget(1),
  //                 _dotWidget(2),
  //               ]),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // _dotWidget(int index) {
  //   return Container(
  //       width: 10,
  //       height: 10,
  //       decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: (_pageIndex == index) ? Colors.red : Colors.black12));
  // }

  // _handlePageIndicatorTap(TapUpDetails detail) {
  //   RenderBox renderBox = _pageIndicatorKey.currentContext.findRenderObject();
  //   Size widgeSize = renderBox.paintBounds.size;
  //   Offset tapOffset = renderBox.globalToLocal(detail.globalPosition);

  //   if (tapOffset.dx > widgeSize.width / 2) {
  //     _scrollToNextPage();
  //   } else {
  //     _scrollToPreviousPage();
  //   }
  // }

  // _scrollToPreviousPage() {
  //   if (_pageIndex > 0) {
  //     _pageController.animateToPage(_pageIndex - 1,
  //         duration: const Duration(milliseconds: 200), curve: Curves.ease);
  //   }
  // }

  _scrollToNextPage() {
    // if (_pageIndex > 0) {
    _pageController.animateToPage(_pageIndex + 1,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
    // }
  }

  ///点击进入主页
  _didJumpToMainPage() {
    if (timer!.isActive) {
      timer!.cancel();
      timer = null;
    }

    //获取用户token
    String token = UserServices.getToken();
    if (token == null || token == "" || token.length == 0) {
      //进入登录页面
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginVersionPage()),
          (route) => route == null);
    } else {
      //跳转首页
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => TabPage()),
          (route) => route == null);
    }
  }
}
