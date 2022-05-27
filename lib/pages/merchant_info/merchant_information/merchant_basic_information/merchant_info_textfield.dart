///
/// Author       : zhongaidong
/// Date         : 2022-05-27 12:03:28
/// Description  :
///
import 'package:flutter/material.dart';

class MerchantInfoTextField extends StatelessWidget {
  const MerchantInfoTextField({
    Key? key,
    this.controller,
    this.hintText = '',
    this.obscureText = false,
    this.enabled = true,
    this.textInputType,
    this.selectedIndex,
    this.hintColor = const Color(0xff999999),
    this.onChanged
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final bool enabled;
  final bool obscureText;
  final TextInputType? textInputType;
  final int? selectedIndex;
  final Color hintColor;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1, // 最大行数
      autocorrect: true, // 是否自动更正
      // autofocus: true, //是否自动对焦
      obscureText: obscureText, //true, //是否是密码
      textAlign: TextAlign.left, //文本对齐方式
      cursorColor: const Color(0xff222222), //光标颜色
      cursorWidth: 1,
      cursorHeight: 15.0,
      style: const TextStyle(
        fontSize: 14.0,
        color: Color(0xff222222),
      ),
      // 输入文本的样式
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      // enableInteractiveSelection: true,
      onChanged: onChanged,
      onSubmitted: (text) {
        // 内容提交(按回车)的回调
        print('submit $text');
      },
      enabled: enabled, // true 是否禁用
    );
  }
}
