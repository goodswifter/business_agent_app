import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:umpay_crossborder_app/services/ScreenAdapter.dart';
import 'package:umpay_crossborder_app/utils/lxl_screen.dart';

//商户审核界面

enum MerchantReviewType {
  /// 审核中
  inReview,

  /// 审核通过
  success,

  /// 审核驳回
  rejected,
}

class MerchantReviewInfoPage extends StatefulWidget {
  const MerchantReviewInfoPage({Key? key}) : super(key: key);

  @override
  State<MerchantReviewInfoPage> createState() => _MerchantReviewInfoPageState();
}

class _MerchantReviewInfoPageState extends State<MerchantReviewInfoPage> {
  //搜索textEditingController
  final _searchTextController = TextEditingController();
  //默认一种状态
  MerchantReviewType merchantReviewType = MerchantReviewType.success;
  //全部
  bool isAll = true;
  //审核中
  bool isInReview = false;
  //审核驳回
  bool isRejected = false;
  //审核通过
  bool isSuccess = false;
  //搜索框内是否展示删除
  bool isShowClean = false;

  List dataList = [];

  List currentList = [
    {
      "title": "北京全时商贸有限公司1",
      "settledType": "1", //入驻状态 1入驻   0未入驻
      "merchantType": "1", //1 小微商户   2个体户  3企事业
      "time": "2022-05-19 14:52:30",
      "reviewType": "1", //1审核通过  2审核中  3审核拒绝
    },
    {
      "title": "北京全时商贸有限公司2",
      "settledType": "0", //入驻状态
      "merchantType": "2", //1 小微商户   2个体户  3企事业
      "time": "2022-05-17 14:52:30",
      "reviewType": "2", //1审核通过  2审核中  3审核拒绝
    },
    {
      "title": "北京全时商贸有限公司3",
      "settledType": "1", //入驻状态
      "merchantType": "3", //1 小微商户   2个体户  3企事业
      "time": "2022-05-15 14:52:30",
      "reviewType": "3", //1审核通过  2审核中  3审核拒绝
    },
    {
      "title": "北京全时商贸有限公司4",
      "settledType": "0", //入驻状态
      "merchantType": "2", //1 小微商户   2个体户  3企事业
      "time": "2022-05-17 14:52:30",
      "reviewType": "2", //1审核通过  2审核中  3审核拒绝
    },
  ];

  //审核中数据
  List currentInReviewList = [];
  List currentSuccessList = [];
  List currentRejectedList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LogUtil.e("currentList = ${this.currentList}");
    LogUtil.e("dataList = ${this.dataList}");
    this.dataList.addAll(this.currentList);
    LogUtil.e("dataList = ${this.dataList}");

