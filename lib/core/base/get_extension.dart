///
/// Author       : zhongaidong
/// Date         : 2022-04-22 14:31:29
/// Description  : get 扩展方法
///
// import 'package:business_agent/widgets/dialog/common_dialog_widget.dart';
// import 'package:business_agent/widgets/dialog/loading_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

extension GetExtension on GetInterface {
  /// 隐藏dialog
  dismiss() {
    if (Get.isDialogOpen != null && Get.isDialogOpen!) Get.back();
  }

  /// 显示dialog
  showLoading({String text = ''}) {
    if (Get.isDialogOpen != null && Get.isDialogOpen!) Get.back();

    // Get.dialog(
    //   LoadingDialogWidget(text: text),
    //   transitionDuration: const Duration(milliseconds: 500),
    //   barrierDismissible: false,
    // );
  }

  /// 显示公共弹窗∏
  showDialog({
    String title = '',
    String content = '',
    String backText = '',
    String nextText = '',
    bool backVisible = true,
    bool nextVisible = true,
    VoidCallback? backTap,
    VoidCallback? nextTap,
    backKey = false,
  }) {
    // if (Get.isDialogOpen != null && Get.isDialogOpen!) Get.back();

    // Get.dialog(
    //   CommonDialogWidget(
    //     title: title,
    //     content: content,
    //     backText: backText,
    //     nextText: nextText,
    //     backVisible: backVisible,
    //     nextVisible: nextVisible,
    //     backTap: backTap,
    //     nextTap: nextTap,
    //   ),
    //   transitionDuration: const Duration(milliseconds: 500),
    //   barrierDismissible: backKey,
    // );
  }
}
