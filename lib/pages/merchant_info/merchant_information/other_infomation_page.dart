import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/add_merchant_page.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/new_add_merchant_info_page.dart';
import 'package:umpay_crossborder_app/utils/navigator_util.dart';

import '../../../config/lxl_key_define.dart';
import '../../../dao/agent_other_info_dao.dart';
import '../../../model/agent_data_info_model.dart';
import '../../../network/network_message_code.dart';
import '../../../utils/lxl_easy_loading.dart';

//其他界面

typedef CallBack = Function(Object obj);

class OtherInfomationPage extends StatefulWidget {
  MerchantType? merchantType;

  OtherInfomationPage({Key? key, this.merchantType}) : super(key: key);

  @override
  State<OtherInfomationPage> createState() => _OtherInfomationPageState();
}

class _OtherInfomationPageState extends State<OtherInfomationPage> {
  String agentId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LogUtil.e("merchant type ${widget.merchantType}");
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
                "其他信息",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff333333),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          _subAddImageInfoWidget("特殊行业资质证明照片", 0),
          _subAddImageInfoWidget("行业经营许可证照片", 1),
          _subAddImageInfoWidget("其他证明1", 2),
          _subAddImageInfoWidget("其他证明2", 3),
          _subAddImageInfoWidget("其他证明3", 4),
          //保存并下一步
          _bottomSaveAndNextStepWidget(),
        ],
      ),
    );
  }

  //添加照片widget
  _subAddImageInfoWidget(String title, int index) {
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
                LogUtil.e("图片点击了 ${index}");
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

    //跳转新增商户界面
    NavigatorUtil.push(
        context, NewAddMerchantInfoPage(merchantType: widget.merchantType));
  }

  ///商户入住接口- 其他信息
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
      "industryQualificationImg": "",
      "operationCopyImg": "",
      "elseImg1": "",
      "elseImg2": "",
      "elseImg3": "",
    };
    //商户入驻参数
    Map<String, dynamic> params = {
      "agentId":
          this.agentId != null && this.agentId.length > 0 ? this.agentId : "",
      "applicationId": "", //若type=2-提交商户资料，application_id必填
      "type": 1, //类型：1-保存商户资料；2-提交商户资料
      "merchantType": merchantType, //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType": merchantChildType, //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "elseInfo": subInfoParamsMap,
    };

    LXLEasyLoading.show();
    var response = await AgentOtherInfoDao.doAgentOtherInfoData(params);
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
