// typedef CallBack = void Function(String datetimeStr);
 
///法人界面的字体颜色点击状态
class LegalColorUtils {
  //获取颜色
  static getChooseItemSelectedColor(
      String certificateTypeStr,
      String startTime,
      String endTime,
      String controlCertificateTypeStr,
      String controlStartTime,
      String controlEndTime,
      String beneCertificateTypeStr,
      String beneStartTime,
      String beneEndTime,
      int selectedIndex) {
    int colorValue = 0xff999999;

    switch (selectedIndex) {
      case 10: //身份证类型
        if (certificateTypeStr != null && certificateTypeStr.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 11:
      case 22: //姓名、证件号
        colorValue = 0xff999999;
        break;
      case 13: //证件有效期 起始
        if (startTime != null && startTime.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 14: //执照有效期 结束
        if (endTime != null && endTime.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 15: //手机号码
        colorValue = 0xff999999;
        break;
      case 100: //控制人证件类型
        if (controlCertificateTypeStr != null &&
            controlCertificateTypeStr.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 101:
      case 102: //控制人姓名、证件号
        colorValue = 0xff999999;
        break;
      case 103: //控制人起始日期
        if (controlStartTime != null && controlStartTime.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 104: //控制人结束日期
        if (controlEndTime != null && controlEndTime.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 105: //控制人手机号
        colorValue = 0xff999999;
        break;
      case 200: //受益人证件类型
        if (beneCertificateTypeStr != null &&
            beneCertificateTypeStr.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 201:
      case 202: //受益人姓名、证件号
        colorValue = 0xff999999;
        break;
      case 203: //受益人起始日期
        if (beneStartTime != null && beneStartTime.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 204: //受益人结束日期
        if (beneEndTime != null && beneEndTime.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 205: //受益人手机号
        colorValue = 0xff999999;
        break;
      default:
    }

    return colorValue;
  }
}
