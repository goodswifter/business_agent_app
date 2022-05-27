class HomeDao {
  // static Future<Map<String, dynamic>> doGetFocusData() async {
  //   PublishSubject<ValidateResult> resultSubject =
  //       PublishSubject<ValidateResult>();

  //   resultSubject.add(ValidateResult(ValidateType.validating));
  //   // HttpManager.instance.baseUrl = 'https://express.shshcom.com/';
  //   // HttpManager.instance.baseUrl = 'http://jd.itying.com/';
  //   // HttpManager.instance.baseUrl =
  //   //     'https://uatfx.soopay.net/dev176/digitalRmb/';

  //   HttpManager.instance.baseUrl = Config.baseUrl;

  //   ValidateResult result =
  //       await HttpManager.instance.request(await Api.apiGetFocusData());

  //   switch (result.validateType) {
  //     case ValidateType.validating:
  //       break;
  //     case ValidateType.success:

  //       /// 对数据进行处理
  //       try {
  //         resultSubject
  //             .add(ValidateResult(ValidateType.success, data: "处理好的数据"));
  //         // Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
  //         // var result = json.decode(utf8decoder.convert(result.data));
  //         if (result.data.toString().length == 0) {
  //           return null;
  //         }

  //         Map<String, dynamic> resultModel = result.data;
  //         return resultModel;
  //       } catch (e) {
  //         print(e);
  //       }
  //       break;
  //     case ValidateType.failed:
  //       resultSubject
  //           .add(ValidateResult(ValidateType.failed, errorMsg: "网络请求错误"));
  //       break;
  //   }
  // }
}
