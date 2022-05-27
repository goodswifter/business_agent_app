import 'package:flutter/material.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_review_info_page.dart';
import 'package:umpay_crossborder_app/utils/navigator_util.dart';

//商户界面

class MerchantInfoPage extends StatefulWidget {
  const MerchantInfoPage({Key? key}) : super(key: key);

  @override
  State<MerchantInfoPage> createState() => _MerchantInfoPageState();
}

class _MerchantInfoPageState extends State<MerchantInfoPage> {
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
            // leading: IconButton(
            //   icon: Image.asset(
            //     "images/navi_back_images.png",
            //     fit: BoxFit.cover,
            //     // color: Colors.white,
            //   ),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
            //自定义title
            title: Container(
              child: Text(
                "商户",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff333333),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          //商户审核widget
          _addMerchantReviewSubWidget(),
        ],
      ),
    );
  }

  ///添加商户审核item widget
  _addMerchantReviewSubWidget() {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: () {
          //跳转商户审核界面
          NavigatorUtil.push(context, MerchantReviewInfoPage());
        },
        child: Container(
          height: 108,
          margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
          padding: EdgeInsets.fromLTRB(21.5, 0, 0, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  "images/sh_app_merchant_review_image.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Text(
                  "商户审核",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff666666),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
