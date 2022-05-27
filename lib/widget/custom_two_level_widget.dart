import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TwoLevelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple,
        // image: DecorationImage(
        //     image: AssetImage("images/secondfloor.jpg"),
        //     // 很重要的属性,这会影响你打开二楼和关闭二楼的动画效果,关联到TwoLevelHeader,如果背景一致的情况,请设置相同
        //     alignment: Alignment.topCenter,
        //     fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Center(
            child: Wrap(
              children: [
                RaisedButton(
                  color: Colors.greenAccent,
                  onPressed: () {
                    SmartRefresher.of(context)!.controller.twoLevelComplete();
                  },
                  child: Text("登陆"),
                ),
              ],
            ),
          ),
          // Container(
          //   height: 60.0,
          //   child: GestureDetector(
          //     child: Icon(
          //       Icons.arrow_back_ios,
          //       color: Colors.white,
          //     ),
          //     onTap: () {
          //       SmartRefresher.of(context).controller.twoLevelComplete();
          //     },
          //   ),
          //   alignment: Alignment.bottomLeft,
          // ),
        ],
      ),
    );
  }
}
