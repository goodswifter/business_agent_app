import 'package:flutter/material.dart';

/*
 * 自定义 alert dialog
 */

//默认alert回调
typedef AlertConfirmCallBack = void Function(int value);
//企事业商户信息点击回调（普通企业-1，事业单位-2，其他组织-3）
typedef EnterpriseAlertCallBack = void Function(int value);

//自定义商户提示信息子组件widget
_customSubMerchantAlertWidget(String content) {
  return Container(
    margin: const EdgeInsets.fromLTRB(56, 20, 0, 0),
    child: Text(
      content,
      style: const TextStyle(
        color: Color(0xff333333),
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

//自定义企事业商户的子组件widget
_customEnterpriseWidget(String content) {
  return Container(
    height: 25,
    // width: LXLScreen.width,
    margin: const EdgeInsets.fromLTRB(40, 20, 40, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          // "普通事业",
          content,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xff333333),
            fontWeight: FontWeight.w500,
          ),
        ),
        Image.asset(
          // "images/icon_right.png",
          "images/sh_app_more_right_1.png",
          fit: BoxFit.cover,
        ),
      ],
    ),
  );
}

///默认自定义alert
class LXLAlertCustomDialog {
  //默认自定义alert弹框提示信息
  static showAlertDialog(context, String title, String message,
      AlertConfirmCallBack confirmCallBack) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: const Color.fromRGBO(0, 0, 0, 0.3), //Colors.black12,
          child: GestureDetector(
            //解决showModalBottomSheet点击消失的问题
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print("123");
              // Navigator.of(context).pop();
              // FocusScope.of(context).requestFocus(FocusNode());
              return;
            },
            child: SimpleDialog(
              contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              title: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              children: [
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  // decoration: BoxDecoration(
                  //   // color: Color(0xfff5f5f5),
                  //   borderRadius: BorderRadius.circular(5),
                  //   border: Border.all(
                  //     width: 1,
                  //     color: Color(0xffcccccc),
                  //   ),
                  // ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          //  maxLines: 0,
                          style: const TextStyle(
                            color: Color(0xff666666),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  color: const Color(0xffeeeeee),
                  height: 1,
                ),
                const SizedBox(height: 5),
                SimpleDialogOption(
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: SimpleDialogOption(
                          padding: EdgeInsets.zero,
                          child: const Center(
                            child: Text(
                              '取消',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(
                                    0xff666666), // Color(0xff00be7e), //19ba6c
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            //回调事件
                            confirmCallBack(0);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        color: const Color(0xffeeeeee),
                        width: 1,
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: SimpleDialogOption(
                          padding: EdgeInsets.zero,
                          child: const Center(
                            child: Text(
                              '确定',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffFF5B5D),
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          onPressed: () {
                            print("----alert  确定点击了-------");
                            Navigator.of(context).pop();
                            //回调事件
                            confirmCallBack(1);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 展示小微商户alert
  static showMerchantAlertDialog(context, String title, String message,
      AlertConfirmCallBack confirmCallBack) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: const Color.fromRGBO(0, 0, 0, 0.3), //Colors.black12,
          child: GestureDetector(
            //解决showModalBottomSheet点击消失的问题
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print("123");
              return;
            },
            child: SimpleDialog(
              contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
              title: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      alignment: Alignment.center,
                      child: Text(
                        // "以下资料是否已收集",
                        message,
                        style: const TextStyle(
                          color: Color(0xff666666),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    _customSubMerchantAlertWidget("1.三张门头照"),
                    _customSubMerchantAlertWidget("2.法人身份证正反面"),
                    _customSubMerchantAlertWidget("3.结算卡（带卡号）"),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  color: const Color(0xffeeeeee),
                  height: 1,
                ),
                const SizedBox(height: 5),
                SimpleDialogOption(
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: SimpleDialogOption(
                          padding: EdgeInsets.zero,
                          child: const Center(
                            child: Text(
                              '取消',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(
                                    0xff222222), // Color(0xff00be7e), //19ba6c
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          onPressed: () {
                            //回调事件
                            confirmCallBack(0);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        color: const Color(0xffeeeeee),
                        width: 1,
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: SimpleDialogOption(
                          padding: EdgeInsets.zero,
                          child: const Center(
                            child: Text(
                              '确定',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffFF5B5D),
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          onPressed: () {
                            print("----alert  确定点击了-------");

                            //回调事件
                            confirmCallBack(1);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  ///展示个体户alert
  static showSelfEmployedAlertDialog(context, String title, String message,
      AlertConfirmCallBack confirmCallBack) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: const Color.fromRGBO(0, 0, 0, 0.3), //Colors.black12,
          child: GestureDetector(
            //解决showModalBottomSheet点击消失的问题
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print("123");
              // Navigator.of(context).pop();
              // FocusScope.of(context).requestFocus(FocusNode());
              return;
            },
            child: SimpleDialog(
              contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
              title: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      alignment: Alignment.center,
                      child: const Text(
                        "以下资料是否已收集",
                        // "${message}",
                        style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    _customSubMerchantAlertWidget("1、三张门头照"),
                    _customSubMerchantAlertWidget("2、营业执照"),
                    _customSubMerchantAlertWidget("3、法人身份证正反面"),
                    _customSubMerchantAlertWidget("4、结算卡(带卡号)/开户许可证"),
                    _customSubMerchantAlertWidget("5、结算人身份证正反面&非法人结算授权函"),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  color: const Color(0xffeeeeee),
                  height: 1,
                ),
                const SizedBox(height: 5),
                SimpleDialogOption(
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: SimpleDialogOption(
                          padding: EdgeInsets.zero,
                          child: const Center(
                            child: Text(
                              '取消',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff222222),
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          onPressed: () {
                            //回调事件
                            confirmCallBack(0);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        color: const Color(0xffeeeeee),
                        width: 1,
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: SimpleDialogOption(
                          padding: EdgeInsets.zero,
                          child: const Center(
                            child: Text(
                              '确定',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffFF5B5D),
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          onPressed: () {
                            print("----alert  确定点击了-------");

                            // 回调事件
                            confirmCallBack(1);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  ///企事业alert dialog
  static showEnterpriseAlertDialog(
      context,
      String title,
      String message,
      AlertConfirmCallBack confirmCallBack,
      EnterpriseAlertCallBack enterpriseCallBack) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: const Color.fromRGBO(0, 0, 0, 0.3), //Colors.black12,
          child: GestureDetector(
            //解决showModalBottomSheet点击消失的问题
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print("123");
              // Navigator.of(context).pop();
              // FocusScope.of(context).requestFocus(FocusNode());
              return;
            },
            child: SimpleDialog(
              contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
              title: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      alignment: Alignment.center,
                      child: const Text(
                        "以下资料是否已收集",
                        // "${message}",
                        style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.of(context).pop();
                        enterpriseCallBack(1);
                      },
                      child: _customEnterpriseWidget("普通企业"),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.of(context).pop();
                        enterpriseCallBack(2);
                      },
                      child: _customEnterpriseWidget("事业单位"),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.of(context).pop();
                        enterpriseCallBack(3);
                      },
                      child: _customEnterpriseWidget("其他组织"),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // Container(
                //   color: Color(0xffeeeeee),
                //   height: 1,
                // ),
                // SizedBox(height: 5),
                // SimpleDialogOption(
                //   // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                //   child: Container(
                //     // color: Colors.red,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Container(
                //           width: 120,
                //           height: 40,
                //           // decoration: BoxDecoration(
                //           //   // color: Color(0xff00be7e),
                //           //   borderRadius: BorderRadius.circular(25),
                //           //   border: Border.all(
                //           //     width: 1,
                //           //     color: Color(0xff00be7e),
                //           //   ),
                //           // ),
                //           child: SimpleDialogOption(
                //             child: Center(
                //               child: Text(
                //                 '取消',
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                   color: Color(
                //                       0xff222222), // Color(0xff00be7e), //19ba6c
                //                   fontSize: 18.0,
                //                   fontWeight: FontWeight.normal,
                //                 ),
                //               ),
                //             ),
                //             onPressed: () {
                //               //回调事件
                //               confirmCallBack(0);
                //               Navigator.of(context).pop();
                //             },
                //           ),
                //         ),
                //         SizedBox(
                //           width: 12,
                //         ),
                //         Container(
                //           color: Color(0xffeeeeee),
                //           width: 1,
                //           height: 40,
                //         ),
                //         SizedBox(width: 12),
                //         Container(
                //           width: 120,
                //           height: 40,
                //           // decoration: BoxDecoration(
                //           //   color: Color(0xff00be7e),
                //           //   borderRadius: BorderRadius.circular(25),
                //           // ),
                //           child: SimpleDialogOption(
                //             child: Center(
                //               child: Text(
                //                 '确定',
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                   color: Color(0xffFF5B5D),
                //                   fontSize: 18.0,
                //                   fontWeight: FontWeight.normal,
                //                 ),
                //               ),
                //             ),
                //             onPressed: () {
                //               print("----alert  确定点击了-------");

                //               //回调事件
                //               confirmCallBack(1);
                //               Navigator.of(context).pop();
                //             },
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  //enterprise alert prompt info
  static alertEnterprisePromptInfoDialog(
    context,
    String title,
    String message,
    int selectedIndex,
    AlertConfirmCallBack confirmCallBack,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: const Color.fromRGBO(0, 0, 0, 0.3), //Colors.black12,
          child: GestureDetector(
            //解决showModalBottomSheet点击消失的问题
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print("123");
              return;
            },
            child: SimpleDialog(
              contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
              title: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              children: [
                // SizedBox(height: 10),
                //普通企业
                Visibility(
                  visible: selectedIndex == 1 ? true : false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        alignment: Alignment.center,
                        child: const Text(
                          "以下资料是否已收集",
                          // "${message}",
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      _customSubMerchantAlertWidget("1、三张门头照"),
                      _customSubMerchantAlertWidget("2、法人身份证正反面"),
                      _customSubMerchantAlertWidget("3、结算卡（带卡号）开户许可证"),
                      _customSubMerchantAlertWidget("4、结算人身份证正反面&非法人结算授权函"),
                      _customSubMerchantAlertWidget("5、营业执照"),
                      _customSubMerchantAlertWidget("6、经营许可证"),
                    ],
                  ),
                ),
                //企事业
                Visibility(
                  visible: selectedIndex == 2 ? true : false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        alignment: Alignment.center,
                        child: const Text(
                          "以下资料是否已收集",
                          // "${message}",
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      _customSubMerchantAlertWidget("1、三张门头照"),
                      _customSubMerchantAlertWidget("2、法人身份证正反面"),
                      _customSubMerchantAlertWidget("3、结算卡(带卡号)开户许可证"),
                      _customSubMerchantAlertWidget("4、结算人身份证正反面&非法人结算授权函"),
                      _customSubMerchantAlertWidget("5、事业单位法人证书"),
                      _customSubMerchantAlertWidget("6、经营许可证"),
                      _customSubMerchantAlertWidget("7、单位证明函照片"),
                    ],
                  ),
                ),
                //其他组织
                Visibility(
                  visible: selectedIndex == 3 ? true : false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        alignment: Alignment.center,
                        child: const Text(
                          "以下资料是否已收集",
                          // "${message}",
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      _customSubMerchantAlertWidget("1、三张门头照"),
                      _customSubMerchantAlertWidget("2、法人身份证正反面"),
                      _customSubMerchantAlertWidget("3、结算卡(带卡号)开户许可证"),
                      _customSubMerchantAlertWidget("4、结算人身份证正反面&非法人结算授权函"),
                      _customSubMerchantAlertWidget("5、登记证书"),
                      _customSubMerchantAlertWidget("6、经营许可证"),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  color: const Color(0xffeeeeee),
                  height: 1,
                ),
                const SizedBox(height: 5),
                SimpleDialogOption(
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: SimpleDialogOption(
                          padding: EdgeInsets.zero,
                          child: const Center(
                            child: Text(
                              '取消',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(
                                    0xff222222), // Color(0xff00be7e), //19ba6c
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          onPressed: () {
                            //回调事件
                            confirmCallBack(0);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        color: const Color(0xffeeeeee),
                        width: 1,
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: SimpleDialogOption(
                          padding: EdgeInsets.zero,
                          child: const Center(
                            child: Text(
                              '确定',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffFF5B5D),
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          onPressed: () {
                            print("----alert  确定点击了-------");

                            //回调事件
                            confirmCallBack(1);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
