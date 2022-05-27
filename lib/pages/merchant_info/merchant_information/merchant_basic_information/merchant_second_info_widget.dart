///
/// Author       : zhongaidong
/// Date         : 2022-05-27 13:18:20
/// Description  :
///
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:umpay_crossborder_app/core/base/pages/get_binding_page.dart';
import 'package:umpay_crossborder_app/core/resource/divider_handler.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/merchant_basic_information/basic_info_binding.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/merchant_basic_information/merchant_info_widget.dart';

import 'basic_info_view_model.dart';

class MerchantSecondInfoWidget extends GetBindingPage<BasicInfoViewModel> {
  MerchantSecondInfoWidget({Key? key}) : super(key: key);
  // 联系人姓名
  final _contactNameController = TextEditingController();
  // 联系人证件号
  final _contactIDNumberController = TextEditingController();
  // 手机号
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        // height: 224,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            MerchantInfoWidget(
              controller: _contactNameController,
              title: '联系人姓名',
              hintText: '请输入联系人姓名',
              onChanged: (value) => controller.basicInfoModel
                  .update((info) => info!.contactName = value),
            ),
            DividerHandler.divider1HalfPadding12,
            MerchantInfoWidget(
              controller: _contactIDNumberController,
              title: '联系人证件号',
              hintText: '请输入证件号',
              onChanged: (value) => controller.basicInfoModel
                  .update((info) => info!.contactIdCardNum = value),
            ),
            DividerHandler.divider1HalfPadding12,
            MerchantInfoWidget(
              controller: _phoneController,
              title: '手机号码',
              hintText: '请输入联系人手机号',
              textInputType: TextInputType.phone,
              onChanged: (value) => controller.basicInfoModel
                  .update((info) => info!.contactMobile = value),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Bindings? binding() => BasicInfoBinding();
}
