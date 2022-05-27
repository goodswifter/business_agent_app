/// 
/// Author       : zhongaidong
/// Date         : 2022-05-27 13:24:43
/// Description  : 温馨提示
/// 
import 'package:flutter/material.dart';

class WarmPromptWidget extends StatelessWidget {
  const WarmPromptWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(24, 18, 17, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "温馨提示",
              style: TextStyle(
                color: Color(0xff222222),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: const Text(
                "联系人姓名、证件号、手机号码用于后续商家账号开通、登录、微信实名等，请填写商户真实手机号",
                style: TextStyle(
                  color: Color(0xff999999),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}