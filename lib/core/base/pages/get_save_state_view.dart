///
/// Author       : zhongaidong
/// Date         : 2022-04-22 22:01:04
/// Description  : 页面包活, 懒加载 + 缓存
///   Tab切换每次重新拉取数据, 体验极差
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class GetSaveStateView<T extends GetxController>
    extends StatefulWidget {
  const GetSaveStateView({Key? key}) : super(key: key);

  final String? tag = null;

  T get controller => GetInstance().find<T>(tag: tag);

  /// 局部更新字段
  String? get updateId => null;

  /// 应用程序的生命周期
  ///
  /// inactive: 应用程序处于闲置状态并且没有收到用户的输入事件。
  ///    - 注意这个状态，在切换到后台时候会触发，所以流程应该是先冻结窗口，然后停止UI
  /// paused: 应用程序处于不可见状态
  /// resumed: 应用程序处于可见状态，并且可以响应用户的输入事件
  /// detached: 当前页面即将退出
  Function(AppLifecycleState state)? get lifecycle => null;

  @protected
  Widget build(BuildContext context);

  @override
  State<GetSaveStateView> createState() => _GetSaveStateViewState<T>();
}

/// 可自动装载的状态管理
class _GetSaveStateViewState<S extends GetxController>
    extends State<GetSaveStateView>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  // _GetSaveStateViewState();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<S>(
        id: widget.updateId,
        builder: (controller) {
          return widget.build(context);
        });
  }

  @override
  void initState() {
    super.initState();
    if (widget.lifecycle != null) {
      /// 监听程序的前后台状态
      WidgetsBinding.instance?.addObserver(this);
    }
  }

  @override
  void dispose() {
    Get.delete<S>();
    if (widget.lifecycle != null) {
      WidgetsBinding.instance?.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    widget.lifecycle?.call(state);
  }

  @override
  bool get wantKeepAlive => true;
}
