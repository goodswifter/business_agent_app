///
/// Author       : zhongaidong
/// Date         : 2022-04-22 20:25:36
/// Description  : 分割线处理器
///
import 'package:flutter/material.dart';

import 'color_handler.dart';

class DividerHandler {
  /// 分割线 0.5 - 20边距
  static Widget divider1HalfPadding20 = const Divider(
    height: 0.5,
    thickness: 0.5,
    indent: 20,
    endIndent: 20,
    color: ColorHandler.shadowColor,
  );

  /// 分割线 0.5 - 无边距
  static Widget divider1Half = const Divider(
    height: 0.5,
    thickness: 0.5,
    color: ColorHandler.shadowColor,
  );

  /// 分割线 20 - 无边距
  static Widget divider20Half = const Divider(
    height: 20,
    thickness: 20,
    color: ColorHandler.whiteColor3,
  );

  static Widget divider1HalfPadding12 = const Divider(
    height: 0.5,
    indent: 12,
    endIndent: 6,
    color:  Color(0xffE9E9E9),
  );
}
