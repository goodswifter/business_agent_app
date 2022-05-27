// To parse this JSON data, do
//
//     final merchantBasicInfo = merchantBasicInfoFromJson(jsonString);

import 'dart:convert';

MerchantBasicInfoModel merchantBasicInfoFromJson(String str) => MerchantBasicInfoModel.fromJson(json.decode(str));

String merchantBasicInfoToJson(MerchantBasicInfoModel data) => json.encode(data.toJson());

class MerchantBasicInfoModel {
    MerchantBasicInfoModel({
        this.merchantName,
        this.merchantShortName,
        this.servicePhone,
        this.mcc,
        this.microBizType,
        this.email,
        this.contactName,
        this.contactIdCardNum,
        this.contactMobile,
    });

    String? merchantName;
    String? merchantShortName;
    String? servicePhone;
    String? mcc;
    int? microBizType;
    String? email;
    String? contactName;
    String? contactIdCardNum;
    String? contactMobile;

    factory MerchantBasicInfoModel.fromJson(Map<String, dynamic> json) => MerchantBasicInfoModel(
        merchantName: json["merchantName"],
        merchantShortName: json["merchantShortName"],
        servicePhone: json["servicePhone"],
        mcc: json["mcc"],
        microBizType: json["microBizType"],
        email: json["email"],
        contactName: json["contactName"],
        contactIdCardNum: json["contactIdCardNum"],
        contactMobile: json["contactMobile"],
    );

    Map<String, dynamic> toJson() => {
        "merchantName": merchantName,
        "merchantShortName": merchantShortName,
        "servicePhone": servicePhone,
        "mcc": mcc,
        "microBizType": microBizType,
        "email": email,
        "contactName": contactName,
        "contactIdCardNum": contactIdCardNum,
        "contactMobile": contactMobile,
    };
}
