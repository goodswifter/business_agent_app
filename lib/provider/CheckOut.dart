import 'package:flutter/material.dart';

class CheckOut with ChangeNotifier {
  List _checkOutListData = []; //购物车数据
  List get checkOutListData => _checkOutListData;

  changeCheckOutListData(data) {
    _checkOutListData = data;
    notifyListeners();
  }
}
