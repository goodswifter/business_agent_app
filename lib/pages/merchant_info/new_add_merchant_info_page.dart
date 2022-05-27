import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:umpay_crossborder_app/dao/agent_new_add_merchant_info_dao.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/add_merchant_page.dart';
import 'package:umpay_crossborder_app/pages/tabs/tab_page.dart';
import 'package:umpay_crossborder_app/widget/lxl_alert_custom_dialog.dart';
import 'package:umpay_crossborder_app/widget/lxl_alert_single_dialog.dart';

import '../../config/lxl_key_define.dart';
import '../../model/agent_data_info_model.dart';
import '../../network/network_message_code.dart';
import '../../utils/lxl_easy_loading.dart';

//新增商户界面
typedef CallBack = Function(Object obj);

class NewAddMerchantInfoPage extends StatefulWidget {
  MerchantType? merchantType;

  NewAddMerchantInfoPage({Key? key, this.merchantType}) : super(key: key);

  @override
  State<NewAddMerchantInfoPage> createState() => _NewAddMerchantInfoPageState();
}

class _NewAddMerchantInfoPageState extends State<NewAddMerchantInfoPage> {
  String agentId = "";

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
                "新增商户",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff333333),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(27, 20, 0, 15),
              child: Text(
                "请根据商户证件，选择对应的进件通道",
                style: TextStyle(
                  color: Color(0xff999999),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          //商户基本信息、店铺信息、营业执照信息、法人信息
          _addMerchantInfoListWidget(),
          //结算信息、费率信息
          _addMerchantMiddleInfoWidget(),
          //添加其他信息
          _addMerchantOtherInfoWidget(),
          SliverToBoxAdapter(
            child: Container(
              child: Row(
                children: [
                  // Expanded(
                  //   child: Container(
                  //     height: 45,
                  //     margin: EdgeInsets.fromLTRB(48, 38, 48, 0),
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //       color: Color(0xffFFADAE),
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: Text(
                  //       "保存",
                  //       style: TextStyle(
                  //         color: Color(0xffffffff),
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _didSelectedSubmitAction();
                      },
                      child: Container(
                        height: 45,
                        margin: EdgeInsets.fromLTRB(48, 38, 48, 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xffFF5B5D),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "提交",
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //新增商户信息列表
  _addMerchantInfoListWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
        // height: 224,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            _subMerchantInfoWiget("商户基本信息", "待填写"),
            _subLineWidget(),
            _subMerchantInfoWiget("店铺信息", "待填写"),
            _subLineWidget(),
            _subMerchantInfoWiget("营业执照信息", "待填写"),
            _subLineWidget(),
            _subMerchantInfoWiget("法人信息", "待填写"),
          ],
        ),
      ),
    );
  }

  //添加结算信息、费率信息
  _addMerchantMiddleInfoWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(12, 8, 12, 12),
        // height: 224,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            _subMerchantInfoWiget("结算信息", "待填写"),
            _subLineWidget(),
            _subMerchantInfoWiget("费率信息", "待填写"),
          ],
        ),
      ),
    );
  }

  //添加其他信息
  _addMerchantOtherInfoWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(12, 8, 12, 12),
        // height: 224,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            _subMerchantInfoWiget("其他信息", "待填写"),
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
  _subMerchantInfoWiget(String title, String promptInfo) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
      height: 55,
      // color: Colors.purple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
          Container(
            child: Row(
              children: [
                Container(
                  // child: Text("待填写"),
                  child: Text(
                    "${promptInfo}",
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Image.asset("images/sh_app_more_right_1.png",
                      fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///点击提交按钮的事件
  _didSelectedSubmitAction() {
    LXLAlertCustomDialog.showAlertDialog(context, "新增商户", "是否提交商户资料", (value) {
      if (value == 0) {
        LogUtil.e("cancel");
      } else if (value == 1) {
        LogUtil.e("comfirm");

        LXLAlertSingleDialog.showAlertDialog(
            context, "新增商户", "该商户资料已提交，可前往商户-商户审核查看审核结果", "我知道了", (value) {
          if (value == 1) {
            //返回到根-进入首页
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => TabPage(indexPage: 0)),
                (route) => route == null);
          }
        });
      }
    });
  }

  ///商户入住接口- 提交信息
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
      // "industryQualificationImg": "",
      // "operationCopyImg": "",
      // "elseImg1": "",
      // "elseImg2": "",
      // "elseImg3": "",
    };
    //商户入驻参数
    Map<String, dynamic> params = {
      "agentId":
          this.agentId != null && this.agentId.length > 0 ? this.agentId : "",
      "applicationId": "", //若type=2-提交商户资料，application_id必填
      "type": 2, //类型：1-保存商户资料；2-提交商户资料  //提交信息
      "merchantType": merchantType, //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType": merchantChildType, //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "elseInfo": subInfoParamsMap,
    };

    LXLEasyLoading.show();
    var response = await AgentSubmitInfoDao.doAgentSubmitInfoData(params);
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
