/*
 * @Author: 
 * @Date: 2019-10-18 14:52:44
 * @LastEditTime: 2020-05-22 16:39:28
 * @LastEditors: Please set LastEditors
 * @Description: 长日志打印工具类
 * @FilePath: /sh_flutter_express_station/lib/utils/print_utils.dart
 */ 
int maxLength = 340;

void printLong(String log) {
  if (log.length < maxLength) {
    print(log);
  } else {
    while (log.length > maxLength) {
      print(log.substring(0, maxLength));
      log = log.substring(maxLength);
    }
    //打印剩余部分
    print(log);
  }
}