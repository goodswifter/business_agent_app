import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/add_merchant_page.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/edit_rate_page.dart';
import 'package:umpay_crossborder_app/utils/billing_color_utils.dart';
import 'package:umpay_crossborder_app/utils/city_pickers_utils.dart';
import 'package:umpay_crossborder_app/utils/custom_date_picker_utils.dart';
import 'package:umpay_crossborder_app/utils/lxl_easy_loading.dart';
import 'package:umpay_crossborder_app/utils/navigator_util.dart';
import 'package:umpay_crossborder_app/widget/custom_bottom_sheet_widget.dart';

import '../../../config/lxl_key_define.dart';
import '../../../dao/agent_billing_info_dao.dart';
import '../../../model/agent_data_info_model.dart';
import '../../../network/network_message_code.dart';

//结算信息界面

typedef CallBack = Function(Object obj);

//结算页面图片类型 image
enum BillingInfoImageType {
  /// 开户许可证
  openingPermit,

  /// 结算卡照片
  billingCardPhoto,

  /// 结算人身份证照片 人像面
  portraitFace,

  /// 结算人身份证照片 国徽面
  nationalEmblem,

  /// 非法人结算授权函
  unincorporatedSettlementAuthorization,
}

class BillingInformationPage extends StatefulWidget {
  MerchantType? merchantType;

  BillingInformationPage({Key? key, this.merchantType}) : super(key: key);

  @override
  State<BillingInformationPage> createState() => _BillingInformationPageState();
}

class _BillingInformationPageState extends State<BillingInformationPage> {
  bool isControlYes = true;
  bool isControldNo = false;
  //是否展示show 对公结算widget
  bool isShowPublic = true;
  //是否展示show 对私结算widget
  bool isShowPrivate = false;

  //控制是否法人
  bool isLegalPersonYes = true;
  bool isLegalPersonNo = false;
  //是否展示show 法人widget
  bool isShowLegal = true;
  //是否展示show 非法人widget
  bool isShowUnlawful = false;

  //账户名称
  final _accountNameController = TextEditingController();
  //账号
  final _accountNumberController = TextEditingController();
  //开户行
  final _openBankController = TextEditingController();
  //开户行城市
  final _openBankCityController = TextEditingController();
  //开户行支行
  final _openBankBranchController = TextEditingController();
  //非法人-结算人证件类型
  final _cardIDTypeController = TextEditingController();
  //结算人姓名
  final _settlementNameController = TextEditingController();
  //结算人证件号
  final _settlementCardIDController = TextEditingController();
  //结算人证件有效期
  final _settlementValidityController1 = TextEditingController();
  final _settlementValidityController2 = TextEditingController();

  String accountNameStr = "";
  String accountStr = "";
  String accountBankStr = "";
  String accountBankCityStr = "";
  String accountOpeningBranchStr = "";
  String certificateTypeStr = "";
  String billingNameStr = "";
  String billingNumberStr = "";
  String billingStartTimeStr = "";
  String billingEndTimeStr = "";

