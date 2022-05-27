import 'package:flutter/material.dart';

typedef CallBack = Function(String str);

class CustomBottomSheetWidget {
//  List itemList = ["111","222"];

  static showSelectedBottomSheet(
      BuildContext context, List itemList, CallBack callback) {
    showModalBottomSheet(
        context: context,
        builder: (conetxt) {
          return SafeArea(
            child: Container(
              height: 200,
              child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      print("${itemList[index]}");
                      Navigator.pop(context);
                      String str = itemList[index];
                      callback(str);
                    },
                    child: Container(
                      height: 50,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${itemList[index]}",
                              style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 15.0,
                              ),
                            ),
                          )),
                          Container(
                            height: 1,
                            color: Color(0xffeeeeee),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
