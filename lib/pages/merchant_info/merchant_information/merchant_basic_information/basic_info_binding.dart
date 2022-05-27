///
/// Author       : zhongaidong
/// Date         : 2022-05-27 13:07:17
/// Description  :
///
import 'package:get/get.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/merchant_basic_information/basic_info_view_model.dart';

class BasicInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BasicInfoViewModel());
  }
}
