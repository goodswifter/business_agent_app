///
/// Author       : zhongaidong
/// Date         : 2022-05-27 12:57:54
/// Description  : 商户基本信息 view model层
///
import 'package:get/get.dart';
import 'package:umpay_crossborder_app/core/base/controller/base_get_controller.dart';
import 'package:umpay_crossborder_app/dao/merchant_dao.dart';
import 'package:umpay_crossborder_app/model/mcc_info_list_model.dart';
import 'package:umpay_crossborder_app/model/merchant_basic_info_model.dart';

class BasicInfoViewModel extends BaseGetController {
  var basicInfoModel = MerchantBasicInfoModel().obs;

  /// 经营类目字符串
  var mccStr = ''.obs;

  /// 小微经营类型
  var microBizTypeStr = ''.obs;

  List<String?> businessCategoryList = [];

  @override
  void onInit() {
    super.onInit();

    requestCategory();
  }

  Future<void> requestCategory() async {
    Map<String, dynamic>? response =
        await MerchantDao.requestBusinessCategory();
    MccInfoListModel mccList = MccInfoListModel.fromJson(response!);
    businessCategoryList =
        mccList.mccInfoList.map((item) => item.mccName).toList();

    print(businessCategoryList);
    update();
  }
}

List<String> microBizTypeList = ['门店场所', '流动经营/便民服务', '线上商品/服务交易'];

enum MicroBizType {
  /// 门店场所
  microTypeStore,

  /// 流动经营/便民服务
  microTypeMobile,

  /// 线上商品/服务交易
  microTypeOnline
}

extension MicroTypeExtension on MicroBizType {
  String get value => microBizTypeList[index];
}
