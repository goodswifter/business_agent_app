import 'package:flutter/material.dart';
import '../utils/lxl_screen.dart';

//无数据界面
class NoDataWidget extends StatefulWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  _NoDataWidgetState createState() => _NoDataWidgetState();
}

class _NoDataWidgetState extends State<NoDataWidget> {
  @override
  Widget build(BuildContext context) {
    return _noDataWidget();
  }

  ///暂无数据的widget
  _noDataWidget() {
    return Container(
      width: LXLScreen.width,
      height: LXLScreen.height,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/message_no_data_image.png",
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          const Text(
            "暂时数据~",
            style: TextStyle(color: Color(0xff333333), fontSize: 16),
          ),
        ],
      ),
    );
  }
}
