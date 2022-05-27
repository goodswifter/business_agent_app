import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomeSwiperWidget extends StatefulWidget {
  HomeSwiperWidget({Key? key}) : super(key: key);

  @override
  _HomeSwiperWidgetState createState() => _HomeSwiperWidgetState();
}

class _HomeSwiperWidgetState extends State<HomeSwiperWidget> {
  //两张banner图
  // List _focusData = ["home_new_banner_sh.png","home_prompt_image_1.png", "home_banner_image_2.png"];
  List _focusData = ["home_new_banner_sh.png"];

  @override
  void initState() {
    super.initState();

    // _getFocusData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      child: _swiperWidget(),
    );
  }

  //轮播图
  Widget _swiperWidget() {
    if (this._focusData.length > 0) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 350 / 100,
              child: Swiper(
                scale: 0.8,
                fade: 0.8,
                itemBuilder: (BuildContext context, int index) {
                  // String pic = this._focusData[index].pic;
                  // pic = Config.domain + pic.replaceAll('\\', '/');
                  // return Image.network(
                  //   "${pic}",
                  //   fit: BoxFit.fill,
                  // );
                  return Image.asset(
                    "images/${this._focusData[index]}",
                    fit: BoxFit.fill,
                  );
                },
                itemCount: this._focusData != null ? this._focusData.length : 1,
                pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                  size: 8,
                  activeSize: 8,
                  color: Color(0xffbfaae3),
                  activeColor: Colors.white,
                )),
                // pagination: SwiperCustomPagination(
                //     builder: (BuildContext context, SwiperPluginConfig config) {
                //   return Container(
                //     alignment: Alignment.bottomCenter,
                //     height: 15,
                //     margin: EdgeInsets.fromLTRB(
                //         0, (LXLScreen.width - 20) / 4 - 20, 0, 0),
                //     // color: Colors.green,
                //     child: PageIndicator(
                //       layout: PageIndicatorLayout.LINE,
                //       size: 10.0,
                //       space: 10.0,
                //       count:
                //           this._focusData != null ? this._focusData.length : 1,
                //       controller: config.pageController,
                //       color: Color(0xffbfaae3),
                //     ),
                //   );
                // }),
                autoplay: true, //是否自动播放
                onTap: (int index) {
                  print("on tap index = ${index}");
                  setState(() {
                    // this._title = this._focusData[index].title;
                  });
                },

                onIndexChanged: (int index) {
                  // print("changed index = ${index}");
                  setState(() {
                    // this._title = this._focusData[index].title;
                  });
                },
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  //获取轮播图数据
  // _getFocusData() async {
  //   // LXLEasyLoading.show();
  //   var response = await HomeDao.doGetFocusData();
  //   LogUtil.e("----focusdata = ${response}----");
  //   // LXLEasyLoading.dismiss();
  //   var focusList = FocusModel.fromJson(response);
  //   setState(() {
  //     this._focusData = focusList.result;
  //     // this._title = this._focusData[0].title;
  //   });

  //   // var api = '${Config.domain}api/focus';
  //   // var result = await Dio().get(api);
  //   // var focusList = FocusModel.fromJson(result.data);
  //   // setState(() {
  //   //   this._focusData = focusList.result;
  //   // });
  // }
}
