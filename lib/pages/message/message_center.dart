/*
 * @Author: lixiao
 * @Date: 
 * @LastEditTime: 
 * @LastEditors: 
 * @Description: 消息中心
 * @FilePath: 
 */

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../pages/message/message_detail_page.dart';
import '../../utils/lxl_screen.dart';
import '../../utils/navigator_util.dart';
import '../../widget/base_navi_appbar_widget.dart';

enum MessageType {
  DIGITAL_RMB, //数字人民币
  ACTIVITY_COUPONS, //活动-消费券
}

class MessageCenterPage extends StatefulWidget {
  //是否展示返回按钮
  bool isVisibleBack;

  MessageCenterPage({Key? key, this.isVisibleBack = false}) : super(key: key);

  @override
  _MessageCenterPageState createState() => _MessageCenterPageState();
}

class _MessageCenterPageState extends State<MessageCenterPage> {
  RefreshController _refreshController = RefreshController();

  List _messageList = [];
  // List _messageList = [
  //   {
  //     "title": "数字人民币活动报名,数字人民币活动报名数字人民币活动报名数字人民币活动报名数字人民币活动报名数字人民币活动报名",
  //     "imageUrl": "message_digital_image1.png",
  //     "content": "您已经提交数字人民币试点活动申请，中签结果敬请期待！",
  //     "messageNum": "10",
  //     "type": "2", //数字人民币
  //     "time": "2021-07-29 08:49:35",
  //   },
  //   {
  //     "title": "北京消费券",
  //     "imageUrl": "message_coupons_image.png",
  //     "content": "您有优惠券即将过期，请抓紧使用哦~",
  //     "messageNum": "99",
  //     "type": "1", //消费券
  //     "time": "2021-08-29 08:48:38",
  //   },
  //   {
  //     "title": "北京消费券",
  //     // "imageUrl": "https://www.itying.com/images/flutter/1.png",
  //     "imageUrl": "message_receipt_account_image.png",
  //     "content": "您有一笔到账，收款金额￥0.01",
  //     "messageNum": "99",
  //     "type": "1", //消费券
  //     "time": "2021-08-29 08:48:38",
  //   },
  // ];
  bool _isVisibleBack = false;

  @override
  void initState() {
    super.initState();

    if (widget.isVisibleBack == true) {
      this._isVisibleBack = widget.isVisibleBack;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseViewBar(
        childView: BaseTitleBar(
          "消息中心",
          isBackHidden: true,
          leftClick: () {
            Navigator.pop(context);
          },
        ),
        preferredSize: Size.fromHeight(50.0),
      ),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Color(0xffff0044),
      //   leading: Visibility(
      //     visible: this._isVisibleBack,
      //     child: IconButton(
      //       icon: Image.asset(
      //         "images/navi_back_images.png",
      //         fit: BoxFit.cover,
      //       ),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
      //   title: Text(
      //     "消息中心",
      //     style: TextStyle(
      //       color: Color(0xff333333),
      //       fontSize: 18.0,
      //     ),
      //   ),
      // ),

      body: this._messageList != null && this._messageList.length > 0
          ? _messageListWidget() //有数据展示消息列表
          : _noDataWidget(), //暂无数据
    );
  }