  String agentId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LogUtil.e("结算信息页面 merchant type : ${widget.merchantType}");
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
        cursorColor: const Color(0x222222), //光标颜色
        cursorWidth: 1,
        cursorHeight: 15.0,
        style: const TextStyle(
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
            color: Color(BillingColorUtils.getChooseItemSelectedColor(
                accountNameStr,
                accountStr,
                accountBankStr,
                accountBankCityStr,
                accountOpeningBranchStr,
                certificateTypeStr,
                billingNameStr,
                billingNumberStr,
                billingStartTimeStr,
                billingEndTimeStr,
                selectedIndex)),
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                child: const Text(
                  "结算信息",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            //账户类型
            _addAccountTypeWidget(),
            //对公结算
            _subCorporateSettlementWidget(),
            //对私结算
            _subPrivateSettlementWidget(),
            //保存并下一步
            _bottomSaveAndNextStepWidget(),
          ],
        ),
      ),
    );
  }

  ///账户类型
  _addAccountTypeWidget() {
    return SliverToBoxAdapter(
      child: Visibility(
        visible: true,
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          // height: 224,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SizedBox(
            height: 55,
            // alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  // width: 100,
                  // color: Colors.cyan,
                  margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Row(
                    children: [
                      Visibility(
                        visible: true,
                        child: Container(
                          child: const Text(
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
                        child: const Text(
                          // title,
                          "账户类型",
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
                    LogUtil.e("--对公-是点击了");

                    setState(() {
                      isControlYes = true;
                      isControldNo = false;
                      isShowPublic = true;
                      isShowPrivate = false;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(66, 0, 0, 0),
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(
                            // "images/sh_app_choose_selected_image.png",
                            isControlYes == true && isControldNo == false
                                ? "images/sh_app_choose_selected_image.png"
                                : "images/sh_app_choose_no_selected_image.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                          child: const Text(
                            "对公结算",
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
                    LogUtil.e("---对私-- 点击了");

                    setState(() {
                      isControlYes = false;
                      isControldNo = true;
                      isShowPublic = false;
                      isShowPrivate = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(
                            // "images/sh_app_choose_no_selected_image.png",
                            isControldNo == true && isControlYes == false
                                ? "images/sh_app_choose_selected_image.png"
                                : "images/sh_app_choose_no_selected_image.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                          child: const Text(
                            "对私结算",
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

  //对公结算widget
  _subCorporateSettlementWidget() {
    return SliverToBoxAdapter(
      child: Visibility(
        visible: isShowPublic == true && isShowPrivate == false ? true : false,
        child: Column(
          children: [
            _openingPermitSubWidget("开户许可证"),
            //添加开户行
            _addCorporateSettlemenWidget(true),
          ],
        ),
      ),
    );
  }

  ///开户许可证
  _openingPermitSubWidget(String title) {
    return Container(
      height: 148,
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(12, 15, 0, 10),
            // width: 100,
            height: 24,
            // color: Colors.cyan,
            child: Row(
              children: [
                const Visibility(
                  visible: true,
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
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff222222),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _didSelectedBillingImageAction(
                  BillingInfoImageType.openingPermit);
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: Image.asset(
                "images/sh_app_add_upload_image.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //添加对公结算信息（账户名称、账号、开户行、开户行城市、开户行支行）
  _addCorporateSettlemenWidget(bool isShowAccountName) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      // height: 224,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Visibility(
              visible: isShowAccountName,
              child: _subMerchantInfoWiget(_accountNameController, "请输入账户名称",
                  true, "账户名称", true, false, 0, TextInputType.text)),
          _subLineWidget(),
          _subMerchantInfoWiget(_accountNumberController, "请输入结算账户", true, "账号",
              true, false, 1, TextInputType.text),
          _subLineWidget(),
          _subMerchantInfoWiget(
              _openBankController,
              accountBankStr.isNotEmpty ? accountBankStr : "请选择开户行",
              true,
              "开户行",
              false,
              true,
              2,
              TextInputType.text),
          _subLineWidget(),
          _subMerchantInfoWiget(
              _openBankCityController,
              accountBankCityStr.isNotEmpty ? accountBankCityStr : "请选择开户行城市",
              true,
              "开户行城市",
              false,
              true,
              3,
              TextInputType.text),
          _subLineWidget(),
          _subMerchantInfoWiget(
              _openBankBranchController,
              accountOpeningBranchStr.isNotEmpty
                  ? accountOpeningBranchStr
                  : "请选择开户行支行",
              true,
              "开户行支行",
              false,
              true,
              4,
              TextInputType.text),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////

  ///对私结算widget
  _subPrivateSettlementWidget() {
    return SliverToBoxAdapter(
      child: Visibility(
        visible: isShowPrivate == true && isShowPublic == false ? true : false,
        child: Container(
          child: Column(
            children: [
              //结算卡类型
              _addSettlementCardTypeWidget(),
              //添加法人 sub widget
              _addLegalPersonSubWidget(),
              //添加非法人 sub widget
              _addUnlawfulPersonSubWidget(),
            ],
          ),
        ),
      ),
    );
  }

  //添加结算卡类型
  _addSettlementCardTypeWidget() {
    return Visibility(
      visible: true,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        // height: 224,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          height: 55,
          // alignment: Alignment.center,
          child: Row(
            children: [
              Container(
                // width: 100,
                // color: Colors.cyan,
                margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Row(
                  children: const [
                    Visibility(
                      visible: true,
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
                    Text(
                      // title,
                      "结算卡类型",
                      style: TextStyle(
                        color: Color(0xff222222),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  LogUtil.e("--法人-是点击了");

                  setState(() {
                    isLegalPersonYes = true;
                    isLegalPersonNo = false;
                    isShowLegal = true;
                    isShowUnlawful = false;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(55, 0, 0, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        // "images/sh_app_choose_selected_image.png",
                        isLegalPersonYes == true && isLegalPersonNo == false
                            ? "images/sh_app_choose_selected_image.png"
                            : "images/sh_app_choose_no_selected_image.png",
                        fit: BoxFit.cover,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: const Text(
                          "法人",
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
                  LogUtil.e("---非法人-- 点击了");

                  setState(() {
                    isLegalPersonYes = false;
                    isLegalPersonNo = true;
                    isShowLegal = false;
                    isShowUnlawful = true;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(58, 0, 0, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        // "images/sh_app_choose_no_selected_image.png",
                        isLegalPersonNo == true && isLegalPersonYes == false
                            ? "images/sh_app_choose_selected_image.png"
                            : "images/sh_app_choose_no_selected_image.png",
                        fit: BoxFit.cover,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: const Text(
                          "非法人",
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
    );
  }

  ///法人widget 子组件
  _addLegalPersonSubWidget() {
    return Visibility(
      visible: isShowLegal && !isShowUnlawful,
      child: Column(
        children: [
          _settlementCardImageSubWidget("结算卡照片（带卡号）"),
          _addCorporateSettlemenWidget(true),
        ],
      ),
    );
  }

  // 结算卡照片（带卡号）
  _settlementCardImageSubWidget(String title) {
    return Container(
      height: 148,
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(12, 15, 0, 10),
            // width: 100,
            height: 24,
            // color: Colors.cyan,
            child: Row(
              children: [
                const Visibility(
                  visible: true,
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
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff222222),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _didSelectedBillingImageAction(
                  BillingInfoImageType.billingCardPhoto);
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: Image.asset(
                "images/sh_app_add_upload_image.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///非法人widget 子组件
  _addUnlawfulPersonSubWidget() {
    return Visibility(
      visible: isShowLegal == false && isShowUnlawful == true ? true : false,
      child: Column(
        children: [
          //证件类型
          _addCadrdIDTypeWidget(),
          _subAddCardIDImageInfoWidget("结算人身份证照片", true),
          //结算人信息 -- 结算人姓名、结算人证件号、控制人证件有效期
          _addLegalPersonBasicInformationWidget(),
          _settlementCardImageSubWidget("结算卡照片（带卡号）"),
          //非法人结算授权函
          _unincorporatedSettlementAuthorizationLetterImageSubWidget(
              "非法人结算授权函"),
          //添加开户行
          _addCorporateSettlemenWidget(false),
        ],
      ),
    );
  }

  //添加证件类型
  _addCadrdIDTypeWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      // height: 224,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _subMerchantInfoWiget(
              _cardIDTypeController,
              certificateTypeStr.isNotEmpty ? certificateTypeStr : "请选择",
              true,
              "结算人证件类型",
              false,
              true,
              999,
              TextInputType.text),
        ],
      ),
    );
  }

  //添加身份证图片
  _subAddCardIDImageInfoWidget(String title, bool isShowStar) {
    return Container(
      height: 148,
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(12, 15, 0, 10),
            // width: 100,
            height: 24,
            // color: Colors.cyan,
            child: Row(
              children: [
                Visibility(
                  visible: true,
                  child: Text(
                    isShowStar == true ? "*" : "  ",
                    style: const TextStyle(
                      color: Color(0xffFF5B5D),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff222222),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  _didSelectedBillingImageAction(
                      BillingInfoImageType.portraitFace);
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Image.asset(
                    "images/sh_app_card_id_image_1.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _didSelectedBillingImageAction(
                      BillingInfoImageType.nationalEmblem);
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Image.asset(
                    "images/sh_app_card_id_image_2.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //结算人信息 -- 结算人姓名、结算人证件号、控制人证件有效期
  _addLegalPersonBasicInformationWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      // height: 224,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _subMerchantInfoWiget(_settlementNameController, "请输入结算人姓名", true,
              "结算人姓名", true, false, 100, TextInputType.text),
          _subLineWidget(),
          _subMerchantInfoWiget(_settlementCardIDController, "请输入结算人证件号", true,
              "结算人证件号", true, false, 101, TextInputType.text),
          _subLineWidget(),
          _subMerchantInfoWiget(
              _settlementValidityController1,
              billingStartTimeStr.isNotEmpty
                  ? billingStartTimeStr
                  : "请选择有效期起始日",
              true,
              "结算人证件有效期",
              false,
              true,
              102,
              TextInputType.text),
          _subLineWidget(),
          _subMerchantInfoWiget(
              _settlementValidityController2,
              billingEndTimeStr.isNotEmpty ? billingEndTimeStr : "请选择有效期截止日",
              false,
              "",
              false,
              true,
              103,
              TextInputType.text),
        ],
      ),
    );
  }

  //非法人结算授权函
  _unincorporatedSettlementAuthorizationLetterImageSubWidget(String title) {
    return Container(
      height: 148,
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(12, 15, 0, 10),
            // width: 100,
            height: 24,
            // color: Colors.cyan,
            child: Row(
              children: [
                const Visibility(
                  visible: true,
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
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff222222),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _didSelectedBillingImageAction(
                  BillingInfoImageType.unincorporatedSettlementAuthorization);
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: Image.asset(
                "images/sh_app_add_upload_image.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ////////////******以下是布局子组件的widget部分******//////////////

  //线条
  _subLineWidget() {
    return Container(
      height: 0.5,
      color: const Color(0xffE9E9E9),
      margin: const EdgeInsets.fromLTRB(12, 0, 6, 0),
    );
  }

  //计算结算人信息的title宽度，防止越界
  _calculateLayoutAction(int value) {
    if (value == 999) {
      return 120.0;
    } else if (value == 100) {
      return 130.0;
    } else if (value == 101) {
      return 130.0;
    } else if (value == 102) {
      return 130.0;
    } else if (value == 103) {
      return 130.0;
    } else {
      return 100.0;
    }
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
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        height: 55,
        // color: Colors.purple,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: _calculateLayoutAction(didSelectedIndex),
              child: Row(
                children: [
                  Visibility(
                    visible: true,
                    child: Text(
                      // "*",
                      isShowStar == true ? "*" : "  ",
                      style: const TextStyle(
                        color: Color(0xffFF5B5D),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xff222222),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                // color: Colors.red,
                padding: const EdgeInsets.only(right: 10),
                child: buildTextField(controller, hintText, isEnableSelected,
                    false, textInputType, didSelectedIndex),
                // child: buildTextField(controller, "请输入真实姓名", true,
                //     false, TextInputType.number),
              ),
            ),
            Visibility(
                visible: isShowRight, //true,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Image.asset("images/sh_app_more_right_1.png",
                      fit: BoxFit.cover),
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
          margin: const EdgeInsets.fromLTRB(48, 28, 48, 47),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xffFF5B5D),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
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
    LogUtil.e("title : $title , selectedIndex : $selectedIndex");
    FocusScope.of(context).requestFocus(FocusNode());

    switch (selectedIndex) {
      case 2: //开户行
        List currentData = [
          "中国银行",
          "中国建设银行",
          "中国工商银行",
        ];
        CustomBottomSheetWidget.showSelectedBottomSheet(context, currentData,
            (str) {
          LogUtil.e("开户行 $str");
          accountBankStr = str;
        });
        break;
      case 3: //开户行城市
        //展示三级联动
        CityPickersUtils.showCityPicker(context, (result) {
          LogUtil.e("city result : $result");

          //后期需要城市码取城市码

          // city result : {"provinceName":"北京市","provinceId":"110000",
          //"cityName":"北京城区","cityId":"110100",
          //"areaName":"东城区","areaId":"110101" }

          if (result != null) {
            // this.accountBankCityStr =
            //     "${result.provinceName}${result.cityName}${result.areaName}";

            //city result : {province: 河北省, city: 石家庄市, area: 长安区,
            //provinceCode: 130000, cityCode: 130100, areaCode: 130102}
            accountBankCityStr =
                "${result["province"]}${result["city"]}${result["area"]}";
          } else {
            accountBankCityStr = "";
          }
          setState(() {});
        });
        break;
      case 4: //开户行支行
        List currentData = [
          "中国银行石景山支行",
          "中国建设银行朝阳支行",
          "中国工商银行丰台支行",
        ];
        CustomBottomSheetWidget.showSelectedBottomSheet(context, currentData,
            (str) {
          LogUtil.e("开户行 $str");
          accountOpeningBranchStr = str;
        });
        break;
      case 102: //结算人证件有效期 起始日期
        //日期
        CustomDatePickerUtils.showDatePicker(
            context, "", DateTimePickerMode.datetime, (datetime) {
          LogUtil.e("end date time = $datetime");
          setState(() {
            billingStartTimeStr = datetime;
          });
        });
        break;
      case 103: //结算人证件有效期 结束日期
        //日期
        CustomDatePickerUtils.showDatePicker(
            context, "", DateTimePickerMode.datetime, (datetime) {
          LogUtil.e("end date time = $datetime");
          setState(() {
            billingEndTimeStr = datetime;
          });
        });
        break;
      case 999: //结算人证件类型
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
            certificateTypeStr = str;
          });
        });
        break;
      default:
    }
  }

  //点击结算页面 图片对应的时间
  _didSelectedBillingImageAction(BillingInfoImageType imageType) {
    LogUtil.e("image type : $imageType");

    switch (imageType) {
      case BillingInfoImageType.openingPermit:
        //开户许可证
        break;
      case BillingInfoImageType.billingCardPhoto:
        // 结算卡照片
        break;
      case BillingInfoImageType.portraitFace:
        // 结算人身份证照片 人像面
        break;
      case BillingInfoImageType.nationalEmblem:
        // 结算人身份证照片 国徽面
        break;

      case BillingInfoImageType.unincorporatedSettlementAuthorization:
        // 非法人结算授权函
        break;
      default:
    }
  }

  //点击保存并下一步事件
  _didSelectedSaveAndNextAction() {
    FocusScope.of(context).requestFocus(FocusNode());

    NavigatorUtil.push(
        context, EditRatePage(merchantType: widget.merchantType));
  }

  ///商户入住接口- 结算信息信息-
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
     "accountType": "",
      "cardType": "",
      "settleCardType": "",
      "settleIdCardHeadsPic": "",
      "settleIdCardTailsPic": "",
      "settleName": "",
      "settleIdCardNum": "",
      "settleIdCardExpiry": "",
      "bankCardPic": "",
      "authorCertificatePic": "",
      "bankNo": "",
      "openBank": "",
      "openBankCity": "",
      "bankAccountOpeningCertificate": "",
      "bankBrhName": "",
    };
    //商户入驻参数
    Map<String, dynamic> params = {
      "agentId":
          this.agentId != null && this.agentId.length > 0 ? this.agentId : "",
      "applicationId": "", //若type=2-提交商户资料，application_id必填
      "type": 1, //类型：1-保存商户资料；2-提交商户资料
      "merchantType": merchantType, //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType": merchantChildType, //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "settleInfo": subInfoParamsMap,
    };

    LXLEasyLoading.show();
    var response =
        await AgentBilllingInfoDao.doAgentBillingInfoData(params);
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
