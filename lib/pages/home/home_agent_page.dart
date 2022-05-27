import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:umpay_crossborder_app/core/config/lxl_key_define.dart';
import 'package:umpay_crossborder_app/model/agent_data_info_model.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/add_merchant_page.dart';
import 'package:umpay_crossborder_app/utils/lxl_screen.dart';
import 'package:umpay_crossborder_app/utils/navigator_util.dart';
import 'package:umpay_crossborder_app/widget/sliver_home_header_widget.dart';

class HomeAgentPage extends StatefulWidget {
  const HomeAgentPage({Key? key}) : super(key: key);

  @override
  State<HomeAgentPage> createState() => _HomeAgentPageState();
}

class _HomeAgentPageState extends State<HomeAgentPage> {
  // List listData = [
  //   {
  //     "title": '新增商户',
  //     "imageUrl": 'images/sh_app_agent_add_merchant.png',
  //   },
  //   {
  //     "title": '草稿箱',
  //     "imageUrl": 'images/sh_app_draft_box.png',
  //   },
  //   {
  //     "title": '帮助中心',
  //     "imageUrl": 'images/sh_app_adent_help_center.png',
  //   },
  //   {
  //     "title": '更多',
  //     "imageUrl": 'images/sh_app_adent_image_more.png',
  //   },
  // ];
  bool _isEyeOpen = false;
  final RefreshController _refreshController = RefreshController();
  String agentName = "";

  @override
  void initState() {
    super.initState();

    //登录获取代理商数据
    AgentDataInfoModel? agentDataInfoModel = SpUtil.getObj(
        LXLKeyDefine.agentUserDataInfoKey,
        (v) => AgentDataInfoModel.fromJson(v as Map<String, dynamic>));
    if (agentDataInfoModel != null) {
      LogUtil.e("--登陆成功info---${agentDataInfoModel.agentName}");
      if (agentDataInfoModel.agentName != null &&
          agentDataInfoModel.agentName!.length > 0) {
        this.agentName = agentDataInfoModel.agentName!;
      }
    }
  }

  _onRefresh() {
    print("onRefresh");
    Future.delayed(const Duration(milliseconds: 1000)).then((_) {
      // items.add(Item(title: "Data"));

      if (mounted) setState(() {});
      _refreshController.refreshCompleted();
    });
  }

