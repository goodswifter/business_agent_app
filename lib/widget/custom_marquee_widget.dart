/*
   1、跑马灯效果

  上下滚动，左右滚动
*/

import 'package:flutter/material.dart';
import '../../utils/lxl_screen.dart';
import 'package:marquee/marquee.dart';

class CustomMarqueeWidget extends StatefulWidget {
  CustomMarqueeWidget({Key? key}) : super(key: key);

  @override
  _CustomMarqueeWidgetState createState() => _CustomMarqueeWidgetState();
}

class _CustomMarqueeWidgetState extends State<CustomMarqueeWidget> {
  List _dataList = ["您的消费券即将过期，请尽快使用"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      height: 30,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          // color: Color(0xffffffff),
          // color: Colors.cyan
          ),
      child: _buildComplexMarquee(),
      // child: ListView(
      //   // padding: EdgeInsets.only(top: 50.0),
      //   children: [
      //     _buildMarquee(),
      //     _buildComplexMarquee(),
      //   ].map(_wrapWithStuff).toList(),
      // ),
    );
  }

  Widget _buildComplexMarquee() {
    String currentStr = "";
    this._dataList.forEach((element) {
      currentStr += element;
      currentStr += "\r\t      ";
    });

    print("current string = ${currentStr}");

    return Marquee(
      // text: 'Some sample text that takes some space.',
      text: currentStr,
      style: TextStyle(
        color: Color(0xff222222),
        fontSize: 13,
        // fontWeight: FontWeight.bold
      ),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      // blankSpace: 20.0,
      // blankSpace: 5,
      velocity: 30, //100.0,
      pauseAfterRound: Duration(seconds: 1),
      showFadingOnlyWhenScrolling: true,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      // numberOfRounds:3,
      startPadding: 10.0,
      accelerationDuration: Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    );
  }

  Widget _buildMarquee() {
    return Marquee(
      text: 'There once was a boy who told this story about a boy: "',
    );
  }

  Widget _wrapWithStuff(Widget child) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(height: 50.0, color: Colors.white, child: child),
    );
  }
}
