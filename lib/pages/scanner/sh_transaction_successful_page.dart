import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:umpay_crossborder_app/pages/tabs/tab_page.dart';
import 'package:umpay_crossborder_app/widget/base_navi_appbar_widget.dart';

//商户交易成功

//交易状态
enum TradeType {
  /// 交易处理中
  waiting,

  /// 交易成功
  success,

  /// 交易失败
  failed,
}

class SHTransactionSuccessfulPage extends StatefulWidget {
  String? codeMessage;
  String? accountBalance;
  //交易类型
  TradeType tradeType;

  SHTransactionSuccessfulPage(
      {Key? key,
      this.codeMessage,
      required this.tradeType,
      this.accountBalance})
      : super(key: key);

  @override
  State<SHTransactionSuccessfulPage> createState() =>
      _SHTransactionSuccessfulPageState();
}

class _SHTransactionSuccessfulPageState
    extends State<SHTransactionSuccessfulPage> {
  late TradeType tradeType;
  late String codeMessage;
  late String accountBalance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.tradeType != null) {
      this.tradeType = widget.tradeType;
    }

    if (widget.codeMessage != null) {
      this.codeMessage = widget.codeMessage!;
    }

    if (widget.accountBalance != null) {
      this.accountBalance = widget.accountBalance!;
    }

    LogUtil.e("trade = ${this.tradeType}");
    LogUtil.e("code data = ${widget.codeMessage}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseViewBar(
        childView: BaseTitleBar(
          "",
          leftClick: () {
            Navigator.pop(context);
          },
        ),
        preferredSize: Size.fromHeight(50.0),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 87, 0, 0),
              child: this.tradeType == TradeType.waiting
                  ? Image.asset("images/sh_wait_image_1.png", fit: BoxFit.cover)
                  : (this.tradeType == TradeType.success
                      ? Image.asset("images/sh_successful_image_1.png",
                          fit: BoxFit.cover)
                      : Image.asset("images/sh_fail_closed_image_1.png",
                          fit: BoxFit.cover)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
              child: Text(
                // "交易成功",
                this.tradeType == TradeType.waiting
                    ? "交易处理中"
                    : (this.tradeType == TradeType.success ? "交易成功" : "交易失败"),
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(22.5, 15, 22.5, 0),
              child: Text(
                // "微信到账8888元",
                this.tradeType == TradeType.waiting
                    ? "请点击下发查询支付结果确认查询到交易成功后， 请顾客离开，如未成功请重新支付"
                    : (this.tradeType == TradeType.success
                        ? "${this.accountBalance}元"
                        : "交易金额超限，请联系业务员"),
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 46, 0, 0),
              child: this.tradeType == TradeType.waiting
                  ? _tradeWaitingBtnActionWidget() //交易处理中
                  : _confirmBtnActionWidget(), //确定
              // (this.tradeType == TradeType.success
              //     ? _confirmBtnActionWidget()
              //     : _confirmBtnActionWidget()),
            ),
          ],
        ),
      ),
    );
  }

  //确定按钮组件
  Widget _confirmBtnActionWidget() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // behavior: HitTestBehavior.translucent,
      child: Container(
        margin: EdgeInsets.fromLTRB(38, 0, 38, 0),
        height: 44,
        decoration: BoxDecoration(
          // color: Color.fromRGBO(255, 91, 93, 0.3), //Color(0xffFF5B5D),
          color: Color(0xffFF5B5D),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "确认",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
      onTap: () {
        //点击按钮的方法
        LogUtil.e("确定按钮点击。。。。。。");

        // 返回到根-进入首页
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => TabPage(indexPage: 0)),
            (route) => route == null);
      },
    );
  }

  //交易处理中，查询支付结果。。。
  Widget _tradeWaitingBtnActionWidget() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // behavior: HitTestBehavior.translucent,
      child: Container(
        margin: EdgeInsets.fromLTRB(38, 0, 38, 0),
        height: 44,
        decoration: BoxDecoration(
          // color: Color.fromRGBO(255, 91, 93, 0.3), //Color(0xffFF5B5D),
          color: Color(0xffFF5B5D),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "查询支付结果",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
      onTap: () {
        //点击按钮的方法
        LogUtil.e("查询交易结果。。。。。。");
      },
    );
  }
}
