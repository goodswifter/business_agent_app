///
/// Author       : zhongaidong
/// Date         : 2022-04-21 10:47:50
/// Description  : 阴影样式
///
import 'package:flutter/material.dart';

import 'color_handler.dart';

class ShadowHandler {
  /// 背景: 透明
  /// 阴影: 黑色
  /// 圆角: 40
  static black12Circle40() {
    return BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(40),
      boxShadow: const [
        BoxShadow(offset: Offset(2, 1), color: Colors.black12, blurRadius: 12)
      ],
    );
  }

  /// 背景: 白色
  /// 阴影: 黑色
  /// 圆角: [radius] default 10
  static white12Circle({double radius = 10}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          offset: const Offset(2, 1),
          color: ColorHandler.shadowColor,
          blurRadius: radius,
        )
      ],
    );
  }

  /// 背景: 白色
  /// 阴影: 黑色
  /// 圆角: [radius] default 10
  static white12CircleBorder(
    BorderRadius geometry, {
    double radius = 10,
  }) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: geometry,
      boxShadow: [
        BoxShadow(
            offset: const Offset(2, 1),
            color: ColorHandler.shadowColor,
            blurRadius: radius)
      ],
    );
  }

  /// 背景: 白色
  /// 阴影: 顶部阴影
  /// 圆角: [radius] default 10
  static white12TopSpread4Blur10({double radius = 10}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: const [
        BoxShadow(
          offset: Offset(-3.0, 3.0), // 阴影x轴偏移量
          blurRadius: 10, // 阴影模糊程度
          color: ColorHandler.shadowColor, // 阴影颜色
          spreadRadius: 4, // 阴影扩散程度
        ),
      ],
    );
  }
}
