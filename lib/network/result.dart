/*
 * @Author: lixiao
 * @Date: 2020-05-17 20:48:36
 * @LastEditTime: 2020-10-28 15:40:04
 * @LastEditors: Please set LastEditors
 * @Description: 网络请求返回结果类
 * @FilePath: 
 */

enum ValidateType {
  /// 请求中
  validating,

  /// 请求成功
  success,

  /// 请求失败
  failed,
}

class ValidateResult {
  ValidateType validateType;
  var data;
  var errorMsg;

  ValidateResult(
    this.validateType, {
    this.data,
    this.errorMsg,
  });
}
