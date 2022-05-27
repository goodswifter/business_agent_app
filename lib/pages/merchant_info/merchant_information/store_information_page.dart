import 'dart:io';
import 'dart:typed_data';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:umpay_crossborder_app/core/config/config.dart';
import 'package:umpay_crossborder_app/dao/user_info_dao.dart';
import 'package:umpay_crossborder_app/network/lxl_dio_http_manager.dart';
import 'package:umpay_crossborder_app/network/network_message_code.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/add_merchant_page.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/business_license_information_page.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/legal_person_information_page.dart';
import 'package:umpay_crossborder_app/pages/merchant_info/merchant_information/registration_certificate_information_page.dart';
import 'package:umpay_crossborder_app/utils/city_pickers_utils.dart';
import 'package:umpay_crossborder_app/utils/custom_date_picker_utils.dart';
import 'package:umpay_crossborder_app/utils/lxl_easy_loading.dart';
import 'package:umpay_crossborder_app/utils/navigator_util.dart';
import 'package:umpay_crossborder_app/utils/user_header_image_modify_utils.dart';

import '../../../config/lxl_key_define.dart';
import '../../../dao/agent_shop_info_dao.dart';
import '../../../model/agent_data_info_model.dart';

//店铺信息界面

typedef CallBack = Function(Object obj);

//店铺照片类型
enum StorePhotoType {
  /// 门头照
  doorphoto,

  /// 收银台照
  cashierPhoto,

  /// 店内环境照
  inStoreEnvironmentPhoto,
}

class StoreInfomationPage extends StatefulWidget {
  StoreInfomationPage({Key? key, required this.merchantType}) : super(key: key);
  MerchantType merchantType;

  @override
  State<StoreInfomationPage> createState() => _StoreInfomationPageState();
}

class _StoreInfomationPageState extends State<StoreInfomationPage> {
  bool isShowStar = true;
  final _businessAddressController = TextEditingController();

  String startTime = "";
  String endTime = "";
  //地址字符串
  String cityAdressStr = "";

  String detailedAddressStr = "";
  String allAdressString = "";

  //服务商ID
  String agentId = "";

