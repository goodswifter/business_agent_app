///结算界面的字体颜色点击状态
class BillingColorUtils {
  //获取颜色
  static getChooseItemSelectedColor(
    String accountNameStr,
    String accountStr,
    String accountBankStr,
    String accountBankCityStr,
    String accountOpeningBranchStr,
    String certificateTypeStr,
    String billingNameStr,
    String billingNumberStr,
    String billingStartTimeStr,
    String billingEndTimeStr,
    int selectedIndex,
  ) {
    int colorValue = 0xff999999;

    switch (selectedIndex) {
      case 0: //账户名称
      case 1: //账号
        colorValue = 0xff999999;
        break;
      case 2: //开户行
        if (accountBankStr != null && accountBankStr.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 3: //开户行城市
        if (accountBankCityStr != null && accountBankCityStr.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 4: //开户行支行
        if (accountOpeningBranchStr != null && accountOpeningBranchStr.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 999: //结算人证件类型
        if (certificateTypeStr != null && certificateTypeStr.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 100: //结算人姓名
      case 101: //控制人证件号
        colorValue = 0xff999999;
        break;
      case 102:
        if (billingStartTimeStr != null && billingStartTimeStr.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 103:
        if (billingEndTimeStr != null && billingEndTimeStr.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      default:
    }

    return colorValue;
  }
}
