///
/// Author       : zhongaidong
/// Date         : 2022-04-22 21:49:06
/// Description  : 用于可绑定的页面
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 用于绑定Controller
abstract class GetBindingPage<T extends GetxController> extends StatefulWidget {
  const GetBindingPage({Key? key}) : super(key: key);

  final String? tag = null;

  T get controller => GetInstance().find<T>(tag: tag);

  @protected
  Widget build(BuildContext context);

  @protected
  Bindings? binding();

  @override
  State<GetBindingPage> createState() => _GetBindingPageState<T>();
}

/// 可自动装载的状态管理
class _GetBindingPageState<S extends GetxController>
    extends State<GetBindingPage> {
  // _GetBindingPageState();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<S>(builder: (controller) {
      return widget.build(context);
    });
  }

  @override
  void initState() {
    super.initState();
    widget.binding()?.dependencies();
  }

  @override
  void dispose() {
    Get.delete<S>();
    super.dispose();
  }
}
