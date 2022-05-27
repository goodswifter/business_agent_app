///
/// Author       : zhongaidong
/// Date         : 2022-04-22 14:48:00
/// Description  : 文本样式管理
///
import 'package:flutter/material.dart';

import 'color_handler.dart';

class TextStyleHandler {
  ///---------------------------黑绿色字体区域-------------------------------
  static const TextStyle titleBlackTextStyle =
      TextStyle(color: Colors.black87, fontSize: 18);
  static const TextStyle styleDarkBlue14 =
      TextStyle(color: ColorHandler.globalDarkBlueColor, fontSize: 14);
  static const TextStyle styleDarkBlue16 =
      TextStyle(color: ColorHandler.globalDarkBlueColor, fontSize: 16);
  static const TextStyle styleDarkBlue18 =
      TextStyle(color: ColorHandler.globalDarkBlueColor, fontSize: 18);

  ///---------------------------淡灰色字体区域-------------------------------
  static const TextStyle styleGrey11 =
      TextStyle(color: ColorHandler.globalGreyColor, fontSize: 11);
  static const TextStyle styleGrey13 =
      TextStyle(color: ColorHandler.globalGreyColor, fontSize: 13);
  static const TextStyle styleGrey14 =
      TextStyle(color: ColorHandler.globalGreyColor, fontSize: 14);

  ///---------------------------浅灰色字体区域-------------------------------
  static const TextStyle styleGrey4Font11 =
      TextStyle(color: ColorHandler.greyColor4, fontSize: 11, height: 1.1);
  static const TextStyle styleGrey4Font14 =
      TextStyle(color: ColorHandler.greyColor4, fontSize: 14, height: 1.1);
  static const TextStyle styleGrey5Font11 =
      TextStyle(color: ColorHandler.greyColor5, fontSize: 11, height: 1.1);
  static const TextStyle styleGrey2Font14 =
      TextStyle(color: ColorHandler.greyColor2, fontSize: 14);
  static const TextStyle styleGrey2Font16 =
      TextStyle(color: ColorHandler.greyColor2, fontSize: 16);

  ///---------------------------白色字体区域-------------------------------
  static const TextStyle styleWhite10 =
      TextStyle(color: Colors.white, fontSize: 10, height: 1.1);
  static const TextStyle styleWhite12 =
      TextStyle(color: Colors.white, fontSize: 12);
  static const TextStyle styleWhite14 =
      TextStyle(color: Colors.white, fontSize: 14);
  static const TextStyle styleWhite16 =
      TextStyle(color: Colors.white, fontSize: 16);
  static const TextStyle styleWhite18 =
      TextStyle(color: Colors.white, fontSize: 18);
  static const TextStyle styleWhite18Bold =
      TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700);
  static const TextStyle styleWhite16Bold =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700);
  static const TextStyle styleWhite24Font18 =
      TextStyle(color: Colors.white24, fontSize: 18);
  static const TextStyle styleWhite36 =
      TextStyle(color: Colors.white, fontSize: 36);

  ///---------------------------黑色字体区域-------------------------------
  static const TextStyle styleBlack18Bold =
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700);
  static const TextStyle styleBlack18Bold500 =
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);
  static const TextStyle styleBlack16Bold =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700);
  static const TextStyle styleBlack16Bold500 =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
  static const TextStyle styleBlack12 =
      TextStyle(color: Colors.black, fontSize: 12);
  static const TextStyle styleBlack13 =
      TextStyle(color: Colors.black, fontSize: 13);
  static const TextStyle styleBlack14 =
      TextStyle(color: Colors.black, fontSize: 14);
  static const TextStyle styleBlack15 =
      TextStyle(color: Colors.black, fontSize: 15);
  static const TextStyle styleBlack16 =
      TextStyle(color: Colors.black, fontSize: 16);
  static const TextStyle styleBlack30 =
      TextStyle(color: Colors.black, fontSize: 30);
  static const TextStyle styleBlack36 =
      TextStyle(color: Colors.black, fontSize: 36);

  static const TextStyle styleGreen14 =
      TextStyle(color: ColorHandler.globalGreenColor, fontSize: 14);

  ///---------------------------红色字体区域-------------------------------
  static const TextStyle styleRed10 =
      TextStyle(color: Colors.red, fontSize: 10, height: 1.1);

  ///---------------------------黄色、淡黄色字体区域-------------------------------
  static const TextStyle styleTangerine24Bold = TextStyle(
      color: ColorHandler.globalTangerineColor,
      fontSize: 24,
      fontWeight: FontWeight.w700);

  static const TextStyle styleOrange14 =
      TextStyle(color: ColorHandler.globalOrangeColor, fontSize: 14);

  static const TextStyle styleOrange16 =
      TextStyle(color: ColorHandler.globalOrangeColor, fontSize: 16);

  static const TextStyle styleTangerine11 =
      TextStyle(color: ColorHandler.globalTangerineColor, fontSize: 11, height: 1.1);
}
