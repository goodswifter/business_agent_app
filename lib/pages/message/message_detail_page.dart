import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import '../../widget/base_navi_appbar_widget.dart';

class MessageDetailPage extends StatefulWidget {
  int index;
  List messageList;

  MessageDetailPage({Key? key, required this.messageList, required this.index})
      : super(key: key);

  @override
  _MessageDetailPageState createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseViewBar(
        childView: BaseTitleBar(
          "消息详情",
          isBackHidden: false,
          leftClick: () {
            Navigator.pop(context);
          },
        ),
        preferredSize: Size.fromHeight(50.0),
      ),
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Text(
                        "${widget.messageList[widget.index]["title"]}",
                        style: TextStyle(
                          color: Color(0xff222222),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: Text(
                        // "${widget.messageList[widget.index]["time"]}",
                        _showDateTimeString(
                            "${widget.messageList[widget.index]["time"]}"),
                        style: TextStyle(
                          color: Color(0xffB2B2B2),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Text(
                        "${widget.messageList[widget.index]["content"]}",
                        style: TextStyle(
                          color: Color(0xff222222),
                          fontSize: 17,
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
    );
  }

  ///日期显示
  ///根据判断今天展示 “07：19”，昨天展示情况 “2021-07-29 18：20”
  String _showDateTimeString(String dateString) {
    String currentStr = "";
    var _strtimes = DateTime.parse(dateString);
    var _milliseconds = _strtimes.millisecondsSinceEpoch;
    //  var str =  DateTime.fromMillisecondsSinceEpoch(_time);
    bool isToday = DateUtil.isToday(_milliseconds);
    // LogUtil.e("is today ${isToday}");
    if (isToday) {
      currentStr = DateUtil.formatDateStr(dateString, format: DateFormats.h_m);
    } else {
      // currentStr =
      //     DateUtil.formatDateStr(dateString, format: DateFormats.y_mo_d_h_m);
      currentStr =
          DateUtil.formatDateStr(dateString, format: "yyyy年M月d日 HH:mm");
    }

    return currentStr;
  }
}
