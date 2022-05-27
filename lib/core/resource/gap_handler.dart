/// 
/// Author       : zhongaidong
/// Date         : 2022-04-22 14:44:52
/// Description  : 间隔管理
/// 
import 'package:flutter/material.dart';

import 'dimen_handler.dart';

/// 间隔
/// 官方做法：https://github.com/flutter/flutter/pull/54394
class GapHandler {
  /// 水平间隔
  static const Widget hGap3 = SizedBox(width: DimenHandler.gapDp3);
  static const Widget hGap4 = SizedBox(width: DimenHandler.gapDp4);
  static const Widget hGap5 = SizedBox(width: DimenHandler.gapDp5);
  static const Widget hGap6 = SizedBox(width: DimenHandler.gapDp6);
  static const Widget hGap8 = SizedBox(width: DimenHandler.gapDp8);
  static const Widget hGap10 = SizedBox(width: DimenHandler.gapDp10);
  static const Widget hGap12 = SizedBox(width: DimenHandler.gapDp12);
  static const Widget hGap15 = SizedBox(width: DimenHandler.gapDp15);
  static const Widget hGap16 = SizedBox(width: DimenHandler.gapDp16);
  static const Widget hGap20 = SizedBox(width: DimenHandler.gapDp20);
  static const Widget hGap32 = SizedBox(width: DimenHandler.gapDp32);

  /// 垂直间隔
  static const Widget vGap3 = SizedBox(height: DimenHandler.gapDp3);
  static const Widget vGap4 = SizedBox(height: DimenHandler.gapDp4);
  static const Widget vGap5 = SizedBox(height: DimenHandler.gapDp5);
  static const Widget vGap8 = SizedBox(height: DimenHandler.gapDp8);
  static const Widget vGap10 = SizedBox(height: DimenHandler.gapDp10);
  static const Widget vGap12 = SizedBox(height: DimenHandler.gapDp12);
  static const Widget vGap15 = SizedBox(height: DimenHandler.gapDp15);
  static const Widget vGap16 = SizedBox(height: DimenHandler.gapDp16);
  static const Widget vGap20 = SizedBox(height: DimenHandler.gapDp20);
  static const Widget vGap24 = SizedBox(height: DimenHandler.gapDp24);
  static const Widget vGap30 = SizedBox(height: DimenHandler.gapDp30);
  static const Widget vGap32 = SizedBox(height: DimenHandler.gapDp32);
  static const Widget vGap50 = SizedBox(height: DimenHandler.gapDp50);

  static Widget line = const SizedBox(
    height: 0.3,
    width: double.infinity,
    child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
  );

  // static const Widget line = Divider();

  static const Widget vLine = SizedBox(
    width: 0.6,
    height: 24.0,
    child: VerticalDivider(),
  );

  static const Widget empty = SizedBox.shrink();

  /// 补充一种空Widget实现 https://github.com/letsar/nil
  /// https://github.com/flutter/flutter/issues/78159
}