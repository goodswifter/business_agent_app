///
/// Author       : zhongaidong
/// Date         : 2022-05-27 11:54:09
/// Description  :
///
import 'package:flutter/material.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/merchant_basic_information/merchant_info_textfield.dart';

class MerchantInfoWidget extends StatelessWidget {
  const MerchantInfoWidget({
    Key? key,
    this.controller,
    this.title = '',
    this.hintText = '',
    this.hintColor = const Color(0xFF999999),
    this.isShowRight = false,
    this.didSelectedIndex = 0,
    this.isEnableSelected = true,
    this.isShowStar = true,
    this.textInputType = TextInputType.text,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText; // 默认提示信息
  final Color hintColor; // 默认提示信息
  final bool isShowStar; // 是否显示*
  final String title; // 名称
  final bool isEnableSelected; // 设置是否可点击
  final bool isShowRight; // 是否展示右侧箭头 right image
  final int didSelectedIndex; // 点击了哪一行
  final TextInputType textInputType;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Row(
                children: [
                  Visibility(
                    visible: true,
                    child: Text(
                      isShowStar == true ? "*" : "  ",
                      style: const TextStyle(
                        color: Color(0xffFF5B5D),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xff222222),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 10),
                child: MerchantInfoTextField(
                  controller: controller,
                  hintText: hintText,
                  hintColor: hintColor,
                  enabled: isEnableSelected,
                  textInputType: textInputType,
                  selectedIndex: didSelectedIndex,
                  onChanged: onChanged,
                ),
              ),
            ),
            Visibility(
                visible: isShowRight, //true,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Image.asset("images/sh_app_more_right_1.png",
                      fit: BoxFit.cover),
                )),
          ],
        ),
      ),
    );
  }
}
