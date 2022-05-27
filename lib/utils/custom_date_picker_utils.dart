/*
 * @Author: lixiao
 * @Date:
 * @LastEditTime: 
 * @LastEditors: 
 * @Description: 日期选择器
 * @FilePath: 
 */

import 'dart:ffi';
import 'package:date_format/date_format.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

typedef CallBack = void Function(String datetimeStr);

class CustomDatePickerUtils {
  static showDatePicker(BuildContext context, String dateFormat,
      DateTimePickerMode pickerMode, CallBack callback) {
    DateTime _selectedDateTime = DateTime.now();

    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text('确定', style: TextStyle(color: Color(0xffFF5B5D))),
        // title: Container(
        //   color: Colors.white,
        //   child: Text("aaa"),
        // ),
        cancel: Text('取消', style: TextStyle(color: Color(0xff666666))),
      ),
      minDateTime: DateTime.parse("1970-01-01"),
      maxDateTime: DateTime.parse("2050-01-01"),
      initialDateTime: _selectedDateTime,

      dateFormat: "yyyy-MMMM-dd HH:mm:ss",
      // dateFormat: dateFormat, //,
      // dateFormat: "yyyy年-MM月-dd日",
      // dateFormat: 'yyyy年M月d日 ,H时:m分', // show TimePicker

      pickerMode: pickerMode, //DateTimePickerMode.date, // show TimePicker

      locale: DateTimePickerLocale.zh_cn,
      onCancel: () {
        debugPrint('onCancel');
      },
      onConfirm: (dateTime, List<int> index) {
        print("${dateTime} , ${index}");
  
        String dateTimeStr =
            DateUtil.formatDate(dateTime, format: DateFormats.full);

        callback(dateTimeStr);
      },
    );

    // DatePicker.showDatePicker(
    //   context,
    //   showTitleActions: true,
    //   minTime: DateTime(1970, 1, 1),
    //   maxTime: DateTime(2099, 12, 31),
    //   theme: DatePickerTheme(
    //       // headerColor: Colors.orange,
    //       // backgroundColor: Colors.blue,
    //       // itemStyle: TextStyle(
    //       //     color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    //       // doneStyle: TextStyle(color: Colors.white, fontSize: 16),
    //       ),
    //   onChanged: (date) {
    //     print('change $date in time zone ' +
    //         date.timeZoneOffset.inHours.toString());
    //   },
    //   onConfirm: (date) {
    //     print('confirm $date');
    //   },
    //   onCancel: () {
    //     print("cancel did");
    //   },
    //   currentTime: DateTime.now(),
    //    locale: LocaleType.zh,
    // );
  }
}
