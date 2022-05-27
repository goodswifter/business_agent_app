///
/// Author       : zhongaidong
/// Date         : 2022-05-27 13:14:57
/// Description  :
///
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // 缩放到最小时是否需要悬停到顶部
      pinned: true,
      // 想下滚动显示 向上 跟随影藏
      floating: true,
      elevation: 0.0,
      leading: IconButton(
        icon: Image.asset(
          "images/navi_back_images.png",
          fit: BoxFit.cover,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      // 自定义title
      title: const Text(
        "商户基本信息",
        style: TextStyle(
          fontSize: 18,
          color: Color(0xff333333),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
