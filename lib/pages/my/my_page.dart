/*
 * @Author: lixiao
 * @Date: 
 * @LastEditTime: 
 * @LastEditors: 
 * @Description: 我的页面
 * @FilePath: 
 */

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:umpay_crossborder_app/core/config/config.dart';
import 'package:umpay_crossborder_app/core/config/lxl_key_define.dart';
import 'package:umpay_crossborder_app/model/agent_data_info_model.dart';

import '../../dao/user_info_dao.dart';
import '../../network/lxl_dio_http_manager.dart';
import '../../network/network_message_code.dart';
import '../../pages/login_and_register/login_version_page.dart';
import '../../utils/lxl_easy_loading.dart';
import '../../utils/navigator_util.dart';
import '../../utils/user_header_image_modify_utils.dart';

typedef CallBack = Function(Object obj);

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  //登录手机号
  String _phone = "";

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    print("my page");
    //登录获取代理商数据
    AgentDataInfoModel? agentDataInfoModel = SpUtil.getObj(
        LXLKeyDefine.agentUserDataInfoKey,
        (v) => AgentDataInfoModel.fromJson(v as Map<String, dynamic>));

    if (agentDataInfoModel != null) {
      LogUtil.e("--登陆成功info---${agentDataInfoModel.mobile}");
      _phone = agentDataInfoModel.mobile!;
      setState(() {});
    }
  }

  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    await Future.delayed(Duration(milliseconds: 500), () {});

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: false,
        // enablePullUp: true,
        // header: WaterDropHeader(),
        header: ClassicHeader(height: 80, refreshStyle: RefreshStyle.Follow),
        // footer: ClassicFooter(),
        // footer: ClassicFooter(
        //   loadStyle: LoadStyle.ShowWhenLoading,
        //   completeDuration: Duration(milliseconds: 500),
        // ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: CustomScrollView(
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
                  "我的",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              //缩放的最大高度，必须要设置了才会有缩放的效果
              // expandedHeight: 250.0,
              // flexibleSpace: FlexibleSpaceBar(
              //   //标题是否居中
              //   centerTitle: true,
              //   //标题padding
              //   titlePadding: const EdgeInsets.all(10),
              //   //背景缩放模式 CollapseMode.pin//背景跟着一起往上滚,CollapseMode.none//背景不动
              //   collapseMode: CollapseMode.parallax,
              //   background: Image.network(
              //     'https://tse4-mm.cn.bing.net/th/id/OIP-C.E-4fLhTRC4aG-RvqTAO_dwHaE8?w=251&h=180&c=7&r=0&o=5&dpr=2&pid=1.7',
              //     fit: BoxFit.cover,
              //   ),
              //   title: const Text('万物生长'),
              // ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                height: 55,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _phone.length > 0 ? "手机号：$_phone" : "",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff333333),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _dealLoginOutAction,
                child: Container(
                  margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                  padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  height: 55,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "退出登录",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff333333),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///处理退出登录的事件
  _dealLoginOutAction() {
    //保存本地商户信息
    AgentDataInfoModel agentDataInfoModel = AgentDataInfoModel();
    SpUtil.putObject(LXLKeyDefine.agentUserDataInfoKey, agentDataInfoModel);
    SpUtil.putString(LXLKeyDefine.agentUserMobileKey, "");

    //跳转到登录界面
    NavigatorUtil.pushAndRemoveUntil(
        context,
        LoginVersionPage(
            isShowLoginBack: false,
            isVerificationLogin: true,
            isPasswordLogin: false));
  }

  ////////////////////////////////////////////////////////////

  //跳转设置页面
  _toMySettingPage() {
    // NavigatorUtil.push(context, MySettingPage());

    // Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => MySettingPage()))
    //     .then((value) {});
  }

  //跳转登录界面
  _didToLoginAction() {
    // Navigator.pushNamed(context, '/login');
    // NavigatorUtil.push(context, LoginPage(isShowLoginBack: true));

    NavigatorUtil.push(context, LoginVersionPage(isShowLoginBack: true));
  }

  ///点击用户头像了
  _didSelectedImageAction() {
    UserHeaderImageModifyUtils.openModalBottomSheet(context, "拍照", "从相册中选择",
        (XFile file) async {
      //压缩图片
      String base64 = await UserHeaderImageModifyUtils.compressImage(file);
      File ffile =
          await UserHeaderImageModifyUtils.createFileFromString(base64);
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
          UserInfoDao.requestGetUserInfoData((obj) {});
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
}