  _onLoading() {
    print("home onLoading");

    Future.delayed(const Duration(milliseconds: 1000)).then((_) {
      _refreshController.loadComplete();
      if (mounted) setState(() {});
      // _refreshController.loadNoData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffFAFAFA),
      child: SmartRefresher(
        //控制能否下拉
        enablePullDown: false,
        // enablePullUp: true,
        // header: WaterDropHeader(),
        header:
            const ClassicHeader(height: 80, refreshStyle: RefreshStyle.Follow),
        // footer: ClassicFooter(),
        // footer: ClassicFooter(
        //   loadStyle: LoadStyle.ShowWhenLoading,
        //   completeDuration: Duration(milliseconds: 500),
        // ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: CustomScrollView(
          slivers: [
            //自定义滑动头部
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: SliverHomeCustomHeaderDelegate(
                naviTitle: this.agentName,
                collapsedHeight: 64,
                expandedHeight: 400 + 20, //280,
                paddingTop: LXLScreen.topSafeHeight, //10
                //点击工具栏的时间
                didToolsAction: (context, index) {
                  LogUtil.e("点击了工具栏 的选项 ：${index}");

                  _dealDidToolsAction(context, index);
                },
                didHeaderMessageBellAction: () {
                  //点击"+"弹框的方法
                  // _showMenuWidget();
                  LogUtil.e("点击了header  message bell");
                },
              ),
            ),

            // SliverAppBar(
            //   backgroundColor: Color(0xffCC2929),
            //   //缩放到最小时是否需要悬停到顶部
            //   pinned: true,
            //   // 想下滚动显示 向上 跟随影藏
            //   floating: true,
            //   elevation: 0.0,
            //   //自定义title
            //   title: Container(
            //     child: Text(
            //       "服务商名称",
            //       style: TextStyle(
            //         fontSize: 18,
            //         color: Color(0xffffffff),
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ),
            //   actions: [
            //     IconButton(
            //       icon: Image.asset(
            //         "images/sh_app_agent_message_1.png",
            //         fit: BoxFit.cover,
            //         // color: Colors.white,
            //       ),
            //       onPressed: () {
            //         // Navigator.pop(context);
            //       },
            //     ),
            //   ],
            // ),

            //交易信息widget
            // _tradingInformationWidget(),
            //工具类
            // _toolsItemWidget(),
            //服务商账户
            _serviceProviderAccountWidget(),
            //本月交易
            _tradeOfTheMonthWithWidget(),
            //本月商户
            _merchantOftheMonthWidget(),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   body: Container(
    //     child: CustomScrollView(
    //       slivers: [
    //         //自定义滑动头部
    //         SliverPersistentHeader(
    //           pinned: true,
    //           delegate: SliverHomeCustomHeaderDelegate(
    //             collapsedHeight: 64,
    //             expandedHeight: 400+20, //280,
    //             paddingTop: LXLScreen.topSafeHeight, //10
    //             //点击工具栏的时间
    //             didToolsAction: (context, index) {
    //               LogUtil.e("点击了工具栏 的选项 ：${index}");

    //               _dealDidToolsAction(context, index);
    //             },
    //             didHeaderMessageBellAction: () {
    //               //点击"+"弹框的方法
    //               // _showMenuWidget();
    //               LogUtil.e("点击了header  message bell");
    //             },
    //           ),
    //         ),

    //         // SliverAppBar(
    //         //   backgroundColor: Color(0xffCC2929),
    //         //   //缩放到最小时是否需要悬停到顶部
    //         //   pinned: true,
    //         //   // 想下滚动显示 向上 跟随影藏
    //         //   floating: true,
    //         //   elevation: 0.0,
    //         //   //自定义title
    //         //   title: Container(
    //         //     child: Text(
    //         //       "服务商名称",
    //         //       style: TextStyle(
    //         //         fontSize: 18,
    //         //         color: Color(0xffffffff),
    //         //         fontWeight: FontWeight.w500,
    //         //       ),
    //         //     ),
    //         //   ),
    //         //   actions: [
    //         //     IconButton(
    //         //       icon: Image.asset(
    //         //         "images/sh_app_agent_message_1.png",
    //         //         fit: BoxFit.cover,
    //         //         // color: Colors.white,
    //         //       ),
    //         //       onPressed: () {
    //         //         // Navigator.pop(context);
    //         //       },
    //         //     ),
    //         //   ],
    //         // ),

    //         //交易信息widget
    //         // _tradingInformationWidget(),
    //         //工具类
    //         // _toolsItemWidget(),
    //         //服务商账户
    //         _serviceProviderAccountWidget(),
    //         //本月交易
    //         _tradeOfTheMonthWithWidget(),
    //         //本月商户
    //         _merchantOftheMonthWidget(),
    //       ],
    //     ),
    //   ),
    // );
  }

  //交易信息widget
  // _tradingInformationWidget() {
  //   return SliverToBoxAdapter(
  //     child: Container(
  //       color: Color(0xffCC2929),
  //       // decoration: BoxDecoration(
  //       //   // color: Color(0xCC2929),
  //       //   gradient: LinearGradient(
  //       //       begin: Alignment.topCenter,
  //       //       end: Alignment.bottomCenter,
  //       //       colors: [
  //       //         Color(0xCC2929),
  //       //         Color(0xffF13E3E),
  //       //       ]),
  //       // ),
  //       child: Stack(
  //         children: [
  //           Container(
  //             child: Column(
  //               children: [
  //                 Opacity(
  //                   opacity: 0.8,
  //                   child: Container(
  //                     margin: EdgeInsets.fromLTRB(0, 28, 0, 0),
  //                     child: Text(
  //                       "今日交易额（元）",
  //                       style: TextStyle(
  //                         fontSize: 13,
  //                         color: Color(0xffffffff),
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
  //                   child: Text(
  //                     "10000",
  //                     style: TextStyle(
  //                       fontSize: 30,
  //                       color: Color(0xffffffff),
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.fromLTRB(0, 36, 0, 0),
  //                   child: Row(
  //                     children: [
  //                       Expanded(
  //                         child: Container(
  //                           child: Column(
  //                             children: [
  //                               Opacity(
  //                                 opacity: 0.8,
  //                                 child: Container(
  //                                   child: Text(
  //                                     "新增商户数",
  //                                     style: TextStyle(
  //                                       fontSize: 13,
  //                                       color: Color(0xffffffff),
  //                                       fontWeight: FontWeight.w400,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                               Container(
  //                                 margin: EdgeInsets.fromLTRB(0, 5, 0, 23),
  //                                 child: Text(
  //                                   "390",
  //                                   style: TextStyle(
  //                                     fontSize: 16,
  //                                     color: Color(0xffffffff),
  //                                     fontWeight: FontWeight.w500,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       Expanded(
  //                         child: Container(
  //                           child: Column(
  //                             children: [
  //                               Opacity(
  //                                 opacity: 0.8,
  //                                 child: Container(
  //                                   child: Text(
  //                                     "交易笔数",
  //                                     style: TextStyle(
  //                                       fontSize: 13,
  //                                       color: Color(0xffffffff),
  //                                       fontWeight: FontWeight.w400,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                               Container(
  //                                 margin: EdgeInsets.fromLTRB(0, 5, 0, 23),
  //                                 child: Text(
  //                                   "2000",
  //                                   style: TextStyle(
  //                                     fontSize: 16,
  //                                     color: Color(0xffffffff),
  //                                     fontWeight: FontWeight.w500,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Align(
  //             alignment: Alignment.centerRight,
  //             child: Container(
  //               margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
  //               width: 76,
  //               height: 28,
  //               decoration: BoxDecoration(
  //                 // color: Color(0xffC52222),
  //                 color: Color.fromRGBO(197, 34, 34, 0.5),
  //                 borderRadius:
  //                     BorderRadius.horizontal(left: Radius.circular(16)),
  //               ),
  //               child: Container(
  //                 alignment: Alignment.center,
  //                 child: Text(
  //                   "昨日数据",
  //                   style: TextStyle(
  //                     color: Color(0xffeeeeee),
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.w400,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  //工具栏 --- 根据后台可配置
  // _toolsItemWidget() {
  //   return
  //       //  SliverPadding(
  //       //   padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
  //       //   // padding: const EdgeInsets.all(10.0),
  //       //   sliver:
  //       SliverGrid(
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 4, //Grid按两列显示
  //       // mainAxisSpacing: 10.0,
  //       // crossAxisSpacing: 10.0,
  //       // childAspectRatio: 4.0,
  //     ),
  //     delegate: SliverChildBuilderDelegate(
  //       (BuildContext context, int index) {
  //         //创建子widget
  //         return GestureDetector(
  //           behavior: HitTestBehavior.opaque,
  //           onTap: () {
  //             // _didSelectedActivityItem(context, index);
  //           },
  //           child: Container(
  //             height: 100,
  //             alignment: Alignment.center,
  //             // color: Colors.white,
  //             color: Color(0xfffafafa),
  //             // color: Colors.cyan[100 * (index % 9)],
  //             // child: Text('grid item $index'),
  //             child: Container(
  //               width: 90,
  //               height: 90,
  //               alignment: Alignment.center,
  //               margin: EdgeInsets.all(5),
  //               padding: EdgeInsets.only(top: 5),
  //               // color: Colors.white,
  //               color: Color(0xfffafafa),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 // crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Container(
  //                     width: 28,
  //                     height: 28,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(20),
  //                     ),
  //                     child: Image.asset(
  //                       listData[index]["imageUrl"],
  //                       fit: BoxFit.cover,
  //                     ),
  //                     // child: Image.network(
  //                     //   listData[index]["imageUrl"],
  //                     //   fit: BoxFit.cover,
  //                     // ),
  //                   ),
  //                   const SizedBox(height: 10),
  //                   Text(
  //                     listData[index]["title"],
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: const TextStyle(
  //                       color: Color(0xff333333),
  //                       fontSize: 13.0,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //       childCount: listData.length,
  //     ),
  //   );
  //   // );
  // }

  //服务商账号widget
  _serviceProviderAccountWidget() {
    return SliverToBoxAdapter(
      child: Container(
        height: 135,
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: Row(
                children: [
                  Container(
                    child: const Text("服务商账户"),
                  ),
                  const SizedBox(width: 7.5),
                  InkWell(
                    child: Container(
                      // color: Colors.red,
                      child: Image.asset(
                        // "images/sh_app_adent_home_eye_close.png",
                        this._isEyeOpen == false
                            ? "images/sh_app_adent_home_eye_close.png"
                            : "images/sh_app_adent_home_eye_open.png",
                        // fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      print("点击小眼睛了。。。。");
                      setState(() {
                        this._isEyeOpen = !this._isEyeOpen;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 96,
                      // color: Colors.cyan,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              // "9999.99",
                              this._isEyeOpen == false ? "***" : "999.99",
                              style: const TextStyle(
                                fontSize: 15,
                                color: const Color(0xff333333),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: const Text(
                              "分润余额（元）",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xff999999),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 96,
                      // color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              // "9999.99",
                              this._isEyeOpen == false ? "***" : "999.99",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: const Text(
                              "冻结余额（元）",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xff999999),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 96,
                      // color: Colors.purple,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              // "9999.99",
                              this._isEyeOpen == false ? "***" : "999.99",
                              style: const TextStyle(
                                fontSize: 15,
                                color: const Color(0xff333333),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: const Text(
                              "补贴余额（元）",
                              style: const TextStyle(
                                fontSize: 13,
                                color: const Color(0xff999999),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //本月交易
  _tradeOfTheMonthWithWidget() {
    return SliverToBoxAdapter(
      child: Container(
        height: 135,
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: Row(
                children: [
                  Container(
                    child: const Text("本月交易"),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 96,
                      // color: Colors.cyan,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: const Text(
                              "9999.99",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: const Text(
                              "交易笔数（笔）",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xff999999),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 96,
                      // color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: const Text(
                              "9999.99",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: const Text(
                              "交易金额（元）",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff999999),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 96,
                      // color: Colors.purple,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: const Text(
                              "9999.99",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: const Text(
                              "分润（元）",
                              style: const TextStyle(
                                fontSize: 13,
                                color: const Color(0xff999999),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //本月商户
  _merchantOftheMonthWidget() {
    return SliverToBoxAdapter(
      child: Container(
        height: 135,
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: Row(
                children: [
                  Container(
                    child: const Text("本月商户"),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 96,
                      // color: Colors.cyan,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: const Text(
                              "9999.99",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: const Text(
                              "新增商户数",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff999999),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 96,
                      // color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: const Text(
                              "9999.99",
                              style: const TextStyle(
                                fontSize: 15,
                                color: const Color(0xff333333),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: const Text(
                              "交易商户数",
                              style: const TextStyle(
                                fontSize: 14,
                                color: const Color(0xff999999),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///处理点击工具栏的时间
  _dealDidToolsAction(context, index) {
    switch (index) {
      case 0: //新增商户
        //跳转新增商户界面
        NavigatorUtil.push(context, const AddMerchantPage());

        break;
      case 1: //草稿箱
        break;
      case 2: //帮助中心
        break;
      case 3: //更多
        break;
      default:
    }
  }
}
