import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import '../core/config/config.dart';
import '../services/UserServices.dart';
// import '../config/application.dart';

class LXLDioHttpManager {
  /*
   * post请求
   * apiPath 请求的url或路径
   * params  请求参数 
   */
  static postRequestData(String apiPath, Map params) async {
    var api;
    // if (apiPath.contains("http")) {
    if (apiPath.startsWith("http")) {
      api = apiPath;
    } else {
      api = "${Config.baseUrl}$apiPath";
    }

    String token; //= await UserServices.getUserToken();
    String? uuid = SpUtil.getString("uuid");

    Dio dio = Dio();
    dio.options.headers = {
      "accept": "application/json",
      // 'content-type': 'application/x-www-form-urlencoded',
      'content-type': 'application/json',
      // "token": token,
      "uuid": uuid,
    };
    // var response = await dio.post(api, data: params);

    // return response.data;

    try {
      var response = await dio.post(api, data: params);
      // print("response = ${response.data}");
      return response.data;
      // return response.data;
    } catch (e) {
      print(e);
    }
  }

  /// 上传图片数据
  static postUploadImageFileData(String apiPath, File file) async {
    var api;
    if (apiPath.startsWith("http")) {
      api = apiPath;
    } else {
      api = "${Config.baseUrl}$apiPath";
    }

    String token = UserServices.getToken();
    String? uuid = SpUtil.getString("uuid");

    Dio dio = Dio();
    dio.options.headers = {
      "accept": "application/json",
      // 'content-type': 'application/x-www-form-urlencoded',
      // 'content-type': 'application/json',
      'content-type': 'multipart/form-data',
      "Authorization": token,
      "uuid": uuid != null ? uuid : null,
    };

    String dateTimeStr = DateUtil.getNowDateMs().toString();

    String path = "";
    // if (Platform.isIOS) {
    //   path = file.path.replaceAll('file://', '');
    // } else {
    // path = file.path;
    path = file.path.replaceAll('file://', '');
    // }

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(path, filename: "$dateTimeStr.jpg")
      // 'file': MultipartFile.fromFileSync(file.path)
    });

    try {
      var response = await dio.post(
        api,
        data: formData,
        options: Options(contentType: "multipart/form-data"),
      );
      // print("response = ${response.data}");
      return response.data;
      // return response.data;
    } catch (e) {
      print(e);
    }
  }

  ///下载图片资源数据
  static getDownloadImageFileData(String imagePath, String savePath) async {
    var api = "${Config.baseUrl}user/file/download?path=$imagePath";

    String token = UserServices.getToken();
    String? uuid = SpUtil.getString("uuid");

    Dio dio = Dio();
    dio.options.headers = {
      "accept": "application/json",
      // 'content-type': 'application/x-www-form-urlencoded',
      'content-type': 'application/json',
      "Authorization": token,
      "uuid": uuid != null ? uuid : null,
    };

    try {
      var response = await Dio()
          .get(api, options: Options(responseType: ResponseType.bytes));

      // var response = await Dio().download(api, savePath);

      return response.data;
      // return response.data;
    } catch (e) {
      print(e);
    }
  }

  /*
   * get请求
   * apiPath 请求的url或路径
   */
  static getRequestData(String apiPath) async {
    var api;
    if (apiPath.startsWith("http")) {
      api = apiPath;
    } else {
      api = "${Config.baseUrl}$apiPath";
    }
    String token; //= await UserServices.getUserToken();
    Dio dio = Dio();
    dio.options.headers = {
      "accept": "application/json",
      // 'content-type': 'application/x-www-form-urlencoded',
      'Content-Type': 'application/json',
      // "token": token,
    };

    try {
      var response = await dio.get(api);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
