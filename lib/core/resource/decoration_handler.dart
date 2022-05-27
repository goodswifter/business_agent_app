///
/// Author       : zhongaidong
/// Date         : 2022-04-26 12:37:56
/// Description  :
///
import 'package:flutter/material.dart';

import 'color_handler.dart';

class DecorationHandler {
  /// 自定义圆角背景
  static BoxDecoration custom({
    Color color = Colors.transparent,
    double radius = 20,
    double border = 1,
    Color borderColor = Colors.black,
  }) {
    return BoxDecoration(
      color: color,
      border: Border.all(color: borderColor, width: border),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }

  static BoxDecoration shadow() {
    return custom(
      color: ColorHandler.shadowColor,
      borderColor: ColorHandler.shadowColor,
      radius: 30,
    );
  }

  /// 分割线
  static BoxDecoration divider() {
    return const BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.5, color: ColorHandler.shadowColor),
      ),
    );
  }
}
