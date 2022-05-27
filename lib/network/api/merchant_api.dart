import 'package:umpay_crossborder_app/config/config.dart';
import 'package:umpay_crossborder_app/network/api.dart';
import 'package:umpay_crossborder_app/network/target_type.dart';

///
/// Author       : zhongaidong
/// Date         : 2022-05-27 15:34:35
/// Description  :
///

class MerchantApi {
  static const String businessCategoryUrl = 'agent/mccInfo';

  /// 请求经营类目数据
  static apiBusinessCategory() async {
    Map<String, dynamic> requestParamsMap = {
      // "telNumber": paramsMap['telNumber'],
      // "imageCode": paramsMap['imageCode'],
      // "userImageCode": paramsMap['userImageCode'],
    };

    return TargetType().config(
        path: Config.baseUrl + businessCategoryUrl,
        headers: Api.apiGetHeader(),
        parameters: requestParamsMap,
        method: MSNetServiceMethod.POST,
        encoding: ParameterEncoding.BodyEncoding);
  }
}
