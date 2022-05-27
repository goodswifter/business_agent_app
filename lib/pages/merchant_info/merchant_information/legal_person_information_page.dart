import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/add_merchant_page.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/billing_information_page.dart';
import 'package:umpay_crossborder_app/utils/custom_date_picker_utils.dart';
import 'package:umpay_crossborder_app/utils/legal_color_utils.dart';
import 'package:umpay_crossborder_app/utils/navigator_util.dart';
import 'package:umpay_crossborder_app/widget/custom_bottom_sheet_widget.dart';

import '../../../config/lxl_key_define.dart';
import '../../../dao/agent_legal_persion_info_dao.dart';
import '../../../model/agent_data_info_model.dart';
import '../../../network/network_message_code.dart';
import '../../../utils/lxl_easy_loading.dart';

//法人界面

typedef CallBack = Function(Object obj);

//页面身份证类型 image
enum LegalPersonInfoImageype {
  /// 身份证照片 人像面
  portraitFace,

  /// 身份证照片 国徽面
  nationalEmblem,

  /// 控制人身份证照片 人像面
  controlPortraitFace,

  /// 控制人身份证照片 国徽面
  controlNationalEmblem,

  /// 受益人身份证照片 人像面
  benePortraitFace,

  /// 受益人身份证照片 国徽面
  beneNationalEmblem,
}

class LegalPersonInformationPage extends StatefulWidget {
  MerchantType? merchantType;

  LegalPersonInformationPage({Key? key, this.merchantType}) : super(key: key);

  @override
  State<LegalPersonInformationPage> createState() =>
      _LegalPersonInformationPageState();
}

