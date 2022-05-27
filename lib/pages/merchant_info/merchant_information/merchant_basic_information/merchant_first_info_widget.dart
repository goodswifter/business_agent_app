///
/// Author       : zhongaidong
/// Date         : 2022-05-27 12:41:14
/// Description  : 商户基本信息 第一部分
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umpay_crossborder_app/core/base/pages/get_binding_page.dart';
import 'package:umpay_crossborder_app/core/resource/color_handler.dart';
import 'package:umpay_crossborder_app/core/resource/divider_handler.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/merchant_basic_information/basic_info_binding.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/merchant_basic_information/basic_info_view_model.dart';
import 'package:umpay_crossborder_app/widget/custom_bottom_sheet_widget.dart';

import 'merchant_info_widget.dart';

class MerchantFirstInfoWidget extends GetBindingPage<BasicInfoViewModel> {
  MerchantFirstInfoWidget({Key? key}) : super(key: key);

  /// 商户名称
  final _merchantNameController = TextEditingController();

  /// 商户简称
  final _merchantShortNameController = TextEditingController();

  /// 客服电话
  final _customerPhoneController = TextEditingController();

  /// 经营类目
  final _businessCategoryController = TextEditingController();

  /// 小微经营类型
  final _smallBusinessTypeController = TextEditingController();

  /// 邮箱地址
  final _emailAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 16, 12, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            MerchantInfoWidget(
              controller: _merchantNameController,
              title: '商户名称',
              hintText: '请输入商户名称',
              onChanged: (value) => controller.basicInfoModel
                  .update((info) => info!.merchantName = value),
            ),
            DividerHandler.divider1HalfPadding12,
            MerchantInfoWidget(
              controller: _merchantShortNameController,
              title: '商户简称',
              hintText: '请输入商户简称',
              onChanged: (value) => controller.basicInfoModel
                  .update((info) => info!.merchantShortName = value),
            ),
            DividerHandler.divider1HalfPadding12,
            MerchantInfoWidget(
              controller: _customerPhoneController,
              title: '客服电话',
              hintText: '请输入客服电话',
              onChanged: (value) => controller.basicInfoModel
                  .update((info) => info!.servicePhone = value),
            ),
            DividerHandler.divider1HalfPadding12,
            Obx(() {
              bool isSelected = controller.mccStr.value.isNotEmpty; // 是否选中
              return MerchantInfoWidget(
                controller: _businessCategoryController,
                title: '经营类目',
                hintText: isSelected ? controller.mccStr.value : '请选择经营类目',
                hintColor: isSelected
                    ? ColorHandler.greyColor3
                    : ColorHandler.greyColor9,
                isShowRight: true,
                onTap: () {
                  CustomBottomSheetWidget.showSelectedBottomSheet(
                      context, controller.businessCategoryList, (str) {
                    controller.mccStr.value = str;
                    controller.basicInfoModel.update((info) => info!.mcc = str);
                  });
                },
              );
            }),
            DividerHandler.divider1HalfPadding12,
            Obx(() {
              bool isSelected =
                  controller.microBizTypeStr.value.isNotEmpty; // 是否选中
              return MerchantInfoWidget(
                controller: _smallBusinessTypeController,
                title: '小微经营类型',
                hintText:
                    isSelected ? controller.microBizTypeStr.value : '请选择经营类型',
                hintColor: isSelected
                    ? ColorHandler.greyColor3
                    : ColorHandler.greyColor9,
                isShowRight: true,
                didSelectedIndex: 4,
                onTap: () {
                  CustomBottomSheetWidget.showSelectedBottomSheet(
                    context,
                    microBizTypeList,
                    (str) {
                      controller.microBizTypeStr.value = str;
                      controller.basicInfoModel.update((info) =>
                          info!.microBizType = microBizTypeList.indexOf(str));
                    },
                  );
                },
              );
            }),
            DividerHandler.divider1HalfPadding12,
            MerchantInfoWidget(
              controller: _emailAddressController,
              title: '邮箱地址',
              hintText: '请输入邮箱地址',
              isShowStar: false,
              onChanged: (value) => controller.basicInfoModel
                  .update((info) => info!.email = value),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Bindings? binding() => BasicInfoBinding();
}
