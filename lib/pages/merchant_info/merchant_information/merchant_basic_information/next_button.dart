///
/// Author       : zhongaidong
/// Date         : 2022-05-27 13:26:32
/// Description  :
///
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key, this.onTap}) : super(key: key);

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
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
}
