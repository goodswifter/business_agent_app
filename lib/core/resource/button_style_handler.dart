///
/// Author       : zhongaidong
/// Date         : 2022-04-22 21:18:14
/// Description  : 按钮样式管理
///
import 'package:flutter/material.dart';

import 'color_handler.dart';

class ButtonStyleHandler {
  /// Button公共样式，默认点击效果
  static ButtonStyle getButtonStyle() {
    return ButtonStyle(
      overlayColor: MaterialStateProperty.all(ColorHandler.greyColor3),
      animationDuration: const Duration(milliseconds: 200),
      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      shape: MaterialStateProperty.all(const StadiumBorder()),
    );
  }

  /// Button公共样式，无点击效果
  static ButtonStyle getTransparentStyle() {
    return ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  /// Button公共样式，无圆角
  static ButtonStyle getNoShapeStyle() {
    return ButtonStyle(
      shadowColor: MaterialStateProperty.all(ColorHandler.shadowColor),
      animationDuration: const Duration(milliseconds: 200),
      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
    );
  }
}
