/*
 * @Author: lixiao
 * @Date: 2020-05-17 20:48:36
 * @LastEditTime: 2020-10-28 15:40:25
 * @LastEditors: Please set LastEditors
 * @Description: 网络请求日志打印管理类
 * @FilePath: 
 */
import 'package:dio/dio.dart';
import '../services/EventBus.dart';
// import 'package:sh_flutter_express_station/utils/print_utils.dart';
import '../utils/print_utils.dart';

bool isDebug = true;

class LogsInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest

    if (isDebug) {
      print("┌────────────────────────Begin Request────────────────────────");
      print("uri = ${options.uri}");
      print("method = ${options.method}");
//      print("请求url：${options.baseUrl}");
//      print("请求path：${options.path}");
      print("query参数：${options.queryParameters}");
      print('headers: ' + options.headers.toString());
      if (options.data != null) {
        printLong('body: ' + options.data.toString());
      }
      print(
          "└————————————————————————End Request——————————————————————————\n\n");
    }

    super.onRequest(options, handler);
  }

//   @override
//   onRequest(RequestOptions options) {
//     if (isDebug) {
//       print("┌────────────────────────Begin Request────────────────────────");
//       print("uri = ${options.uri}");
//       print("method = ${options.method}");
// //      print("请求url：${options.baseUrl}");
// //      print("请求path：${options.path}");
//       print("query参数：${options.queryParameters}");
//       print('headers: ' + options.headers.toString());
//       if (options.data != null) {
//         printLong('body: ' + options.data.toString());
//       }
//       print(
//           "└————————————————————————End Request——————————————————————————\n\n");
//     }
//     return super.onRequest(options);
//   }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse

    if (isDebug) {
      if (response != null) {
        print(
            "┌────────────────────────Begin Response————————————————————————");
        print('status ${response.statusCode}');

        printLong('response: ' + response.toString());
        print(
            "└————————————————————————End Response——————————————————————————\n\n");
      }
    }

    super.onResponse(response, handler);
  }

  // @override
  // Future onResponse(Response response) {
  //   if (isDebug) {
  //     if (response != null) {
  //       print("┌────────────────────────Begin Response————————————————————————");
  //       print('status ${response.statusCode}');
  //       printLong('response: ' + response.toString());
  //       print("└————————————————————————End Response——————————————————————————\n\n");
  //     }
  //   }
  //   return super.onResponse(response); // continue
  // }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError

    if (isDebug) {
      print("┌────────────────────────Begin Dio Error————————————————————————");
      print('请求异常: ' + err.toString());
      print('请求异常信息: ' + (err.response?.toString() ?? ""));
      print(
          "└————————————————————————End Dio Error——————————————————————————\n\n");
    }

    super.onError(err, handler);
  }

  // @override
  // Future onError(DioError err) {
  //   if (isDebug) {
  //     print("┌────────────────────────Begin Dio Error————————————————————————");
  //     print('请求异常: ' + err.toString());
  //     print('请求异常信息: ' + (err.response?.toString() ?? ""));
  //     print(
  //         "└————————————————————————End Dio Error——————————————————————————\n\n");
  //   }
  //   return super.onError(err);
  // }
}

// class LogInterceptors extends InterceptorsWrapper {
//   @override
//   Future onRequest(RequestOptions options) {
//     print("url========= " + options.baseUrl + options.path);
//     print("method======" + options.method);
//     print("headers:==== ");
//     print(options.headers);
//     print("parameters======");
//     if (options.queryParameters == null){
//       print(options.data);
//     }else{
//       print(options.queryParameters);
//     }
//     return super.onRequest(options);
//   }

//   @override
//   Future onResponse(Response response) {
//     print("code======== ${response.statusCode}");
//     print("data======== ${response.data}");
//     return super.onResponse(response);
//   }

//   @override
//   Future onError(DioError err) {
//     print("error========");
//     print(err.response.statusCode);
//     print(err.response.data);
//     return super.onError(err);
//   }
// }
