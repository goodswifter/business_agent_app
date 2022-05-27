import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/add_merchant_page.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/legal_person_information_page.dart';
import 'package:umpay_crossborder_app/utils/city_pickers_utils.dart';
import 'package:umpay_crossborder_app/utils/custom_date_picker_utils.dart';
import 'package:umpay_crossborder_app/utils/navigator_util.dart';
import 'package:umpay_crossborder_app/widget/custom_bottom_sheet_widget.dart';

import '../../../config/lxl_key_define.dart';
import '../../../dao/agent_business_license_info_dao.dart';
import '../../../model/agent_data_info_model.dart';
import '../../../network/network_message_code.dart';
import '../../../utils/lxl_easy_loading.dart';

//登记证书信息界面

typedef CallBack = Function(Object obj);

//页面image
enum CertificationImageype {
  /// 事业单位法人证书
  legalPersonCertificate,

  /// 事业证明函照片
  businessPhotoCertificate,
}

class RegistrationCertificateInformationPage extends StatefulWidget {
  MerchantType? merchantType;

  RegistrationCertificateInformationPage({Key? key, this.merchantType})
      : super(key: key);

  @override
  State<RegistrationCertificateInformationPage> createState() =>
      _RegistrationCertificateInformationPageState();
}

class _RegistrationCertificateInformationPageState
    extends State<RegistrationCertificateInformationPage> {
  //证书编号
  final _certificateNumberController = TextEditingController();
  //证书名称
  final _certificateNameController = TextEditingController();
  //注册地区
  final _registrationAreaController = TextEditingController();
  //注册地址
  final _registrationAddressController = TextEditingController();

  //证书有效期
  final _certificateValidityPeriodController1 = TextEditingController();
  final _certificateValidityPeriodController2 = TextEditingController();
  //注册资金币种
  final _registeredCapitalCurrencyController = TextEditingController();
  //注册资金
  final _registeredCapitalController = TextEditingController();

  //其他组织类型 -- 证书类型
  String certificateTypeStr = "";
  //注册地区
  String registrationAreaStr = "";
  //开始时间、结束时间
  String startTime = "";
  String endTime = "";
  //注册资金币种
  String registeredCapitalCurrencyStr = "";
  String agentId = "";

  Widget buildTextField(
      TextEditingController controller,
      String hintText,
      bool enabled,
      bool obscureText,
      TextInputType textInputType,
      int selectesIndex) {
    return Container(
      child: TextField(
        controller: controller,
        // maxLength: 30, //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
        maxLines: 1, //最大行数
        autocorrect: true, //是否自动更正
        // autofocus: true, //是否自动对焦
        obscureText: obscureText, //true, //是否是密码
        textAlign: TextAlign.left, //文本对齐方式
        cursorColor: Color(0x222222), //光标颜色
        cursorWidth: 1,
        cursorHeight: 15.0,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff222222),
        ), //输入文本的样式
        // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],//允许的输入格式
        keyboardType: textInputType,
        decoration: InputDecoration(
          // fillColor:
          //     Color(0xffEBEDF1), //Color(0xfff8f8f8), //Colors.blue.shade100,
          // filled: true,
          // labelText: "",

          hintText: hintText,
          hintStyle: TextStyle(
            // color: Color(0xff999999),
            color: Color(_getChooseItemSelectedColor(selectesIndex)),
            fontSize: 14,
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
        ),
        // enableInteractiveSelection: true,
        onChanged: (text) {
          //内容改变的回调
          print('change $text');
        },
        onSubmitted: (text) {
          //内容提交(按回车)的回调
          print('submit $text');
        },
        enabled: enabled, //true, //是否禁用
      ),
    );
  }

  //获取颜色
  _getChooseItemSelectedColor(int selectedIndex) {
    int colorValue = 0xff999999;
    switch (selectedIndex) {
      case 0:
      case 1:
        colorValue = 0xff999999;
        break;
      case 2: //注册地区
        if (this.registrationAreaStr != null &&
            this.registrationAreaStr.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 3:
        colorValue = 0xff999999;
        break;
      case 4: //执照有效期
        if (this.startTime != null && this.startTime.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 5:
        if (this.endTime != null && this.endTime.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 6: //注册资金币种
        if (this.registeredCapitalCurrencyStr != null &&
            this.registeredCapitalCurrencyStr.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      case 7: //注册资金
        colorValue = 0xff999999;
        break;
      case 99:
        if (this.certificateTypeStr != null &&
            this.certificateTypeStr.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;
      default:
    }
    return colorValue;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //登录获取代理商数据
    AgentDataInfoModel? agentDataInfoModel = SpUtil.getObj(
        LXLKeyDefine.agentUserDataInfoKey,
        (v) => AgentDataInfoModel.fromJson(v as Map<String, dynamic>));
    if (agentDataInfoModel != null) {
      LogUtil.e("--登陆成功info---${agentDataInfoModel.agentName}");
      if (agentDataInfoModel.agentId != null &&
          agentDataInfoModel.agentId!.length > 0) {
        this.agentId = agentDataInfoModel.agentId!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              //缩放到最小时是否需要悬停到顶部
              pinned: true,
              // 想下滚动显示 向上 跟随影藏
              floating: true,
              elevation: 0.0,
              leading: IconButton(
                icon: Image.asset(
                  "images/navi_back_images.png",
                  fit: BoxFit.cover,
                  // color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              //自定义title
              title: Container(
                child: Text(
                  "登记证书信息",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            //证书类型 ---  其他组织显示证书类型，事业单位不显示证书类型
            _addMerchantCertificateTypeWidget(),
            _subAddImageInfoWidget(
                "事业单位法人证书", true, CertificationImageype.legalPersonCertificate),
            _addMerchantFirstInfoWidget(), //证书信息
            _addMerchantSecondInfoWidget(), //证书有效期
            _addMerchantRegisteredCapitalWidget(), //注册资金
            _subAddImageInfoWidget("事业证明函照片", true,
                CertificationImageype.businessPhotoCertificate),
            _bottomSaveAndNextStepWidget(), //保存并下一步
          ],
        ),
      ),
    );
  }

  //添加图片
  _subAddImageInfoWidget(
      String title, bool isShowStar, CertificationImageype imageType) {
    return SliverToBoxAdapter(
      child: Container(
        height: 148,
        margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(12, 15, 0, 10),
              // width: 100,
              height: 24,
              // color: Colors.cyan,
              child: Row(
                children: [
                  Visibility(
                    visible: true,
                    child: Container(
                      child: Text(
                        isShowStar == true ? "*" : "  ",
                        style: TextStyle(
                          color: Color(0xffFF5B5D),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Color(0xff222222),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                //点击图片的事件
                _didSelectedCertificationImageAction(imageType);
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Image.asset(
                  "images/sh_app_add_upload_image.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///其他组织 -- 显示证书类型
  ///事业单位不显示证书类型
  _addMerchantCertificateTypeWidget() {
    return SliverToBoxAdapter(
      child: Visibility(
          visible: widget.merchantType == MerchantType.otherOrganizations
              ? true
              : false,
          child: Container(
            margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
            // height: 224,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _subMerchantInfoWiget(
                    _registeredCapitalCurrencyController,
                    this.certificateTypeStr != null &&
                            this.certificateTypeStr.length > 0
                        ? this.certificateTypeStr
                        : "民办非企业单位等级证书",
                    true,
                    "证书类型",
                    false,
                    true,
                    99,
                    TextInputType.text),
              ],
            ),
          )),
    );
  }

  //添加证书编号、证书名称、注册地区、注册地址
  _addMerchantFirstInfoWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
        // height: 224,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            _subMerchantInfoWiget(_certificateNumberController, "请输入证书编号", true,
                "证书编号", true, false, 0, TextInputType.text),
            _subLineWidget(),
            _subMerchantInfoWiget(_certificateNameController, "请输入证书名称", true,
                "证书名称", true, false, 1, TextInputType.text),
            _subLineWidget(),
            _subMerchantInfoWiget(
                _registrationAreaController,
                this.registrationAreaStr.length > 0
                    ? this.registrationAreaStr
                    : "请选择省市区",
                true,
                "注册地区",
                false,
                true,
                2,
                TextInputType.text),
            _subLineWidget(),
            _subMerchantInfoWiget(_registrationAddressController, "请输入详细注册地址",
                false, "注册地址", true, false, 3, TextInputType.text),
          ],
        ),
      ),
    );
  }

  //证书有效期
  _addMerchantSecondInfoWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
        // height: 224,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            _subMerchantInfoWiget(
                _certificateValidityPeriodController1,
                this.startTime != null && this.startTime.length > 0
                    ? this.startTime
                    : "请选择有效期起始日",
                true,
                "证书有效期",
                false,
                true,
                4,
                TextInputType.text),
            _subLineWidget(),
            _subMerchantInfoWiget(
                _certificateValidityPeriodController2,
                this.endTime != null && this.endTime.length > 0
                    ? this.endTime
                    : "请选择有效期截止日",
                false,
                "",
                false,
                true,
                5,
                TextInputType.text),
          ],
        ),
      ),
    );
  }

  //注册资金
  _addMerchantRegisteredCapitalWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
        // height: 224,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            _subMerchantInfoWiget(
                _registeredCapitalCurrencyController,
                this.registeredCapitalCurrencyStr != null &&
                        this.registeredCapitalCurrencyStr.length > 0
                    ? this.registeredCapitalCurrencyStr
                    : "请选择",
                true,
                "注册资金币种",
                false,
                true,
                6,
                TextInputType.text),
            _subLineWidget(),
            _subMerchantInfoWiget(_registeredCapitalController, "请输入金额", true,
                "注册资金（万元）", true, false, 7, TextInputType.text),
          ],
        ),
      ),
    );
  }

  //线条
  _subLineWidget() {
    return Container(
      height: 0.5,
      color: Color(0xffE9E9E9),
      margin: EdgeInsets.fromLTRB(12, 0, 6, 0),
    );
  }

  //重写子组件
  _subMerchantInfoWiget(
    TextEditingController controller,
    String hintText, //默认提示信息
    bool isShowStar, //是否显示*
    String title, //名称
    bool isEnableSelected, //设置是否可点击
    bool isShowRight, //是否展示右侧箭头 right image
    int didSelectedIndex, //点击了哪一行
    TextInputType textInputType,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _dealDidSelectedItemAction(title, didSelectedIndex);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
        height: 55,
        // color: Colors.purple,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100 + 20,
              child: Row(
                children: [
                  Visibility(
                    visible: true,
                    child: Container(
                      child: Text(
                        // "*",
                        isShowStar == true ? "*" : "  ",
                        style: TextStyle(
                          color: Color(0xffFF5B5D),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Color(0xff222222),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Expanded(
                flex: 1,
                child: Container(
                  // color: Colors.red,
                  padding: EdgeInsets.only(right: 10),
                  child: buildTextField(controller, hintText, isEnableSelected,
                      false, textInputType, didSelectedIndex),
                  // child: buildTextField(controller, "请输入真实姓名", true,
                  //     false, TextInputType.number),
                ),
              ),
            ),
            Visibility(
                visible: isShowRight, //true,
                child: Container(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Image.asset("images/sh_app_more_right_1.png",
                        fit: BoxFit.cover),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  //保存并下一步widget
  _bottomSaveAndNextStepWidget() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _didSelectedSaveAndNextAction();
        },
        child: Container(
          height: 45,
          margin: EdgeInsets.fromLTRB(48, 28, 48, 47),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffFF5B5D),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "保存并下一步",
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  ///处理加入点击每一个item选项
  _dealDidSelectedItemAction(String title, int selectedIndex) {
    LogUtil.e("title : ${title} , selectedIndex : ${selectedIndex}");
    FocusScope.of(context).requestFocus(FocusNode());

    switch (selectedIndex) {
      case 2: //注册地区
        //展示三级联动
        CityPickersUtils.showCityPicker(context, (result) {
          LogUtil.e("city result : ${result}");

          //后期需要城市码取城市码

          // city result : {"provinceName":"北京市","provinceId":"110000",
          //"cityName":"北京城区","cityId":"110100",
          //"areaName":"东城区","areaId":"110101" }

          if (result != null) {
            // this.registrationAreaStr =
            //     "${result.provinceName}${result.cityName}${result.areaName}";

            //city result : {province: 河北省, city: 石家庄市, area: 长安区,
            //provinceCode: 130000, cityCode: 130100, areaCode: 130102}
            this.registrationAreaStr =
                "${result["province"]}${result["city"]}${result["area"]}";
          } else {
            this.registrationAreaStr = "";
          }
          setState(() {});
        });
        break;
      case 4: //执照有效期  起始日期
        //日期
        CustomDatePickerUtils.showDatePicker(
            context, "", DateTimePickerMode.datetime, (datetime) {
          LogUtil.e("end date time = ${datetime}");
          setState(() {
            this.startTime = datetime;
          });
        });
        break;
      case 5: //执照有效期  结束日期
        //日期
        CustomDatePickerUtils.showDatePicker(
            context, "", DateTimePickerMode.datetime, (datetime) {
          LogUtil.e("end date time = ${datetime}");
          setState(() {
            this.endTime = datetime;
          });
        });
        break;
      case 6: //注册资金币种

        List currentData = [
          "CNY-人民币",
          "FRF-法国法郎",
          "HKD-港元",
          "CHF-瑞士法郎",
          "USD-美元",
          "CAD-加拿大元",
          "GBP-英镑",
          "NLG-荷兰盾",
          "DEM-德国马克",
          "BEF-比利时法郎",
          "JPY-日元",
          "AUD-澳大利亚元"
        ];
        CustomBottomSheetWidget.showSelectedBottomSheet(context, currentData,
            (str) {
          LogUtil.e("选中的币种回调 ${str}");
          this.registeredCapitalCurrencyStr = str;
        });
        break;
      case 99: //证件类型

        List currentData = [
          "民办非企业单位等级证书",
          "全国A级",
          "北京高新企业",
          "区登记证书",
        ];
        CustomBottomSheetWidget.showSelectedBottomSheet(context, currentData,
            (str) {
          LogUtil.e("选中的币种回调 ${str}");
          this.certificateTypeStr = str;
        });
        break;

      default:
    }
  }

  //点击保存并下一步事件
  _didSelectedSaveAndNextAction() {
    FocusScope.of(context).requestFocus(FocusNode());

    //法人信息界面
    NavigatorUtil.push(
        context,
        LegalPersonInformationPage(
          merchantType: widget.merchantType,
        ));
  }

  //点击图片的事件，调起手机拍照
  _didSelectedCertificationImageAction(CertificationImageype imageType) {
    switch (imageType) {
      case CertificationImageype.legalPersonCertificate:
        //事业单位法人证书
        LogUtil.e("事业单位法人证书  点击");
        break;
      case CertificationImageype.businessPhotoCertificate:
        //事业证明函照片
        LogUtil.e("事业证明函照片 点击");
        break;
      default:
    }
  }

  ///商户入住接口- 营业执照信息 -- 登记证书信息-
  _requestAgenMerchantEnterInfoData(CallBack callback) async {
    //商户类型
    // 1-小微；2-个体户；3-企事业
    int merchantType = 1;
    // 企事业商户子类型
    // 1-普通企业；2-事业单位；3-其他组织；
    int merchantChildType = 1;
    switch (widget.merchantType) {
      case MerchantType.smallAndMicro:
        merchantType = 1;
        break;
      case MerchantType.selfEmployed:
        merchantType = 2;
        break;
      case MerchantType.commonEnterprise:
        merchantType = 3;
        merchantChildType = 1;
        break;
      case MerchantType.businessUnit:
        merchantType = 3;
        merchantChildType = 2;
        break;
      case MerchantType.otherOrganizations:
        merchantType = 3;
        merchantChildType = 3;
        break;
      default:
    }

    //商户基本信息选项
    Map<String, dynamic> subInfoParamsMap = {
      "licenseType": "",
      "businessLicenseImg": "",
      "businessLicense": "",
      "licenseName": "",
      "registerProvinceCode": "",
      "registerCityCode": "",
      "registerDistinctCode": "",
      "registerAddress": "",
      "businessExpiry": "",
      "regCapitalCurrency": "",
      "regCapital": "",
      "companyProveCopy": "",
    };
    //商户入驻参数
    Map<String, dynamic> params = {
      "agentId":
          this.agentId != null && this.agentId.length > 0 ? this.agentId : "",
      "applicationId": "", //若type=2-提交商户资料，application_id必填
      "type": 1, //类型：1-保存商户资料；2-提交商户资料
      "merchantType": merchantType, //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType": merchantChildType, //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "businessLicenseInfo": subInfoParamsMap,
    };

    LXLEasyLoading.show();
    var response =
        await AgentBusinessLicenseInfoDao.doAgentBusinessLicenseInfoData(
            params);
    LXLEasyLoading.dismiss();
    LogUtil.e("response = ${response}");

    if (response == null) return;
    String code = response["retCode"];
    String message = response["retMsg"];
    // LoginInfoModel loginModel = LoginInfoModel.fromJson(response);

    if (code == ResponseMessage.SUCCESS_CODE) {
      callback("success");
    } else {
      LXLEasyLoading.showToast(message);
    }
  }
}
