import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/add_merchant_page.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/other_infomation_page.dart';
import 'package:umpay_crossborder_app/utils/navigator_util.dart';

import '../../../config/lxl_key_define.dart';
import '../../../dao/agent_edit_rate_info_dao.dart';
import '../../../model/agent_data_info_model.dart';
import '../../../network/network_message_code.dart';
import '../../../utils/lxl_easy_loading.dart';

//编辑费率界面

typedef CallBack = Function(Object obj);

class EditRatePage extends StatefulWidget {
  MerchantType? merchantType;

  EditRatePage({Key? key, this.merchantType}) : super(key: key);

  @override
  State<EditRatePage> createState() => _EditRatePageState();
}

class _EditRatePageState extends State<EditRatePage> {
  List currentData = [
    {
      "title": "支付宝费率",
      "rate": "0.0038",
    },
    {
      "title": "云闪付借记费率（小于等于1000元）",
      "rate": "0.0038",
    },
    {
      "title": "云闪付借记（小于等于1000元）封顶值",
      "rate": "18.75",
    },
    {
      "title": "云闪付贷记费率（小于等于1000元）",
      "rate": "0.0038",
    },
  ];

  String agentId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String title = "支付宝费率";
    LogUtil.e("${title.length}");

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
      body: CustomScrollView(
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
                "编辑费率",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff333333),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          //码费率
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  // height: 300,
                  // decoration: BoxDecoration(
                  color: Colors.white,
                  //   borderRadius: BorderRadius.circular(8),
                  // ),
                  child: index == 0
                      ? Container(
                          // color: Colors.red,
                          margin: EdgeInsets.fromLTRB(12, 12, 0, 0),
                          child: Text(
                            "码费率",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff303133),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : (this.currentData[index - 1]["title"] != null &&
                              this.currentData[index - 1]["title"].length > 6
                          ? _longCodeRateSubWidget(
                              this.currentData[index - 1]["title"], index - 1)
                          : _shortCodeRateSubWidget(
                              this.currentData[index - 1]["title"], index - 1)),
                );
              },
              childCount: this.currentData.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
            ),
          ),
          //卡费率
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  // height: 300,
                  // decoration: BoxDecoration(
                  color: Colors.white,
                  //   borderRadius: BorderRadius.circular(8),
                  // ),
                  child: index == 0
                      ? Container(
                          // color: Colors.red,
                          margin: EdgeInsets.fromLTRB(12, 12, 0, 0),
                          child: Text(
                            "卡费率",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff303133),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : (this.currentData[index - 1]["title"] != null &&
                              this.currentData[index - 1]["title"].length > 6
                          ? _longCodeRateSubWidget(
                              this.currentData[index - 1]["title"], index - 1)
                          : _shortCodeRateSubWidget(
                              this.currentData[index - 1]["title"], index - 1)),
                );
              },
              childCount: this.currentData.length,
            ),
          ),
          //保存并下一步
          _bottomSaveAndNextStepWidget(),
        ],
      ),
    );
  }

  //短码率子组件
  _shortCodeRateSubWidget(String title, int index) {
    return Container(
      height: 55,
      margin: EdgeInsets.fromLTRB(12, 5, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Container(
            child: Row(
              children: [
                Container(
                  child: Text(
                    "*",
                    style: TextStyle(
                      color: Color(0xffFF5B5D),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Text(
                    "${title}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff222222),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ))
              ],
            ),
          )),
          _calculateSubWidget(index),
        ],
      ),
    );
  }

  //长码率子组件
  _longCodeRateSubWidget(String title, int index) {
    return Container(
      // height: 55,
      margin: EdgeInsets.fromLTRB(12, 5, 0, 0),
      // color: Colors.purple,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
            // height: 24,
            // color: Colors.cyan,
            child: Row(
              children: [
                Container(
                  child: Text(
                    "*",
                    style: TextStyle(
                      color: Color(0xffFF5B5D),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "${title}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff222222),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            alignment: Alignment.centerRight,
            child: _calculateSubWidget(index),
          ),
        ],
      ),
    );
  }

  //计算子组件
  _calculateSubWidget(int index) {
    return Container(
      width: 210,
      // color: Colors.red,
      margin: EdgeInsets.fromLTRB(0, 0, 8.5, 0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              LogUtil.e("减号 --- 点击了 ： ${index}");
            },
            child: Container(
              child: Image.asset("images/sh_app_edit_rate_reduce.png",
                  fit: BoxFit.cover),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 0.5, //宽度
                      color: Color(0xffE9E9E9), //边框颜色
                    ),
                    bottom: BorderSide(
                      width: 0.5, //宽度
                      color: Color(0xffE9E9E9), //边框颜色
                    ),
                  ),
                ),
                child: Text(
                  // "0.0038",
                  this.currentData[index]["rate"],
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )),
          InkWell(
            onTap: () {
              LogUtil.e("加号 +++++ 点击了 ： ${index}");
            },
            child: Container(
              child: Image.asset("images/sh_app_edit_rate_add.png",
                  fit: BoxFit.cover),
            ),
          ),
        ],
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
  }

  //点击保存并下一步事件
  _didSelectedSaveAndNextAction() {
    FocusScope.of(context).requestFocus(FocusNode());

    //跳转其他信息界面
    NavigatorUtil.push(
        context, OtherInfomationPage(merchantType: widget.merchantType));
  }

  ///商户入住接口- 营业执照信息
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
      "rateInfo": subInfoParamsMap,
    };

    LXLEasyLoading.show();
    var response =
        await AgentEditRateInfoDao.doAgentEditRateInfoData(
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
