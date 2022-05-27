// To parse this JSON data, do
//
//     final mccInfoList = mccInfoListFromJson(jsonString);

import 'dart:convert';

MccInfoListModel mccInfoListFromJson(String str) =>
    MccInfoListModel.fromJson(json.decode(str));

String mccInfoListToJson(MccInfoListModel data) => json.encode(data.toJson());

class MccInfoListModel {
  MccInfoListModel({
    this.mccInfoList = const [],
    this.rpid,
    this.retCode,
    this.retMsg,
  });

  List<MccInfoListElement> mccInfoList;
  String? rpid;
  String? retCode;
  String? retMsg;

  factory MccInfoListModel.fromJson(Map<String, dynamic> json) =>
      MccInfoListModel(
        mccInfoList: List<MccInfoListElement>.from(
            json["mccInfoList"].map((x) => MccInfoListElement.fromJson(x))),
        rpid: json["rpid"],
        retCode: json["retCode"],
        retMsg: json["retMsg"],
      );

  Map<String, dynamic> toJson() => {
        "mccInfoList": List<dynamic>.from(mccInfoList.map((x) => x.toJson())),
        "rpid": rpid,
        "retCode": retCode,
        "retMsg": retMsg,
      };
}

class MccInfoListElement {
  MccInfoListElement({
    this.uhMccTypeTwos = const [],
    this.mccName,
    this.mcc,
  });

  List<UhMccTypeTwo> uhMccTypeTwos;
  String? mccName;
  String? mcc;

  factory MccInfoListElement.fromJson(Map<String, dynamic> json) =>
      MccInfoListElement(
        uhMccTypeTwos: List<UhMccTypeTwo>.from(
            json["uhMccTypeTwos"].map((x) => UhMccTypeTwo.fromJson(x))),
        mccName: json["mccName"],
        mcc: json["mcc"],
      );

  Map<String, dynamic> toJson() => {
        "uhMccTypeTwos":
            List<dynamic>.from(uhMccTypeTwos.map((x) => x.toJson())),
        "mccName": mccName,
        "mcc": mcc,
      };
}

class UhMccTypeTwo {
  UhMccTypeTwo({
    this.uhMccTypeThrees = const [],
    this.mccName,
    this.mcc,
  });

  List<UhMccTypeThree> uhMccTypeThrees;
  String? mccName;
  String? mcc;

  factory UhMccTypeTwo.fromJson(Map<String, dynamic> json) => UhMccTypeTwo(
        uhMccTypeThrees: List<UhMccTypeThree>.from(
            json["uhMccTypeThrees"].map((x) => UhMccTypeThree.fromJson(x))),
        mccName: json["mccName"],
        mcc: json["mcc"],
      );

  Map<String, dynamic> toJson() => {
        "uhMccTypeThrees":
            List<dynamic>.from(uhMccTypeThrees.map((x) => x.toJson())),
        "mccName": mccName,
        "mcc": mcc,
      };
}

class UhMccTypeThree {
  UhMccTypeThree({
    this.mccName,
    this.mcc,
  });

  String? mccName;
  String? mcc;

  factory UhMccTypeThree.fromJson(Map<String, dynamic> json) => UhMccTypeThree(
        mccName: json["mccName"],
        mcc: json["mcc"],
      );

  Map<String, dynamic> toJson() => {
        "mccName": mccName,
        "mcc": mcc,
      };
}
