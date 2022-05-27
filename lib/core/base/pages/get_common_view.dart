///
/// Author       : zhongaidong
/// Date         : 2022-04-22 21:54:55
/// Description  : 可更新局部字段的公共页面
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 用于绑定Controller
abstract class GetCommonView<T extends GetxController> extends StatefulWidget {
  const GetCommonView({Key? key}) : super(key: key);

  final String? tag = null;

  T get controller => GetInstance().find<T>(tag: tag);

  /// 局部更新字段
  get updateId => null;

  @protected
  Widget build(BuildContext context);

  @override
  State<GetCommonView> createState() => _GetCommonViewState<T>();
}

/// 可自动装载的状态管理
class _GetCommonViewState<S extends GetxController>
    extends State<GetCommonView> {
  // _GetBindingPageState();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<S>(
        id: widget.updateId,
        builder: (controller) {
          return widget.build(context);
        });
  }

  @override
  void dispose() {
    Get.delete<S>();
    super.dispose();
  }
}
