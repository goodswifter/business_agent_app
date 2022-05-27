import 'package:flutter/material.dart';

import '../../utils/lxl_screen.dart';

class NavigationCustomAppBarWidget extends StatelessWidget {
  final String title;
  final GestureTapCallback? backAction;

  const NavigationCustomAppBarWidget({
    Key? key,
    required this.title,
    this.backAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: LXLScreen.width,
      height: 100,
      color: const Color(0xffff0044),
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(-1, -0.3),
            child: InkWell(
              // onTap: (){
              //   Navigator.pop(context);
              // },
              onTap: backAction,
              child: SizedBox(
                // color: Colors.red,
                width: 50,
                height: 50,
                child: Center(
                  child: Image.asset("images/navi_back_images.png",
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.3),
            child: SizedBox(
              // color: Colors.red,
              width: 100,
              height: 30,
              child: Center(
                child: Text(
                  // "注册",
                  title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment(1, -0.3),
            child: SizedBox(
              width: 50,
              height: 30,
              child: Center(child: Text("")),
            ),
          ),
        ],
      ),
    );
  }
}
