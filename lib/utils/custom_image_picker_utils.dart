import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:permission_handler/permission_handler.dart';
import '../../utils/lxl_easy_loading.dart';
import '../../utils/lxl_screen.dart';

typedef CallBack = void Function(Object obj);

class CustomImagePickerUtils {
  static final ImagePicker _picker = ImagePicker();

/*
   * 选择图像拍摄
   */
  static Future openModalBottomSheet(
      BuildContext context, String str1, String str2, CallBack callback) async {
    final option = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 200.0,
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 15),
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: () async {
                                //相机拍照
                                _takePhoto((image) {
                                  callback(image);
                                });

                                Navigator.pop(context, '取消');
                              },
                              child: Container(
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child: Text(
                                    str1,
                                    style: TextStyle(
                                        color: Color(0xff323B46), fontSize: 16),
                                    textAlign: TextAlign.center,
                                  )))),
                      Divider(),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: () async {
                                //相册
                                // _openGallery();
                                _openGallery((image) {
                                  callback(image);
                                });
                                Navigator.pop(context, '取消');
                              },
                              child: Container(
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child: Text(
                                    str2,
                                    style: TextStyle(
                                        color: Color(0xff323B46), fontSize: 16),
                                    textAlign: TextAlign.center,
                                  )))),
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context, '取消');
                    },
                    child: Container(
                      height: 50,
                      width: LXLScreen.width, //ScreenUtils.screenW(context),
                      alignment: Alignment.center,
                      // margin: EdgeInsets.only(left: 30, right: 30, bottom: 15),
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white),
                      child: Text('取消', textAlign: TextAlign.center),
                    )),
              ],
            ),
          );
        });

    print(option);

    // //拍照
    // showModalBottomSheet(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return Container(
    //       height: 220.0,
    //       color: Color(0xfff1f1f1),
    //       child: Center(
    //         child: ListView(
    //           children: [
    //             CupertinoButton(
    //                 child: Text(
    //                   '拍 照',
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                     color: Color(0xff333333),
    //                   ),
    //                 ),
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                   // _takePhoto(
    //                   //     urlChangedKeyStr);
    //                 }),
    //             Divider(),
    //             CupertinoButton(
    //                 child: Text(
    //                   '从手机相册选择',
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                     color: Color(0xff333333),
    //                   ),
    //                 ),
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                   // _openGallery(
    //                   //     urlChangedKeyStr);
    //                 }),
    //             Container(
    //               color: Color(0xffdddddd),
    //               height: 10.0,
    //             ),
    //             CupertinoButton(
    //                 child: Text(
    //                   '取 消',
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                     color: Color(0xff333333),
    //                   ),
    //                 ),
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 }),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  /*拍照*/
  static _takePhoto(CallBack callback) async {
    if (Platform.isAndroid) {
      if (await Permission.camera.request().isGranted) {
      } else {
        LXLEasyLoading.showToast("请打开照相机权限");
        return;
      }
    } else {}

    // final ImagePicker _picker = ImagePicker();
    var pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      callback(pickedFile);
    }

    // var image =
    //     await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);
    // callback(image);
  }

  /*相册*/
  static _openGallery(CallBack callback) async {
    if (Platform.isAndroid) {
      if (await Permission.camera.request().isGranted) {
      } else {
        LXLEasyLoading.showToast("请打开照相机权限");
        return;
      }
    } else {}

//  final ImagePicker _picker = ImagePicker();
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      callback(pickedFile);
    }

    // var image =
    //     await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 400);
    // callback(image);
  }
}