  ///暂无数据的widget
  _noDataWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              "images/message_no_data_image.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Text(
              "暂时还没有消息哦~",
              style: TextStyle(color: Color(0xff333333), fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  ///展示消息列表
  Widget _messageListWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
        color: Color(0xfff5f5f5),
      ),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        // header: WaterDropHeader(),
        header: ClassicHeader(height: 80, refreshStyle: RefreshStyle.Follow),
        // footer: ClassicFooter(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          completeDuration: Duration(milliseconds: 500),
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      //点击每个item事件的方法
                      _didSelectedItemMethods(context, index);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      // height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
                                  height: 22,
                                  width: 22,
                                  // decoration: BoxDecoration(
                                  //   color: Colors.red,
                                  //   borderRadius: BorderRadius.circular(20),
                                  // ),
                                  child: CircleAvatar(
                                    radius: 15,
                                    // backgroundImage: NetworkImage(
                                    //   // "https://www.itying.com/images/flutter/1.png"
                                    //   "${this._messageList[index]["imageUrl"]}",
                                    // ),

                                    // child: Image.network(
                                    //   "https://www.itying.com/images/flutter/1.png",
                                    //   fit: BoxFit.cover,
                                    // ),
                                    backgroundImage: AssetImage(
                                        "images/${this._messageList[index]["imageUrl"]}"),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            // color: Colors.red,
                                            // padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                            margin: EdgeInsets.fromLTRB(
                                                10, 20, 10, 0),
                                            child: Text(
                                              // "数字人民币活动报名数字人民币名",
                                              "${this._messageList[index]["title"]}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        //小红点
                                        Visibility(
                                          visible: false,
                                          child: Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: Color(0xffFF5B5D),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 20, 0),
                                  child: Image.asset(
                                    "images/icon_right.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                            margin: EdgeInsets.fromLTRB(30, 20, 20, 0),
                            child: Text(
                              // "您已经提交数字人民币试点活动申请您已经提交数字人民币试点活动申请您已经提交数字人民币试点活动申请您已经提交数字人民币试点活动申请",
                              "${this._messageList[index]["content"]}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xff666666),
                                fontSize: 14.0,
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(30, 20, 20, 20),
                            child: Text(
                              // "${this._messageList[index]["time"]}",
                              _showDateTimeString(
                                  "${this._messageList[index]["time"]}"),
                              style: TextStyle(
                                color: Color(0xffB2B2B2),
                                fontSize: 13,
                              ),
                            ),
                          ),

                          //判断是否展示查看详情，活动消费券出现查看详情
                          // this._messageList[index]["type"] == "1"
                          //     ? _checkActivityDetailWidget()
                          //     : Container(),
                        ],
                      ),
                    ),
                  );
                },
                childCount: this._messageList.length, //10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 展示 查看详情 widget
  Widget _checkActivityDetailWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Stack(
        children: [
          Align(
            alignment: Alignment(1, 1),
            child: Container(
              // color: Colors.blue[500],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Text(
                      "查看详情",
                      style: TextStyle(
                        color: Colors.blue[500],
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Image.asset(
                      "images/icon_right.png",
                      fit: BoxFit.cover,
                      color: Colors.blue[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///日期显示
  ///根据判断今天展示 “07：19”，昨天展示情况 “2021-07-29 18：20”
  String _showDateTimeString(String dateString) {
    String currentStr = "";
    var _strtimes = DateTime.parse(dateString);
    var _milliseconds = _strtimes.millisecondsSinceEpoch;
    //  var str =  DateTime.fromMillisecondsSinceEpoch(_time);
    bool isToday = DateUtil.isToday(_milliseconds);
    // LogUtil.e("is today ${isToday}");
    if (isToday) {
      currentStr = DateUtil.formatDateStr(dateString, format: DateFormats.h_m);
    } else {
      // currentStr =
      //     DateUtil.formatDateStr(dateString, format: DateFormats.y_mo_d_h_m);
      currentStr =
          DateUtil.formatDateStr(dateString, format: "yyyy年M月d日 HH:mm");
    }

    return currentStr;
  }

  /// 点击消息列表的每个item的时间
  _didSelectedItemMethods(context, index) {
    LogUtil.e("${this._messageList[index]["title"]}");

    NavigatorUtil.push(
        context,
        MessageDetailPage(
          messageList: this._messageList,
          index: index,
        ));
  }

  _onRefresh() {
    print("onRefresh");
    Future.delayed(Duration(milliseconds: 1000)).then((_) {
      // items.add(Item(title: "Data"));

      if (mounted) setState(() {});
      _refreshController.refreshCompleted();
    });
  }

  _onLoading() {
    print("home onLoading");

    Future.delayed(Duration(milliseconds: 1000)).then((_) {
      _refreshController.loadComplete();
      if (mounted) setState(() {});
      // _refreshController.loadNoData();
    });
  }
}
