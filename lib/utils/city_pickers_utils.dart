import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:kzcity_picker/kzcity_picker.dart';

// typedef CallBack = void Function(Result? result);
typedef CallBack = void Function(Map result);

class CityPickersUtils {
  // // type 1
  // Result result = await CityPickers.showCityPicker(
  //   context: context,
  // );
  // // type 2
  // Result result2 = await CityPickers.showFullPageCityPicker(
  //   context: context,
  // );
  // // type 3
  // Result result2 = await CityPickers.showCitiesSelector(
  //   context: context,
  // );

  /**
   * 三级联动
   */
  static showCityPicker(BuildContext context, CallBack callBack) async {
    // static showCityPicker(BuildContext context, CallBack callBack) async {
    // Result? result = await CityPickers.showCityPicker(
    //   context: context,
    //   height: 400,
    //   showType: ShowType.pca,
    //   // locationCode: "130102",
    //   cancelWidget: Text("取消",
    //       style: TextStyle(
    //         color: Color(0xff666666),
    //         fontSize: 15,
    //       )),
    //   confirmWidget: Text(
    //     "确定",
    //     style: TextStyle(
    //       color: Color(0xffFF5B5D),
    //       fontSize: 15,
    //     ),
    //   ),
    // );
    // callBack(result);

    // final res = await KzcityPicker.showPicker(context);
    // print(res.province + res.city + res.area);
    // print(
    //     "res ----> ${res}, ${res.provinceCode}, ${res.cityCode}, ${res.areaCode}");

    //外部本地加载
    // var cityStr = await rootBundle.loadString('assets/city.json');
    // List datas = json.decode(cityStr) as List;
    // final res = await KzcityPicker.showPicker(context, datas: datas);
    // print(res.province + res.city + res.area);
    // print(
    //     "res ----> ${res}, ${res.provinceCode}, ${res.cityCode}, ${res.areaCode}");

    // Map dataMap = {
    //   "province": res.province,
    //   "city": res.city,
    //   "area": res.area,
    //   "provinceCode": res.provinceCode,
    //   "cityCode": res.cityCode,
    //   "areaCode": res.areaCode,
    // };

    // callBack(dataMap);
  }

  // //展示 全页面联动
  // static showCitiesSelector(BuildContext context, CallBack callBack) async {
  //   Result? result = await CityPickers.showCitiesSelector(
  //     context: context,
  //   );
  //   callBack(result);
  // }

  // //全屏展示
  // static showFullPageCityPicker(BuildContext context, CallBack callBack) async {
  //   Result? result = await CityPickers.showFullPageCityPicker(
  //     context: context,
  //   );
  //   callBack(result);
  // }
}
