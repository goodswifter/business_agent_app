import 'package:flutter/material.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/merchant_basic_information/custom_sliver_app_bar.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/merchant_basic_information/merchant_first_info_widget.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/merchant_basic_information/merchant_second_info_widget.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/merchant_basic_information/next_button.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/store_information_page.dart';
import 'package:umpay_crossborder_app/utils/navigator_util.dart';

import '../../add_merchant_page.dart';
import 'warm_prompt_widget.dart';

/// 商户基本信息
class MerchantBasicInfomationPage extends StatelessWidget {
  const MerchantBasicInfomationPage({Key? key, required this.merchantType})
      : super(key: key);

  final MerchantType merchantType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: CustomScrollView(
          slivers: [
            const CustomSliverAppBar(),
            // 第一部分组件
            MerchantFirstInfoWidget(),
            // 第二部分组件
            MerchantSecondInfoWidget(),
            // 第三部分底部 warm prompt widget
            const WarmPromptWidget(),
            /// 保存并下一步按钮
            NextButton(
              // 跳转店铺信息界面
              onTap: () {
                NavigatorUtil.push(
                    context, StoreInfomationPage(merchantType: merchantType));
              },
            ),
          ],
        ),
      ),
    );
  }
  
}
