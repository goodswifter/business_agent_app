import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

//自定义头部滑动动画  -----  暂时不使用
class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double? collapsedHeight;
  final double? expandedHeight;
  final double? paddingTop;
  final String? coverImgUrl;
  final String? title;

  //点击头像事件
  var didHeaderUserImageAction;

  SliverCustomHeaderDelegate(
      {this.collapsedHeight,
      this.expandedHeight,
      this.paddingTop,
      this.coverImgUrl,
      this.title,
      this.didHeaderUserImageAction});

  @override
  double get minExtent => collapsedHeight! + paddingTop!;

  @override
  double get maxExtent => expandedHeight!;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    // print("${shrinkOffset}");
    if (shrinkOffset <= 50) {
      //50
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha =
          (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 背景图
          // Container(child: Image.network(this.coverImgUrl, fit: BoxFit.cover)),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: expandedHeight,
            child: _customHeaderInfoWidget(),
          ),
          // 收起头部
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: _headerAwayWidget(shrinkOffset),
          ),
        ],
      ),
    );
  }

  //收起的头部
  Widget _headerAwayWidget(shrinkOffset) {
    return Container(
      color: makeStickyHeaderBgColor(shrinkOffset), // 背景颜色
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: collapsedHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // IconButton(
              //   icon: Icon(
              //     Icons.arrow_back_ios,
              //     color: this.makeStickyHeaderTextColor(
              //         shrinkOffset, true), // 返回图标颜色
              //   ),
              //   onPressed: () => Navigator.pop(context),
              // ),
              const SizedBox(
                height: 30,
                width: 50,
              ),
              Text(
                title!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: makeStickyHeaderTextColor(shrinkOffset, false), // 标题颜色
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color:
                      makeStickyHeaderTextColor(shrinkOffset, true), // 分享图标颜色
                ),
                onPressed: () {
                  print("设置点击了");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //自定义头部信息的widget
  Widget _customHeaderInfoWidget() {
    return Stack(
      children: [
        Container(
          color: Colors.white, //Color(0xffddecfc),
          child: Container(
            color: const Color(0xffff0044),
            height: 250,
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: didHeaderUserImageAction,
                      // onTap: () {
                      //   print("aaaa");
                      // },
                      child: Container(
                        // color: Colors.red,
                        margin: const EdgeInsets.fromLTRB(10, 80, 10, 0),
                        child: ClipOval(
                          child: Image.asset(
                            'images/user.png',
                            fit: BoxFit.cover,
                            // width: ScreenAdapter.width(100),
                            // height: ScreenAdapter.width(100),
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                          // color: Colors.red,
                          // height: 30,
                          // width: 200,
                          child: Text(
                            title!,
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Color(0xff333333),
                            ),
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _subjectCustomWidget("lxl_ic_wc.png", "收藏"),
                      _subjectCustomWidget("lxl_ic_wc.png", "店铺关注"),
                      _subjectCustomWidget("lxl_ic_wc.png", "红包卡券"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            top: 210,
            left: 10,
            right: 10,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.red,
                color: const Color(0xfff7f7f8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _orderContentWidget(),
            )),
      ],
    );
  }

  //订单信息widget
  Widget _orderContentWidget() {
    return Row(
      children: [
        _subjectCustomOrderInfoWidget("lxl_ic_wc.png", "我的订单"),
        _subjectCustomOrderInfoWidget("lxl_ic_wc.png", "待付款"),
        _subjectCustomOrderInfoWidget("lxl_ic_wc.png", "待使用"),
        _subjectCustomOrderInfoWidget("lxl_ic_wc.png", "退款/售后"),
      ],
    );
  }

  //自定义 订单widget(我的订单、待付款、待使用、退款、售后 )
  _subjectCustomOrderInfoWidget(String image, String title) {
    return Expanded(
      flex: 1,
      child: InkWell(
        child: Container(
          margin: const EdgeInsets.all(10),
          // color: Colors.red,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                width: 40,
                // color: Colors.cyan,
                child: Image.asset("images/$image", fit: BoxFit.cover),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xff333333),
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          LogUtil.e("$title点击了");
        },
      ),
    );
  }

  Widget _subjectCustomWidget(String imageUrl, String name) {
    return InkWell(
      onTap: () {
        print("----> $name");
      },
      child: Row(
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: Image.asset(
              // "images/lxl_ic_wc.png",
              // imageUrl,
              "images/$imageUrl",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 15.0, color: Color(0xff333333)),
          ),
        ],
      ),
    );
  }
}
