import 'package:flutter/material.dart';

class QRScannerPageConfig {
  double scanAreaSize;
  Color scanLineColor;

  QRScannerPageConfig(
      {this.scanAreaSize: 1.0,
      this.scanLineColor: const Color.fromRGBO(4, 184, 67, 1)});
}

class DividerHorizontal extends StatelessWidget {
  final double height;
  final Color color;

  DividerHorizontal({this.height: 1, this.color: const Color(0xFFF8F9F8)});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
    );
  }
}