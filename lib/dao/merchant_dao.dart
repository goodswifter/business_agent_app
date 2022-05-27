///
/// Author       : zhongaidong
/// Date         : 2022-05-27 15:24:15
/// Description  : 新增商户 请求类
///
import 'package:rxdart/rxdart.dart';
import 'package:umpay_crossborder_app/network/api/merchant_api.dart';

import '../config/config.dart';
import '../network/http_manager.dart';

class MerchantDao {
  /// 请求经营类目数据
  static Future<Map<String, dynamic>?> requestBusinessCategory() async {
    PublishSubject<ValidateResult> resultSubject =
        PublishSubject<ValidateResult>();

    resultSubject.add(ValidateResult(ValidateType.validating));
    HttpManager.instance.baseUrl = Config.baseUrl;

    ValidateResult result = await HttpManager.instance
        .request(await MerchantApi.apiBusinessCategory());

    switch (result.validateType) {
      case ValidateType.validating:
        break;
      case ValidateType.success:

        /// 对数据进行处理
        try {
          resultSubject
              .add(ValidateResult(ValidateType.success, data: "处理好的数据"));
          if (result.data.toString().isEmpty) return null;

          Map<String, dynamic> resultModel = result.data;
          return resultModel;
        } catch (e) {
          print(e);
        }
        break;
      case ValidateType.failed:
        resultSubject
            .add(ValidateResult(ValidateType.failed, errorMsg: "网络请求错误"));
        break;
    }
    return null;
  }
}
