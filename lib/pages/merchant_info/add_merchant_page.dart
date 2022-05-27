import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/merchant_basic_information/merchant_basic_information_page.dart';
import 'package:umpay_crossborder_app/services/EventBus.dart';
import 'package:umpay_crossborder_app/utils/lxl_screen.dart';
import 'package:umpay_crossborder_app/utils/navigator_util.dart';
import 'package:umpay_crossborder_app/widget/lxl_alert_custom_dialog.dart';

/// 新增商户界面

/// 商户类型
enum MerchantType {
  /// 小微商户
  smallAndMicro,

  /// 个体户
  selfEmployed,

  /// 企事业 - 普通企业
  commonEnterprise,

  /// 事业单位
  businessUnit,

  /// 其他组织
  otherOrganizations,
}

class AddMerchantPage extends StatefulWidget {
  const AddMerchantPage({Key? key}) : super(key: key);

  @override
  State<AddMerchantPage> createState() => _AddMerchantPageState();
}

class _AddMerchantPageState extends State<AddMerchantPage> {
  @override
  void initState() {
    super.initState();

    if (mounted) {
      _eventBusdDidPushNextPageAction();
    }
  }

  ///注册eventBus  跳转下一个界面 事件广播事件
  _eventBusdDidPushNextPageAction() {
    eventBus.on<MerchantAlertEvent>().listen((event) {
      LogUtil.e("event bus index :${event.index}");
      if (!mounted) return;

      ///跳转相应的界面
      _jumpToPagesWithEventAction(event.index);
    });
  }

  ///借助eventbus 跳转相应的界面
  _jumpToPagesWithEventAction(int index) {
    MerchantType type = MerchantType.smallAndMicro;

    switch (index) {
      case 0: //小微商户跳转
        type = MerchantType.smallAndMicro;
        // //跳转 商户信息界面
        // NavigatorUtil.push(
        //     context,
        //     MerchantBasicInfomationPage(
        //         merchantType: MerchantType.smallAndMicro));

        break;
      case 1: //个体户跳转
        type = MerchantType.selfEmployed;
        break;
      case 2: //普通企业跳转
        type = MerchantType.commonEnterprise;
        break;
      case 3: //事业单位跳转
        type = MerchantType.businessUnit;
        break;
      case 4: //其他组织跳转
        type = MerchantType.otherOrganizations;
        break;
      default:
    }

    LogUtil.e("type : $type");

    //跳转 商户信息界面
    NavigatorUtil.push(
        context, MerchantBasicInfomationPage(merchantType: type));

    // //跳转 新增商户信息列表界面
    // NavigatorUtil.push(context, NewAddMerchantInfoPage());
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
            title: const Text(
              "新增商户",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff333333),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(32, 30, 0, 14),
              child: const Text(
                "请根据商户证件，选择对应的进件通道",
                style: TextStyle(
                  color: Color(0xff999999),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          //小微商户
          _smallAndMicroMerchantsWidget(),
          //个体户
          _selfEmployedMerchantWidget(),
          //企事业
          _enterpriseMerchantWidget(),
        ],
      ),
    );
  }

  //小微商户
  _smallAndMicroMerchantsWidget() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _didSmallAndMicroMerchantsAlertAction();
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: 80,
          width: LXLScreen.width,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "小微商户",
                    style: TextStyle(
                      color: Color(0xff393939),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "仅有身份证的商户",
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )),
              Image.asset("images/icon_right.png", fit: BoxFit.cover),
            ],
          ),
        ),
      ),
    );
  }

  //个体户
  _selfEmployedMerchantWidget() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _didSelfEmployedMerchantAlertAction();
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: 80,
          width: LXLScreen.width,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "个体户",
                    style: TextStyle(
                      color: Color(0xff393939),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "营业执照主体类型一般为个体户、个体经营",
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )),
              Image.asset("images/sh_app_add_merchant_image_1.png",
                  fit: BoxFit.cover),
            ],
          ),
        ),
      ),
    );
  }

  //企事业
  _enterpriseMerchantWidget() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _didEnterpriseMerchantAlertAction();
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: 80,
          width: LXLScreen.width,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "企事业",
                    style: TextStyle(
                      color: Color(0xff393939),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "营业执照主体类型一般为有限公司、有限责任公司、个体经营",
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Image.asset("images/icon_right.png", fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //点击小微企业alert事件
  _didSmallAndMicroMerchantsAlertAction() {
    LXLAlertCustomDialog.showMerchantAlertDialog(context, "小微商户", "以下资料是否已收集",
        (value) {
      if (value == 0) {
        LogUtil.e("取消");
        // Navigator.of(context).pop();

      } else {
        LogUtil.e("确定");

        //跳转下一个界面
        eventBus.fire(MerchantAlertEvent(0));
      }
    });
  }

  //点击个体户alert事件
  _didSelfEmployedMerchantAlertAction() {
    LXLAlertCustomDialog.showSelfEmployedAlertDialog(
        context, "个体户", "以下资料是否已收集", (value) {
      if (value == 0) {
        LogUtil.e("取消");
      } else {
        LogUtil.e("确定");
        //跳转下一个界面
        eventBus.fire(MerchantAlertEvent(1));
      }
    });
  }

  ///点击企事业alert事件 ---  第一次弹框alert
  _didEnterpriseMerchantAlertAction() {
    LXLAlertCustomDialog.showEnterpriseAlertDialog(
        context, "企事业商户", "以下资料是否已收集", (int value) {
      //这里的取消和确定暂时没用
      if (value == 0) {
        LogUtil.e("取消");
      } else {
        LogUtil.e("确定");
      }
    }, (int index) {
      //点击普通企业-1，事业单位-2，其他组织-3
      LogUtil.e("点击企事业商户回调  index : $index");
      _alertEnterpriseInfo(index);
    });
  }

  //弹出企业信息 --- 第二次弹框alert
  _alertEnterpriseInfo(int index) {
    switch (index) {
      case 1:
        //普通企业
        LXLAlertCustomDialog.alertEnterprisePromptInfoDialog(
            context, "普通企业商户", "以下资料是否已收集", 1, (value) {
          if (value == 0) {
            LogUtil.e("取消");
          } else {
            LogUtil.e("确定");
            // 跳转下一个界面
            eventBus.fire(MerchantAlertEvent(2));
          }
        });
        break;
      case 2:
        // 事业单位;
        LXLAlertCustomDialog.alertEnterprisePromptInfoDialog(
            context, "事业单位商户", "以下资料是否已收集", 2, (value) {
          if (value == 0) {
            LogUtil.e("取消");
          } else {
            LogUtil.e("确定");
            // 跳转下一个界面
            eventBus.fire(MerchantAlertEvent(3));
          }
        });
        break;
      case 3:
        //其他组织
        LXLAlertCustomDialog.alertEnterprisePromptInfoDialog(
            context, "其他组织商户", "以下资料是否已收集", 2, (value) {
          if (value == 0) {
            LogUtil.e("取消");
          } else {
            LogUtil.e("确定");
            //跳转下一个界面
            eventBus.fire(MerchantAlertEvent(4));
          }
        });
        break;
      default:
    }
  }
}