    // this.merchantReviewType = MerchantReviewType.inReview;
    //获取数据
    _getCurrentDataList();
  }

  //获取假数据
  _getCurrentDataList() {
    // reviewType //1审核通过  2审核中  3审核拒绝
    for (int i = 0; i < this.currentList.length; i++) {
      var reviewType = this.currentList[i]["reviewType"];
      var dataMap = this.currentList[i];
      if (reviewType == "1") {
        this.currentSuccessList.add(dataMap);
      } else if (reviewType == "2") {
        this.currentInReviewList.add(dataMap);
      } else if (reviewType == "3") {
        this.currentRejectedList.add(dataMap);
      }
    }
  }

  Widget buildTextField(TextEditingController controller, String hintText,
      bool enabled, bool obscureText, TextInputType textInputType) {
    return Container(
      child: TextField(
        controller: controller,
        // maxLength: 30, //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
        maxLines: 1, //最大行数
        autocorrect: true, //是否自动更正
        // autofocus: true, //是否自动对焦
        obscureText: obscureText, //true, //是否是密码
        textAlign: TextAlign.left, //文本对齐方式
        cursorColor: Color(0x222222), //光标颜色
        cursorWidth: 1,
        cursorHeight: 15.0,
        style: TextStyle(
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
          suffixIcon: Container(
            child: this.isShowClean
                ? IconButton(
                    icon: Image.asset(
                      'images/sh_app_textfield_right_clear.png',
                      fit: BoxFit.cover,
                    ),
                    onPressed: onCancel,
                  )
                : Text(""),
          ),

          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xff999999),
            fontSize: 14,
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
        ),
        // enableInteractiveSelection: true,
        onChanged: (text) {
          //内容改变的回调
          print('change $text');

          setState(() {
            this.isShowClean = true;
          });
        },
        onSubmitted: (text) {
          //内容提交(按回车)的回调
          print('submit $text');
        },
        enabled: enabled, //true, //是否禁用
      ),
    );
  }

  //清除clean
  onCancel() {
    // 保证在组件build的第一帧时才去触发取消清空内
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => this._searchTextController.clear());
    setState(() {
      this.isShowClean = false;
    });
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
                child: Text(
                  "商户审核",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            //商户审核 搜索 widget
            _searchMerchantReviewSubWidget(),
            //顶部选项 - 全部、审核中、审核驳回、审核通过
            _topChooseItemListWidget(),
            //审核列表
            _merchantReviewItemListWidget(context),
          ],
        ),
      ),
    );
  }

  ///添加商户审核item widget
  _searchMerchantReviewSubWidget() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        // width: LXLScreen.width,
        height: 50,
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 7.5, 16, 7.5),
          height: 34, //ScreenAdapter.height(60),
          decoration: BoxDecoration(
            // color: Color.fromRGBO(233, 233, 233, 0.8),
            color: Color(0xffF6F6F6),
            borderRadius: BorderRadius.circular(17),
            // border: Border.all(
            //   color: Color(0xffeeeeee),
            //   width: 1,
            // ),
          ),
          // padding: EdgeInsets.only(left: 14),
          padding: EdgeInsets.fromLTRB(12, 0, 5, 0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset("images/home_search.png", fit: BoxFit.cover),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    // color: Colors.purple,
                    child: buildTextField(this._searchTextController,
                        "请输入商户名称或编号", true, false, TextInputType.text),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  //顶部的选项
  _topChooseItemListWidget() {
    return SliverToBoxAdapter(
      child: Container(
        child: Row(
          children: [
            _subTopListItemWidget("全部", this.isAll, 0),
            _subTopListItemWidget("审核中", this.isInReview, 1),
            _subTopListItemWidget("审核驳回", this.isRejected, 2),
            _subTopListItemWidget("审核通过", this.isSuccess, 3),
          ],
        ),
      ),
    );
  }

  //顶部子布局
  _subTopListItemWidget(String title, bool isShowLine, int didSelectedIndex) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          LogUtil.e(" 顶部的item top ${didSelectedIndex} 点击了");
          _didTopSelectedTitleItemIndex(didSelectedIndex);
        },
        child: Container(
          // width: 60,
          height: 45,
          color: Colors.white,
          alignment: Alignment.center,
          child: Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 13, 0, 0),
                  child: Text(
                    // "全部",
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: isShowLine, //true,
                  child: Container(
                    width: 30,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Color(0xffFF5B5D),
                      borderRadius: BorderRadius.circular(1.5),
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

  ///点击顶部的导航title 进行切换状态
  _didTopSelectedTitleItemIndex(int index) {
    switch (index) {
      case 0: //全部
        setState(() {
          this.isAll = true;
          this.isInReview = false;
          this.isRejected = false;
          this.isSuccess = false;
          this.dataList = [];
          this.dataList.addAll(this.currentList);
        });
        break;
      case 1: //审核中
        setState(() {
          this.isAll = false;
          this.isInReview = true;
          this.isRejected = false;
          this.isSuccess = false;
          this.dataList = [];
          this.dataList.addAll(this.currentInReviewList);
        });
        break;
      case 2: //审核驳回
        setState(() {
          this.isAll = false;
          this.isInReview = false;
          this.isRejected = true;
          this.isSuccess = false;
          this.dataList = [];
          this.dataList.addAll(this.currentRejectedList);
        });
        break;
      case 3: //审核通过
        setState(() {
          this.isAll = false;
          this.isInReview = false;
          this.isRejected = false;
          this.isSuccess = true;
          this.dataList = [];
          this.dataList.addAll(this.currentSuccessList);
        });
        break;
      default:
    }
  }

  ///////////********sliverList 列表展示***********///////

  ///sliver list 审核列表实现
  _merchantReviewItemListWidget(context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            height: 112,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        //商户titleName
                        _merchantReviewTitleSubWiget(index),
                        //入驻
                        _merchantSettledStatusSubWidget(index),

                        //1 小微商户   2个体户  3企事业
                        this.dataList[index]["merchantType"] == "1"
                            ? _merchantTypeStatusWidget("小微")
                            : (this.dataList[index]["merchantType"] == "2"
                                ? _merchantTypeStatusWidget("个体户")
                                : _merchantTypeStatusWidget("企事业")),
                      ],
                    ),
                  ),
                  //time时间
                  _merchantReviewTimeSubWiget(index),
                  //商户审核状态子widget(审核中、审核通过、审核驳回展示)
                  _merchantReviewStatusSubWidget(index),
                ],
              ),
            ),
          );
        },
        childCount: this.dataList.length,
      ),
    );
  }

  ////////////////////////////////////////////

  //商户列表title
  _merchantReviewTitleSubWiget(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 16, 0, 0),
      child: Text(
        // "北京全时商贸有限公司",
        this.dataList[index]["title"],
        style: TextStyle(
          fontSize: 15,
          color: Color(0xff333333),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  //时间展示widget
  _merchantReviewTimeSubWiget(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 10, 0, 0),
      child: Text(
        // "2022-05-19 14:04:25",
        "${DateUtil.formatDateStr("${this.dataList[index]["time"]}", format: DateFormats.full)}",
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff999999),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  ///入驻 status widget
  _merchantSettledStatusSubWidget(int index) {
    return Visibility(
        visible: this.dataList[index]["settledType"] == "1" ? true : false,
        child: Container(
          margin: EdgeInsets.fromLTRB(12, 16, 0, 0),
          height: 20,
          width: 39,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xffFF5B5D),
              borderRadius: BorderRadius.circular(11.5)),
          child: Text(
            "入驻",
            style: TextStyle(
              fontSize: 11,
              color: Color(0xffffffff),
              fontWeight: FontWeight.w400,
            ),
          ),
        ));
  }

  //商户类型状态 -- 小微、企事业、个体户
  _merchantTypeStatusWidget(String titleName) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 16, 0, 0),
      height: 20,
      width: 39,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
            // color: Color(0xff666666),
            color: Color.fromRGBO(102, 102, 102, 0.4),
          ),
          borderRadius: BorderRadius.circular(11.5)),
      child: Container(
        child: Text(
          "${titleName}",
          style: TextStyle(
            fontSize: 11,
            color: Color(0xff333333),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  /////////////////////////////////////////////////

  ///商户审核状态子widget
  _merchantReviewStatusSubWidget(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 10, 0, 0),
      //1审核通过  2审核中  3审核拒绝
      child: this.dataList[index]["reviewType"] == "3"
          ? _subMerchantReviewRejectedWidget() //审核驳回widget
          : (this.dataList[index]["reviewType"] == "1"
              ? _subMerchantSuccessWidget()
              : _subMerchantInreviewWidget(index)), //审核中

      // child: this.merchantReviewType == MerchantReviewType.rejected
      //     ? _subMerchantReviewRejectedWidget() //审核驳回widget
      //     : (this.merchantReviewType == MerchantReviewType.success
      //         ? _subMerchantSuccessWidget()
      //         : _subMerchantInreviewWidget()), //审核中widget
    );
  }

  //审核通过
  _subMerchantSuccessWidget() {
    return Container(
      child: Text(
        "审核通过",
        style: TextStyle(
            fontSize: 14,
            color: Color(0xff00B578),
            fontWeight: FontWeight.w400),
      ),
    );
  }

  //审核驳回展示widget
  _subMerchantReviewRejectedWidget() {
    return Container(
      //审核驳回
      child: Row(
        children: [
          Container(
            child: Text(
              "审核驳回",
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffFF5B5D),
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            width: 15,
            height: 15,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // color: Colors.cyan,
              border: Border.all(
                color: Color(0xffFF5B5D),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: Text(
              "!",
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xffFF5B5D),
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  //审核中
  _subMerchantInreviewWidget(int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              "审核中",
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffFF6010),
                  fontWeight: FontWeight.w400),
            ),
          ),
          InkWell(
            onTap: () {
              //点击状态查询
              _didReviewStatusQueryAction(index);
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
              height: 25,
              width: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xffFFE7E8),
                  borderRadius: BorderRadius.circular(12.25)),
              child: Text(
                "状态查询",
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xffFF5B5D),
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //点击对应的状态查询时间
  _didReviewStatusQueryAction(int index) {
    LogUtil.e("点击了状态查询 ---> ${index}");
  }
}
