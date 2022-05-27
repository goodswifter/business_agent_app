import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

import '../../utils/lxl_screen.dart';

//自定义头部滑动动画  -----  暂时不使用
class SliverHomeCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double? collapsedHeight;
  final double? expandedHeight;
  final double? paddingTop;
  // final String coverImgUrl;
  // final String title;
  String? naviTitle;

  //点击消息铃时间
  var didHeaderMessageBellAction;
  //点击工具栏tools事件
  var didToolsAction;

  //工具类数据
  List toolsListData = [
    {
      "title": '新增商户',
      "imageUrl": 'images/sh_app_agent_add_merchant.png',
    },
    {
      "title": '草稿箱',
      "imageUrl": 'images/sh_app_draft_box.png',
    },
    {
      "title": '帮助中心',
      "imageUrl": 'images/sh_app_adent_help_center.png',
    },
    {
      "title": '更多',
      "imageUrl": 'images/sh_app_adent_image_more.png',
    },
  ];

  // 交易信息展示
  final List _tradeList = [
    {"title": "新增商户数", "number": "390"},
    {"title": "交易笔数", "number": "2000"},
  ];

  SliverHomeCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    // this.coverImgUrl,
    // this.title,
    this.naviTitle,
    required this.didHeaderMessageBellAction,
    required this.didToolsAction
  });

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
    // return Color.fromARGB(alpha, 255, 255, 255);
    // return Color.fromARGB(alpha, 243, 34, 56);
    return Color.fromARGB(alpha, 250, 68, 56);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    // print("${shrinkOffset}");
    return Colors.white;

    // if (shrinkOffset <= 50) {
    //   //50
    //   // return isIcon ? Colors.cyan : Colors.transparent;
    //   return Colors.white;
    // } else {
    //   final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
    //       .clamp(0, 255)
    //       .toInt();
    //   return Color.fromARGB(alpha, 0, 0, 0);
    // }
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
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: collapsedHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _headerTitleWidget(),
            ),
            IconButton(
                icon: Image.asset(
                  "images/sh_app_agent_message_1.png",
                  fit: BoxFit.cover,
                ),
                onPressed: didHeaderMessageBellAction
                )
          ],
        ),
      ),
    );
  }

  ///首页头部的导航（搜索，“+”组件）
  _headerTitleWidget() {
    return Container(
      height: 44,
      // color: Colors.yellow,
      margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      alignment: Alignment.center,
      child: Text(
        // "服务商名称",
        this.naviTitle != null && this.naviTitle!.length > 0 ? this.naviTitle! : "",
        style: TextStyle(
          color: Color(0xffffffff),
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  //自定义头部信息的widget
  Widget _customHeaderInfoWidget() {
    return SizedBox(
      // color: Colors.cyan,
      // height: 250,
      height: expandedHeight,
      child: Stack(
        children: [
          //顶部信息
          _topFirstWidget(),
          //工具类
          Positioned(
            top: 260 + 10 + 20, //310,
            width: LXLScreen.width,
            height: 117,
            child: Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              // child: _toolsItemWidget(),
              child: _toolsItemWidget(),
            ),
          ),
          Align(
            alignment: const Alignment(1, -0.6),
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 20 + 20, 0, 0),
              width: 76,
              height: 28,
              decoration: const BoxDecoration(
                // color: Color(0xffC52222),
                color: Color.fromRGBO(197, 34, 34, 0.5),
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(16)),
              ),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "昨日数据",
                  style: const TextStyle(
                    color: const Color(0xffeeeeee),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //顶部交易信息
  _topFirstWidget() {
    return Container(
      // height: expandedHeight, //230,
      height: 284 + 20 + 20, //350,
      // width: LXLScreen.width,
      decoration: const BoxDecoration(
        // color: Colors.red,
        image: DecorationImage(
          // image: ExactAssetImage("images/home_top_bg_3.png"), //存在虚边
          image: AssetImage("images/home_new_top_bg.png"),
          fit: BoxFit.cover,
          //这里是从assets静态文件中获取的，也可以NetworkImage(）从网络上获取
        ),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 63 + 10, 0, 0),
        // height: expandedHeight,
        height: 210, //284,
        width: LXLScreen.width,
        // color: Colors.purple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 28 + 10, 0, 0),
              alignment: Alignment.center,
              child: const Text(
                "今日交易额（元）",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: const Text(
                "20000",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            //新增交易数据和交易笔数
            Container(
              margin: const EdgeInsets.fromLTRB(0, 37, 0, 0),
              height: 70,
              // color: Colors.yellow,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                // padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                physics: const NeverScrollableScrollPhysics(), //禁用滑动事件
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3.0 / 1.0,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  // mainAxisSpacing: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      LogUtil.e("sliver grid --> $index");

                      // eventBus.fire(HomeTopDidSelectedEvent(context, index));
                      // _didSelectedTopItem(context, index);
                    },
                    child: Container(
                      // height: 100,
                      alignment: Alignment.center,
                      // color: Colors.cyan,
                      // color: Colors.transparent,
                      child: Container(
                        // width: 80,
                        // height: 80,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Opacity(
                              opacity: 0.8,
                              child: Container(
                                child: Text(
                                  "${_tradeList[index]["title"]}",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              child: Text(
                                // "900",
                                "${_tradeList[index]["number"]}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _tradeList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //工具栏 --- 根据后台可配置
  _toolsItemWidget() {
    return Container(
      // margin: EdgeInsets.fromLTRB(0, 37, 0, 0),
      height: 117,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
        physics: const NeverScrollableScrollPhysics(), //禁用滑动事件
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.0 / 1.2,
          crossAxisCount: 4,
          // crossAxisSpacing: 10,
          // mainAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // _didSelectedActivityItem(context, index);
              LogUtil.e("index = $index");

              didToolsAction(context, index);
            },
            child: Container(
              // height: 100,
              alignment: Alignment.center,
              // color: Color(0xfffafafa),
              // color: Colors.cyan[100 * (index % 9)],
              // child: Text('grid item $index'),
              child: Container(
                width: 90,
                height: 90,
                alignment: Alignment.center,
                // margin: EdgeInsets.all(5),
                // padding: EdgeInsets.only(top: 5),
                // color: Colors.white,
                // color: Color(0xfffafafa),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        toolsListData[index]["imageUrl"],
                        fit: BoxFit.cover,
                      ),
                      // child: Image.network(
                      //   listData[index]["imageUrl"],
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      toolsListData[index]["title"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xff333333),
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: toolsListData.length,
      ),
    );
  }
}
