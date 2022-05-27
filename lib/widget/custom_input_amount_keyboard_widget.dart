

import 'dart:ffi';
import 'dart:ui';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import '../services/EventBus.dart';
import '../utils/lxl_easy_loading.dart';
import '../utils/lxl_screen.dart';

/*
 * 自定义金额输入键盘
 */

class CustomInputAmountKeyboardWidget extends StatefulWidget {
  late String data;

  CustomInputAmountKeyboardWidget({Key? key, required this.data}) : super(key: key);

  @override
  _CustomInputAmountKeyboardWidgetState createState() =>
      _CustomInputAmountKeyboardWidgetState();
}

class _CustomInputAmountKeyboardWidgetState
    extends State<CustomInputAmountKeyboardWidget> {
  List<String> _dataList = [];

  double widthItem = 60.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.data != "请输入金额") {
      List<String> d = widget.data.split("");
      this._dataList.addAll(d);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        return;
      },
      child: Container(
        width: LXLScreen.width,
        height: 300,
        color: Colors.grey[200],
        child: Container(
          child: Row(
            children: [
              Container(
                width: LXLScreen.width - 30 - (LXLScreen.width - 5 * 10) / 4,
                child: Column(
                  children: [
                    Container(
                      // height: 50 * 3,
                      // color: Colors.cyan,
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          _inputSubjectWidget(["1", "4", "7"]),
                          SizedBox(width: 10),
                          _inputSubjectWidget(["2", "5", "8"]),
                          SizedBox(width: 10),
                          _inputSubjectWidget(["3", "6", "9"]),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.brown,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                _didSelectedBtnAction("0");
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                // width: subWidth,
                                height: widthItem, //50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "0",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              _didSelectedBtnAction(".");
                            },
                            child: Container(
                              width: (LXLScreen.width - 5 * 10) / 4,
                              height: widthItem, //50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                ".",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: (LXLScreen.width - 5 * 10) / 4,
                  child: Column(
                    children: [
                      //删除
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          _didSelectedBtnAction("X");
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          // color: Colors.white,
                          child: Container(
                            // width: subWidth,
                            height: widthItem, //50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.center,
                            child: Image.asset("images/sh_account_money_image_delete.png", fit: BoxFit.cover,),
                            // child: Text(
                            //   "X",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     color: Color(0xff000000),
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          _didSelectedBtnAction("确定");
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          height: 200, //170,
                          // color: Colors.yellow,
                          child: Container(
                            // width: subWidth,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffFF5B5D),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "收款",
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xffffffff),
                                
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
      ),
    );
  }

  _inputSubjectWidget(var arr) {
    // var subWidth = 100.0;
    return Expanded(
      flex: 1,
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 10),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _didSelectedBtnAction(arr[0]);
              },
              child: Container(
                // width: subWidth,
                height: widthItem, // 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  "${arr[0]}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _didSelectedBtnAction(arr[1]);
              },
              child: Container(
                // width: subWidth,
                height: widthItem, //50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  "${arr[1]}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _didSelectedBtnAction(arr[2]);
              },
              child: Container(
                // width: subWidth,
                height: widthItem, //50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  "${arr[2]}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  ///点击键盘按钮的事件
  _didSelectedBtnAction(String data) {
    print("点击键盘 -- 数据 --- data = ${data}");

    bool isConfirm = false;
    switch (data) {
      case "X":
        {
          if (this._dataList != null && this._dataList.length > 0) {
            this._dataList.removeLast();
          } else {
            // data = "请输入金额";
            // this._dataList.add(data);
          }
        }
        break;
      case ".":
        {
          if (this._dataList != null && this._dataList.length > 0) {
            bool isExist = this._dataList.contains(".");
            if (isExist == true) {
              print("已存在小数点，不能多添加");
              return;
            }
            this._dataList.add(data);
          } else {
            this._dataList.add("0");
            this._dataList.add(".");
          }
        }
        break;
      case "确定":
        {
          isConfirm = true;
        }
        break;
      default:
        {
          //判断条件为：不能以0开头的整数。。。
          if (this._dataList != null &&
              this._dataList.length > 0 &&
              this._dataList.first == "0" &&
              !this._dataList.contains(".")) {
            LXLEasyLoading.showToast("请正确输入金额");
            return;
          }

          this._dataList.add(data);
        }
        break;
    }

    String dataStr = getTaskScreen(this._dataList);
    print("data string --> ${dataStr}");

   //金额的处理 整数部分的处理，小数部分的处理
    String amountString = this._dealNumberAmount(dataStr);

    //发送点击键盘的数据
    eventBus.fire(SetAmountNotificatonEvent(amountString, isConfirm));
  }

  //进行数据处理 fix 解决数字金额不正确的问题
  String _dealNumberAmount(String dataStr) {
    String currentData = "";
    bool isPoint = dataStr.contains(".");
    if (isPoint == true) {
      List currentD = dataStr.split(".");
      String str1 = currentD[0];
      if (str1.length > 10) {
        str1 = str1.substring(0, 10);
      }

      String str2 = currentD[1];
      String str3 = "";
      if (str2.length > 2) {
        str3 = str2.substring(0, 2);
      } else {
        str3 = str2;
      }

      String str4 = str1 + "." + str3;
      currentData = str4;

      List<String> datas = str4.split("");
      this._dataList.clear();
      this._dataList = datas;
    } else {
      if (dataStr.length > 10) {
        dataStr = dataStr.substring(0, 10);
      }
      List<String> datas = dataStr.split("");
      this._dataList.clear();
      this._dataList = datas;

      currentData = dataStr;
    }

    return currentData;
  }

  ///数组转字符串
  String getTaskScreen(List list) {
    List tempList = [];
    String str = '';
    // list.forEach((f) {
    //   tempList.add(f.title);
    // });

    list.forEach((f) {
      if (str == '') {
        str = "$f";
      } else {
        str = "$str" "$f";
      }
    });

    return str;
  }
}
