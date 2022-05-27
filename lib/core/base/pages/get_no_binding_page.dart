/// 
/// Author       : zhongaidong
/// Date         : 2022-04-22 21:58:08
/// Description  : 未绑定binding的页面
/// 
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class GetNoView<T extends GetxController> extends StatelessWidget {
  const GetNoView({Key? key}) : super(key: key);

  final String? tag = null;

  T get controller => GetInstance().find<T>(tag: tag);

  Widget buildWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(builder: (controller) {
      return buildWidget(context);
    });
  }
}