class _LegalPersonInformationPageState
    extends State<LegalPersonInformationPage> {
  //证件类型
  final _cardIDTypeController = TextEditingController();
  //姓名
  final _nameController = TextEditingController();
  //证件号
  final _cardIDNumberController = TextEditingController();
  //证书有效期
  final _certificateValidityPeriodController1 = TextEditingController();
  final _certificateValidityPeriodController2 = TextEditingController();
  //手机号
  final _phoneController = TextEditingController();

  //控制人对应的textEditingController
  //证件类型
  final _controlCardIDTypeController = TextEditingController();
  //姓名
  final _controlNameController = TextEditingController();
  //证件号
  final _controlCardIDNumberController = TextEditingController();
  //证书有效期
  final _conCertificateValidityPeriodController1 = TextEditingController();
  final _conCertificateValidityPeriodController2 = TextEditingController();
  //手机号
  final _controlPhoneController = TextEditingController();

  //受益人对应的textEditingController
  //证件类型
  final _beneCardIDTypeController = TextEditingController();
  //姓名
  final _beneNameController = TextEditingController();
  //证件号
  final _beneCardIDNumberController = TextEditingController();
  //证书有效期
  final _beneCertificateValidityPeriodController1 = TextEditingController();
  final _beneCertificateValidityPeriodController2 = TextEditingController();
  //手机号
  final _benePhoneController = TextEditingController();

  String certificateTypeStr = "";
  //开始时间、结束时间
  String startTime = "";
  String endTime = "";
  String controlCertificateTypeStr = "";
  //控制人开始时间、结束时间
  String controlStartTime = "";
  String controlEndTime = "";
  //受益人
  String beneCertificateTypeStr = "";
  //开始时间、结束时间
  String beneStartTime = "";
  String beneEndTime = "";

  //控制人 --- 是，否
  bool isControlYes = true;
  bool isControldNo = false;
  //受益人 --- 是，否
  bool isBeneficiaryYes = true;
  bool isBeneficiaryNo = false;

  //是否展示控制人详细信息填写
  bool isShowControl = false;
  //是否展示受益人详细信息填写
  bool isShowBeneficiary = false;

  String agentId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LogUtil.e("store merchant type : ${widget.merchantType}");

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

  Widget buildTextField(
      TextEditingController controller,
      String hintText,
      bool enabled,
      bool obscureText,
      TextInputType textInputType,
      int selectedIndex) {
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
            // color: Color(_getChooseItemSelectedColor(selectedIndex)),
            color: Color(LegalColorUtils.getChooseItemSelectedColor(
                certificateTypeStr,
                startTime,
                endTime,
                controlCertificateTypeStr,
                controlStartTime,
                controlEndTime,
                beneCertificateTypeStr,
                beneStartTime,
                beneEndTime,
                selectedIndex)),
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
                  "法人信息",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            //添加证件类型
            _addMerchantCertificateTypeWidget(),
            //身份证照片
            _subAddCardIDImageInfoWidget("身份证照片", true),
            //添加法人基本信息
            _addLegalPersonBasicInformationWidget(),
            //控制人
            _addBottomControlPersonWidget(),

            ///(1-控制人)展示控制人信息widget  点击控制人 "否" 展示的界面
            _showControlPersonInfoWidget(),

            //受益人
            _addBottomBeneficiaryWidget(),

            ///(2 - 受益人)展示受益人信息widget  点击受益人 "否" 展示的界面
            _showBeneficiaryInfoWidget(),

            //保存并下一步widget
            _bottomSaveAndNextStepWidget(),
          ],
        ),
      ),
    );
  }

  //添加证件类型
  _addMerchantCertificateTypeWidget() {
    return SliverToBoxAdapter(
      child: Visibility(
          visible: true,
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
                    _cardIDTypeController,
                    this.certificateTypeStr != null &&
                            this.certificateTypeStr.length > 0
                        ? this.certificateTypeStr
                        : "请选择",
                    true,
                    "证书类型",
                    false,
                    true,
                    10,
                    TextInputType.text),
              ],
            ),
          )),
    );
  }

  //添加身份证图片
  _subAddCardIDImageInfoWidget(String title, bool isShowStar) {
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
            Container(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      _didSelectedCertificationImageAction(
                          LegalPersonInfoImageype.portraitFace);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Image.asset(
                        "images/sh_app_card_id_image_1.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _didSelectedCertificationImageAction(
                          LegalPersonInfoImageype.nationalEmblem);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Image.asset(
                        "images/sh_app_card_id_image_2.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //添加法人基本信息
  _addLegalPersonBasicInformationWidget() {
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
            _subMerchantInfoWiget(_nameController, "请输入姓名", true, "姓名", true,
                false, 11, TextInputType.text),
            _subLineWidget(),
            _subMerchantInfoWiget(_cardIDNumberController, "请输入证件号", true,
                "证件号", true, false, 12, TextInputType.text),
            _subLineWidget(),
            _subMerchantInfoWiget(
                _certificateValidityPeriodController1,
                this.startTime != null && this.startTime.length > 0
                    ? this.startTime
                    : "请选择有效期起始日",
                true,
                "证书有效期",
                false,
                true,
                13,
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
                14,
                TextInputType.text),
            _subLineWidget(),
            _subMerchantInfoWiget(_phoneController, "请输入手机号码", true, "手机号码",
                true, false, 15, TextInputType.text),
          ],
        ),
      ),
    );
  }

  ///bottom sub widget 控制人widget
  _addBottomControlPersonWidget() {
    return SliverToBoxAdapter(
      child: Visibility(
        visible: true,
        child: Container(
          margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
          // height: 224,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            height: 55,
            // alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  // width: 100,
                  // color: Colors.cyan,
                  margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Row(
                    children: [
                      Visibility(
                        visible: true,
                        child: Container(
                          child: Text(
                            "*",
                            // isShowStar == true ? "*" : "  ",
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
                          // title,
                          "控制人是否与法人一致",
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
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    LogUtil.e("控制人---是点击了");

                    setState(() {
                      this.isControlYes = true;
                      this.isControldNo = false;
                      this.isShowControl = false;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(56, 0, 0, 0),
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(
                            // "images/sh_app_choose_selected_image.png",
                            this.isControlYes == true &&
                                    this.isControldNo == false
                                ? "images/sh_app_choose_selected_image.png"
                                : "images/sh_app_choose_no_selected_image.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(4, 0, 0, 0),
                          child: Text(
                            "是",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff333333),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    LogUtil.e("控制人---否点击了");

                    setState(() {
                      this.isControlYes = false;
                      this.isControldNo = true;
                      this.isShowControl = true;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(
                            // "images/sh_app_choose_no_selected_image.png",
                            this.isControldNo == true &&
                                    this.isControlYes == false
                                ? "images/sh_app_choose_selected_image.png"
                                : "images/sh_app_choose_no_selected_image.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(4, 0, 0, 0),
                          child: Text(
                            "否",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff333333),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///bottom 受益人widget
  _addBottomBeneficiaryWidget() {
    return SliverToBoxAdapter(
      child: Visibility(
          visible: true,
          child: Container(
            margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
            // height: 224,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              height: 55,
              // alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    // width: 100,
                    // color: Colors.cyan,
                    margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Row(
                      children: [
                        Visibility(
                          visible: true,
                          child: Container(
                            child: Text(
                              "*",
                              // isShowStar == true ? "*" : "  ",
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
                            // title,
                            "受益人是否与法人一致",
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
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      LogUtil.e("受益人---是点击了");

                      setState(() {
                        this.isBeneficiaryYes = true;
                        this.isBeneficiaryNo = false;
                        this.isShowBeneficiary = false;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(56, 0, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset(
                              // "images/sh_app_choose_selected_image.png",
                              this.isBeneficiaryYes == true &&
                                      this.isBeneficiaryNo == false
                                  ? "images/sh_app_choose_selected_image.png"
                                  : "images/sh_app_choose_no_selected_image.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Text(
                              "是",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      LogUtil.e("受益人---否点击了");

                      setState(() {
                        this.isBeneficiaryYes = false;
                        this.isBeneficiaryNo = true;
                        this.isShowBeneficiary = true;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset(
                              // "images/sh_app_choose_no_selected_image.png",
                              this.isBeneficiaryNo == true &&
                                      this.isBeneficiaryYes == false
                                  ? "images/sh_app_choose_selected_image.png"
                                  : "images/sh_app_choose_no_selected_image.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Text(
                              "否",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  ////////******************控制人信息widget************************///////
  ///展示控制人信息widget  点击控制人 "否" 展示的界面
  _showControlPersonInfoWidget() {
    return SliverToBoxAdapter(
      child: Visibility(
        visible: this.isShowControl == true ? true : false,
        child: Container(
          child: Column(
            children: [
              Visibility(
                  visible: true,
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
                            _controlCardIDTypeController,
                            this.controlCertificateTypeStr != null &&
                                    this.controlCertificateTypeStr.length > 0
                                ? this.controlCertificateTypeStr
                                : "请选择",
                            true,
                            "控制人证件类型",
                            false,
                            true,
                            100,
                            TextInputType.text),
                      ],
                    ),
                  )),
              Container(
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
                                // isShowStar == true ? "*" : "  ",
                                "*",
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
                              "控制人身份证照片",
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
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              _didSelectedCertificationImageAction(
                                  LegalPersonInfoImageype.controlPortraitFace);
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                              child: Image.asset(
                                "images/sh_app_card_id_image_1.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _didSelectedCertificationImageAction(
                                  LegalPersonInfoImageype
                                      .controlNationalEmblem);
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: Image.asset(
                                "images/sh_app_card_id_image_2.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                // height: 224,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _subMerchantInfoWiget(_controlNameController, "请输入控制人姓名",
                        true, "控制人姓名", true, false, 101, TextInputType.text),
                    _subLineWidget(),
                    _subMerchantInfoWiget(
                        _controlCardIDNumberController,
                        "请输入控制人证件号",
                        true,
                        "控制人证件号",
                        true,
                        false,
                        102,
                        TextInputType.text),
                    _subLineWidget(),
                    _subMerchantInfoWiget(
                        _conCertificateValidityPeriodController1,
                        this.controlStartTime != null &&
                                this.controlStartTime.length > 0
                            ? this.controlStartTime
                            : "请选择有效期起始日",
                        true,
                        "控制人证件有效期",
                        false,
                        true,
                        103,
                        TextInputType.text),
                    _subLineWidget(),
                    _subMerchantInfoWiget(
                        _conCertificateValidityPeriodController2,
                        this.controlEndTime != null &&
                                this.controlEndTime.length > 0
                            ? this.controlEndTime
                            : "请选择有效期截止日",
                        false,
                        "",
                        false,
                        true,
                        104,
                        TextInputType.text),
                    _subLineWidget(),
                    _subMerchantInfoWiget(_controlPhoneController, "请输入手机号码",
                        true, "控制人手机号码", true, false, 105, TextInputType.text),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ////////******************收益人信息widget************************///////
  ///展示受益人人信息widget
  ///
  _showBeneficiaryInfoWidget() {
    return SliverToBoxAdapter(
      child: Visibility(
        visible: this.isShowBeneficiary == true ? true : false,
        child: Container(
          child: Column(
            children: [
              Visibility(
                  visible: true,
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
                            _beneCardIDTypeController,
                            this.beneCertificateTypeStr != null &&
                                    this.beneCertificateTypeStr.length > 0
                                ? this.beneCertificateTypeStr
                                : "请选择",
                            true,
                            "受益人证件类型",
                            false,
                            true,
                            200,
                            TextInputType.text),
                      ],
                    ),
                  )),
              Container(
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
                                // isShowStar == true ? "*" : "  ",
                                "*",
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
                              "受益人身份证照片",
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
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              _didSelectedCertificationImageAction(
                                  LegalPersonInfoImageype.benePortraitFace);
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                              child: Image.asset(
                                "images/sh_app_card_id_image_1.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _didSelectedCertificationImageAction(
                                  LegalPersonInfoImageype.beneNationalEmblem);
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: Image.asset(
                                "images/sh_app_card_id_image_2.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                // height: 224,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _subMerchantInfoWiget(_beneNameController, "请输入受益人姓名", true,
                        "受益人姓名", true, false, 201, TextInputType.text),
                    _subLineWidget(),
                    _subMerchantInfoWiget(
                        _beneCardIDNumberController,
                        "请输入受益人证件号",
                        true,
                        "受益人证件号",
                        true,
                        false,
                        202,
                        TextInputType.text),
                    _subLineWidget(),
                    _subMerchantInfoWiget(
                        _beneCertificateValidityPeriodController1,
                        this.beneStartTime != null &&
                                this.beneStartTime.length > 0
                            ? this.beneStartTime
                            : "请选择有效期起始日",
                        true,
                        "受益人证件有效期",
                        false,
                        true,
                        203,
                        TextInputType.text),
                    _subLineWidget(),
                    _subMerchantInfoWiget(
                        _beneCertificateValidityPeriodController2,
                        this.beneEndTime != null && this.beneEndTime.length > 0
                            ? this.beneEndTime
                            : "请选择有效期截止日",
                        false,
                        "",
                        false,
                        true,
                        204,
                        TextInputType.text),
                    _subLineWidget(),
                    _subMerchantInfoWiget(_benePhoneController, "请输入手机号码", true,
                        "受益人手机号码", true, false, 205, TextInputType.text),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ////////////******以下是布局子组件的widget部分******//////////////

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
              width: 135, //didSelectedIndex == 100 ? 120 : 100, //100,
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

    //区分每一个事件
    this._switchDidSelectedItemAction(title, selectedIndex);
  }

  //区分每一个点击事件
  _switchDidSelectedItemAction(String title, int selectedIndex) {
    switch (selectedIndex) {
      case 10: //top  证件类型
        List currentData = [
          "身份证",
          "护照",
          "香港居民来往内地通行证（回乡证）",
          "澳门居民来往内地通行证（回乡证）",
          "台湾同胞来往内地通行证（台胞证）",
        ];
        CustomBottomSheetWidget.showSelectedBottomSheet(context, currentData,
            (str) {
          setState(() {
            this.certificateTypeStr = str;
          });
        });
        break;
      case 13: //证件起始日期
        //日期
        CustomDatePickerUtils.showDatePicker(
            context, "", DateTimePickerMode.datetime, (datetime) {
          LogUtil.e("end date time = ${datetime}");
          setState(() {
            this.startTime = datetime;
          });
        });
        break;
      case 14: //证件结束日期
        //日期
        CustomDatePickerUtils.showDatePicker(
            context, "", DateTimePickerMode.datetime, (datetime) {
          LogUtil.e("end date time = ${datetime}");
          setState(() {
            this.endTime = datetime;
          });
        });
        break;
      case 100: //控制人 证件类型
        List currentData = [
          "身份证",
          "护照",
          "香港居民来往内地通行证（回乡证）",
          "澳门居民来往内地通行证（回乡证）",
          "台湾同胞来往内地通行证（台胞证）",
        ];
        CustomBottomSheetWidget.showSelectedBottomSheet(context, currentData,
            (str) {
          setState(() {
            this.controlCertificateTypeStr = str;
          });
        });
        break;
      case 103: //控制人 起始日期
        //日期
        CustomDatePickerUtils.showDatePicker(
            context, "", DateTimePickerMode.datetime, (datetime) {
          LogUtil.e("end date time = ${datetime}");
          setState(() {
            this.controlStartTime = datetime;
          });
        });
        break;
      case 104: //控制人 结束日期
        //日期
        CustomDatePickerUtils.showDatePicker(
            context, "", DateTimePickerMode.datetime, (datetime) {
          LogUtil.e("end date time = ${datetime}");
          setState(() {
            this.controlEndTime = datetime;
          });
        });
        break;
      case 200: //受益人 证件类型
        List currentData = [
          "身份证",
          "护照",
          "香港居民来往内地通行证（回乡证）",
          "澳门居民来往内地通行证（回乡证）",
          "台湾同胞来往内地通行证（台胞证）",
        ];
        CustomBottomSheetWidget.showSelectedBottomSheet(context, currentData,
            (str) {
          setState(() {
            this.beneCertificateTypeStr = str;
          });
        });
        break;
      case 203: //受益人 起始日期
        //日期
        CustomDatePickerUtils.showDatePicker(
            context, "", DateTimePickerMode.datetime, (datetime) {
          LogUtil.e("end date time = ${datetime}");
          setState(() {
            this.beneStartTime = datetime;
          });
        });
        break;
      case 204: //受益人 结束日期
        //日期
        CustomDatePickerUtils.showDatePicker(
            context, "", DateTimePickerMode.datetime, (datetime) {
          LogUtil.e("end date time = ${datetime}");
          setState(() {
            this.beneEndTime = datetime;
          });
        });
        break;
      default:
    }
  }

  ///点击保存并下一步事件
  _didSelectedSaveAndNextAction() {
    FocusScope.of(context).requestFocus(FocusNode());

    NavigatorUtil.push(
        context, BillingInformationPage(merchantType: widget.merchantType));
  }

  //点击图片的事件，调起手机拍照
  _didSelectedCertificationImageAction(LegalPersonInfoImageype imageType) {
    LogUtil.e("${imageType}");

    switch (imageType) {
      case LegalPersonInfoImageype.portraitFace:
        //身份证照片 人像面
        break;
      case LegalPersonInfoImageype.nationalEmblem:
        //身份证照片 国徽面
        break;
      case LegalPersonInfoImageype.controlPortraitFace:
        // 控制人身份证照片 人像面
        break;
      case LegalPersonInfoImageype.controlNationalEmblem:
        //控制人身份证照片 国徽面
        break;
      case LegalPersonInfoImageype.benePortraitFace:
        //受益人身份证照片 人像面
        break;
      case LegalPersonInfoImageype.beneNationalEmblem:
        //受益人身份证照片 国徽面
        break;
      default:
    }
  }

  ///商户入住接口- 法人登记信息-
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
      "legalCardType": "",
      "legalIdCardHeadsPic": "",
      "legalIdCardTailsPic": "",
      "legalName": "",
      "legalIdCardNum": "",
      "legalIdCardExpiry": "",
      "legalMobile": "",
      "controllerCardType": "",
      "controllerIdCardHeadsPic": "",
      "controllerIdCardTailsPic": "",
      "controllerName": "",
      "controllerIdCardNum": "",
      "controllerIdCardExpiry": "",
      "controllerMobile": "",
      "lawyerCardType": "",
      "lawyerIdCardHeadsPic": "",
      "lawyerIdCardTailsPic": "",
      "lawyerName": "",
      "lawyerIdCardNum": "",
      "lawyerIdCardExpiry": "",
      "lawyerMobile": "",
    };
    //商户入驻参数
    Map<String, dynamic> params = {
      "agentId":
          this.agentId != null && this.agentId.length > 0 ? this.agentId : "",
      "applicationId": "", //若type=2-提交商户资料，application_id必填
      "type": 1, //类型：1-保存商户资料；2-提交商户资料
      "merchantType": merchantType, //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType": merchantChildType, //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "legalPersonInfo": subInfoParamsMap,
    };

    LXLEasyLoading.show();
    var response =
        await AgentLegalPersionInfoDao.doAgentLegalPersionInfoData(params);
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
