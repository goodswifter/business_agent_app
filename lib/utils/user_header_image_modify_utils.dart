/*
 * 修改用户头像 
 */

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:permission_handler/permission_handler.dart';
import '../../utils/lxl_easy_loading.dart';
import '../../utils/lxl_screen.dart';

typedef CallBack = void Function(XFile file);

class UserHeaderImageModifyUtils {
  static final ImagePicker _picker = ImagePicker();

  //base64转File
  static Future<File> createFileFromString(String base64Str) async {
    Uint8List bytes = base64.decode(base64Str);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");
    await file.writeAsBytes(bytes);
    return file;
    // return file.path;
  }

  /// 通过图片路径将图片转换成Base64字符串
  // static Future imageFromPathToBase64(File file) async {
  //   List<int> imageBytes = await file.readAsBytes();
  //   return base64Encode(imageBytes);
  // }

  ///file.path 转 base64
  static Future imageFromPathToBase64(String path) async {
    File file = File(path);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  ///压缩图片
  static Future compressImage(XFile file) async {
    //  var file = await createFileFromString(base64);
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: 70, percentage: 50);
    print("file.path >>>>>> ${file.path}");
    // file.delete();

    print("compressedFile.path >>>>>> ${compressedFile.path}");
    var by = await compressedFile.readAsBytes();
    String bs64 = base64Encode(by);
    return bs64;
    // return compressedFile;
  }

  /// 选择图像拍摄
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
                                _takePhoto((file) {
                                  callback(file);
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
                                _openGallery((file) {
                                  callback(file);
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
      print(await Permission.camera.request().isGranted);
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
    // // setState(() {
    // if (image != null) {
    //   // _image = image;
    //   callback(image);
    // } else {
    //   print('No image selected.');
    // }
    // // });
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

    // final ImagePicker _picker = ImagePicker();
    // final XFile image = await _picker.pickImage(source: ImageSource.gallery);

    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      callback(pickedFile);
    }

    // var image =
    //     await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 400);
    // // setState(() {
    // if (image != null) {
    //   // _image = image;
    //   callback(image);
    // } else {
    //   print('No image selected.');
    // }
    // // });
  }

  /// 保存图片到相册
  ///
  /// 默认为下载网络图片，如需下载资源图片，需要指定 [isAsset] 为 `true`。
  static Future<void> saveImage(String imageUrl, {bool isAsset: false}) async {
    try {
      if (imageUrl == null) throw '保存失败，图片不存在！';

      /// 权限检测
      // PermissionStatus storageStatus = await Permission.storage.status;
      // if (storageStatus != PermissionStatus.granted) {
      //   storageStatus = await Permission.storage.request();
      //   if (storageStatus != PermissionStatus.granted) {
      //     throw '无法存储图片，请先授权！';
      //   }
      // }

      /// 保存的图片数据
      late Uint8List imageBytes;

      if (isAsset == true) {
        /// 保存资源图片
        ByteData bytes = await rootBundle.load(imageUrl);
        imageBytes = bytes.buffer.asUint8List();
      } else {
        /// 保存网络图片
        // CachedNetworkImage image = CachedNetworkImage(imageUrl: imageUrl);
        // DefaultCacheManager manager =
        //     image.cacheManager ?? DefaultCacheManager();
        // Map<String, String> headers = image.httpHeaders;
        // File file = await manager.getSingleFile(
        //   image.imageUrl,
        //   headers: headers,
        // );
        // imageBytes = await file.readAsBytes();
      }

      /// 保存图片
      final result = await ImageGallerySaver.saveImage(imageBytes);

      if (result == null || result == '') throw '图片保存失败';

      print("保存成功");
    } catch (e) {
      print(e.toString());
    }
  }
}