  @override
  void initState() {
    super.initState();

    LogUtil.e("store merchant type : ${widget.merchantType}");

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

  Widget buildTextField(
      TextEditingController controller,
      String hintText,
      bool enabled,
      bool obscureText,
      TextInputType textInputType,
      int selectedIndex) {
    return Container(
      child: TextField(
        controller: controller,
        // maxLength: 30, //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
        maxLines: 1, //最大行数
        autocorrect: true, //是否自动更正
        // autofocus: true, //是否自动对焦
        obscureText: obscureText, //true, //是否是密码
        textAlign: TextAlign.left, //文本对齐方式
        cursorColor: const Color(0x222222), //光标颜色
        cursorWidth: 1,
        cursorHeight: 15.0,
        style: const TextStyle(
          fontSize: 14.0,
          color: const Color(0xff222222),
        ), //输入文本的样式
        // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],//允许的输入格式
        keyboardType: textInputType,
        decoration: InputDecoration(
          // fillColor:
          //     Color(0xffEBEDF1), //Color(0xfff8f8f8), //Colors.blue.shade100,
          // filled: true,
          // labelText: "",

          hintText: hintText,
          hintStyle: TextStyle(
            // color: Color(0xff999999),
            color: Color(_getChooseItemSelectedColor(selectedIndex)),
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
        ),
        // enableInteractiveSelection: true,
        onChanged: (text) {
          //内容改变的回调
          print('change $text');
        },
        onSubmitted: (text) {
          //内容提交(按回车)的回调
          print('submit $text');
        },
        enabled: enabled, //true, //是否禁用
      ),
    );
  }

  //获取颜色
  _getChooseItemSelectedColor(int selectedIndex) {
    int colorValue = 0xff999999;
    switch (selectedIndex) {
      case 3:
        if (cityAdressStr != null && cityAdressStr.length > 0) {
          colorValue = 0xff333333;
        } else {
          colorValue = 0xff999999;
        }
        break;

      default:
    }
    return colorValue;
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
                child: const Text(
                  "店铺信息",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            _subStoreInfoWidget("门头照", StorePhotoType.doorphoto),
            _subStoreInfoWidget("收银台照", StorePhotoType.cashierPhoto),
            _subStoreInfoWidget(
                "店内环境照", StorePhotoType.inStoreEnvironmentPhoto),
            _addOtherInfoWidget(),
            _bottomSaveAndNextStepWidget(), //保存并下一步widget
          ],
        ),
      ),
    );
  }

  //添加店铺信息子组件
  _subStoreInfoWidget(String title, StorePhotoType photoType) {
    return SliverToBoxAdapter(
      child: Container(
        height: 148,
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(12, 15, 0, 10),
              // width: 100,
              height: 24,
              // color: Colors.cyan,
              child: Row(
                children: [
                  Visibility(
                    visible: true,
                    child: Container(
                      child: Text(
                        isShowStar == true ? "*" : "  ",
                        style: const TextStyle(
                          color: const Color(0xffFF5B5D),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: const Color(0xff222222),
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
                _didSelectedImageAction(photoType);
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
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

  //添加其他信息组件
  _addOtherInfoWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        // height: 224,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                //日期
                CustomDatePickerUtils.showDatePicker(
                    context, "", DateTimePickerMode.datetime, (datetime) {
                  LogUtil.e("start date time = $datetime");
                  setState(() {
                    startTime = datetime;
                  });
                });
              },
              child: _subMerchantInfoTimeWiget(
                false,
                "营业时间",
                startTime.length > 0 && startTime != null
                    ? startTime
                    : "请选择营业起始时间",
              ),
            ),
            _subLineWidget(),
            InkWell(
              onTap: () {
                //日期
                CustomDatePickerUtils.showDatePicker(
                    context, "", DateTimePickerMode.datetime, (datetime) {
                  LogUtil.e("end date time = $datetime");
                  setState(() {
                    endTime = datetime;
                  });
                });
              },
              child: _subMerchantInfoTimeWiget(
                false,
                "endtime",
                endTime.length > 0 && endTime != null ? endTime : "请选择营业结束时间",
              ),
            ),
            _subLineWidget(),
            InkWell(
              // behavior: HitTestBehavior.opaque,
              onTap: () {
                _dealDidSelectedItemAction("经营地区", 100);
              },
              child: _subMerchantInfoTimeWiget(
                true,
                "经营地区",
                cityAdressStr != null && cityAdressStr.length > 0
                    ? cityAdressStr
                    : "请选择省市区",
              ),
            ),
            _subLineWidget(),
            // _subMerchantInfoWiget(true, "经营地址", "请输入详细经营地址"),
            _subBusinessAddressWiget(_businessAddressController, "请输入详细经营地址",
                true, "经营地址", true, false, 1, TextInputType.text),
          ],
        ),
      ),
    );
  }

  //线条
  _subLineWidget() {
    return Container(
      height: 0.5,
      color: const Color(0xffE9E9E9),
      margin: const EdgeInsets.fromLTRB(12, 0, 6, 0),
    );
  }

  //重写子组件
  _subMerchantInfoTimeWiget(
    bool isShowStar,
    String title,
    String promptInfo,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      height: 55,
      // color: Colors.purple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Visibility(
                    visible: true,
                    child: Container(
                      width: 10,
                      child: Text(
                        isShowStar == true ? "*" : " ",
                        style: const TextStyle(
                          color: Color(0xffFF5B5D),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )),
                Container(
                  width: 63.5,
                  // color: Colors.cyan,
                  child: Text(
                    // title,
                    title == "endtime" ? "" : title,
                    style: const TextStyle(
                      color: const Color(0xff222222),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            // color: Colors.red,
            margin: const EdgeInsets.fromLTRB(35.5, 0, 0, 0),
            child: Text(
              "$promptInfo",
              style: TextStyle(
                color: promptInfo == "请选择营业起始时间" ||
                        promptInfo == "请选择营业结束时间" ||
                        promptInfo == "请选择省市区"
                    ? const Color(0xffB1B1B1)
                    : const Color(0xff333333),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          )),
          Container(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
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

  //经营地址
  _subBusinessAddressWiget(
    TextEditingController controller,
    String hintText, //默认提示信息
    bool isShowStar, //是否显示*
    String title, //名称
    bool isEnableSelected, //设置是否可点击
    bool isShowRight, //是否展示右侧箭头 right image
    int didSelectedIndex, //点击了哪一行
    TextInputType textInputType,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // _dealDidSelectedItemAction(title, didSelectedIndex);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        height: 55,
        // color: Colors.purple,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              child: Row(
                children: [
                  Visibility(
                    visible: true,
                    child: Container(
                      child: Text(
                        // "*",
                        isShowStar == true ? "*" : "  ",
                        style: const TextStyle(
                          color: const Color(0xffFF5B5D),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: const Color(0xff222222),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Expanded(
                flex: 1,
                child: Container(
                  // color: Colors.red,
                  padding: const EdgeInsets.only(right: 10),
                  child: buildTextField(controller, hintText, isEnableSelected,
                      false, textInputType, didSelectedIndex),
                  // child: buildTextField(controller, "请输入真实姓名", true,
                  //     false, TextInputType.number),
                ),
              ),
            ),
            Visibility(
                visible: isShowRight, //true,
                child: Container(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Image.asset("images/sh_app_more_right_1.png",
                        fit: BoxFit.cover),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  ///处理加入点击每一个item选项
  _dealDidSelectedItemAction(String title, int selectedIndex) async {
    LogUtil.e("title : $title , selectedIndex : $selectedIndex");
    FocusScope.of(context).requestFocus(FocusNode());

    switch (selectedIndex) {
      case 100:
        //展示三级联动
        CityPickersUtils.showCityPicker(context, (Map result) {
          LogUtil.e("city result : $result");

          //后期需要城市码取城市码

          // city result : {"provinceName":"北京市","provinceId":"110000",
          //"cityName":"北京城区","cityId":"110100",
          //"areaName":"东城区","areaId":"110101" }

          setState(() {
            if (result != null) {
              // this.cityAdressStr =
              //     "${result.provinceName}${result.cityName}${result.areaName}";

              //city result : {province: 河北省, city: 石家庄市, area: 长安区,
              //provinceCode: 130000, cityCode: 130100, areaCode: 130102}
              cityAdressStr =
                  "${result["province"]}${result["city"]}${result["area"]}";
            } else {
              cityAdressStr = "";
            }
          });
        });

        break;
      default:
    }
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

  ///点击保存并下一步事件
  // 营业执照信息：
  // 1、小微商户：无营业执照信息   直接跳转法人界面
  // 2、个体户/企事业-普通企业：有营业执照信息界面
  // 3、企事业-事业单位/其他组织：登记证书信息界面
  _didSelectedSaveAndNextAction() {
    FocusScope.of(context).requestFocus(FocusNode());
    detailedAddressStr = _businessAddressController.text;
    allAdressString = cityAdressStr + detailedAddressStr;
    LogUtil.e(
        "detailedAddressStr: $detailedAddressStr , all adress  $allAdressString");

    switch (widget.merchantType) {
      case MerchantType.smallAndMicro: //小微商户
        LogUtil.e("小微商户 ${widget.merchantType}");

        //法人信息界面
        NavigatorUtil.push(
            context,
            LegalPersonInformationPage(
              merchantType: widget.merchantType,
            ));

        break;
      case MerchantType.selfEmployed: //个体户
      case MerchantType.commonEnterprise: //普通企业
        LogUtil.e("个体户和普通企业 ${widget.merchantType}");

        //跳转营业执照信息界面
        NavigatorUtil.push(
            context,
            BusinessLicenseInformationPage(
              merchantType: widget.merchantType,
            ));
        break;
      case MerchantType.businessUnit: //事业单位
      case MerchantType.otherOrganizations: //其他组织
        LogUtil.e("事业单位和其他组织 ${widget.merchantType}");

        //跳转登记证书信息界面
        NavigatorUtil.push(
            context,
            RegistrationCertificateInformationPage(
              merchantType: widget.merchantType,
            ));

        break;
      default:
    }
  }

  // 店铺照片区分
  _didSelectedImageAction(StorePhotoType phoneType) {
    switch (phoneType) {
      case StorePhotoType.doorphoto: //门头照
        break;
      case StorePhotoType.cashierPhoto: //收银台照
        break;
      case StorePhotoType.inStoreEnvironmentPhoto: //店内环境照
        break;
      default:
    }

    // 调起相机
    _getPhoneImageAction();
  }

  /////////////////*********以下调起相机的方法*********//////////////////
  ///
  ///点击图片调起拍照或者相册中选择

  _getPhoneImageAction() {
    UserHeaderImageModifyUtils.openModalBottomSheet(context, "拍照", "从相册中选择",
        (XFile file) async {
      //压缩图片
      String base64 = await UserHeaderImageModifyUtils.compressImage(file);
      File ffile =
          await UserHeaderImageModifyUtils.createFileFromString(base64);

      LogUtil.e("image  base64 str ---> $base64");
      LogUtil.e("file ===> $ffile");

      //上传图片
      _uploadUserImageFileData(ffile, (obj) {
        String imageData = (obj as String);
        //更新用户图片回调
        _updateUserImageInfoData(imageData, (obj) {
          //头像地址拼接
          String avatar = "${Config.imageAvatarBaseUrl}" + imageData;

          ///下载图片保存到相册
          _downloadUserImageData(imageData, (obj) {
            print("保存图片到相册是否成功 obj --> $obj");
          });

          //保存图片链接
          // SpUtil.putString("imageFile", avatar);
          setState(() {
            // this._headerImage = avatar;
          });

          //获取用户信息，更新头像
          // UserInfoDao.requestGetUserInfoData((obj) {});
        });
      });
    });
  }

  /// 上传图片信息接口
  _uploadUserImageFileData(File file, CallBack callback) async {
    DateTime _nowDate = DateTime.now();
    // String dateTimeStr = DateUtil.formatDate(_nowDate, format: DateFormats.y_mo_d);
    // String dateTimeStr = DateUtil.getNowDateMs().toString();

    String url = "${Config.baseUrl}user/file/upload";

    var response = await LXLDioHttpManager.postUploadImageFileData(url, file);
    print("upload image = $response");

    String code = response["code"];
    String message = response["message"];

    if (code == ResponseMessage.SUCCESS_CODE) {
      //upload image = {code: 00000000, message: success,
      //requestId: 3ff91168df413342,
      //data: /usr/mpsp/data/file/2021070210135559700001/2021070815543529700002.jpg}
      //传给服务器
      String data = response["data"];
      callback(data);
    } else {
      String msg = ResponseMessage.getResponseMessageCode(code, message);
      if (msg == "" || msg == null) {
        return;
      }
      LXLEasyLoading.showToast(msg);
    }
  }

  //更新用户头像和图片的接口
  _updateUserImageInfoData(String imageData, CallBack callback) async {
    Map params = {
      "avatar": imageData,
    };

    var response = await UserInfoDao.doUploadToUserImageData(params);
    LogUtil.e("response = $response");
    if (response == null) return;
    String code = response["code"];
    String message = response["message"];

    if (code == ResponseMessage.SUCCESS_CODE) {
      callback("获取用户信息，用于显示用户头像");
    } else {
      String msg = ResponseMessage.getResponseMessageCode(code, message);
      if (msg == "" || msg == null) {
        return;
      }
      LXLEasyLoading.showToast(msg);
    }
  }

  /// 下载图片图片信息接口
  _downloadUserImageData(String imageDataPath, CallBack callback) async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path +
        "/${DateTime.now().millisecondsSinceEpoch.toString()}.png";

    var response = await LXLDioHttpManager.getDownloadImageFileData(
      imageDataPath,
      savePath,
    );
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response),
            // quality: 60,
            // name: "hello",
            isReturnImagePathOfIOS: true);
    print(result);

    // var response = await LXLDioHttpManager.getDownloadImageFileData(
    //   imageDataPath,
    //   savePath,
    // );
    // print("downnload = ${response}");

    // final result = await ImageGallerySaver.saveFile(savePath, isReturnPathOfIOS: true);
    // print("result = ${result}");

    callback(result);
  }

  ///商户入住接口- 店铺信息
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
      "storeFrontImg": "",
      "checkStandPic": "",
      "indoorPic": "",
      "businessStartTime": "",
      "businessFinishTime": "",
      "provinceCode": "",
      "cityCode": "",
      "distinctCode": "",
      "businessAddress": this._businessAddressController.text,
    };
    //商户入驻参数
    Map<String, dynamic> params = {
      "agentId":
          this.agentId != null && this.agentId.length > 0 ? this.agentId : "",
      "applicationId": "", //若type=2-提交商户资料，application_id必填
      "type": 1, //类型：1-保存商户资料；2-提交商户资料
      "merchantType": merchantType, //商户类型1-小微；2-个体户；3-企事业
      "merchantChildType": merchantChildType, //企事业商户子类型1-普通企业；2-事业单位；3-其他组织；
      "shopInfo": subInfoParamsMap,
    };

    LXLEasyLoading.show();
    var response = await AgentShopInfoDao.doAgentShopInfoData(params);
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
