//收款订单记录列表 model
class OrderRecordListModel {
  String? code;
  String? message;
  String? requestId;
  List<OrderItemData> data = [];

  OrderRecordListModel(
      {this.code, this.message, this.requestId, required this.data});

  OrderRecordListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    requestId = json['requestId'];
    if (json['data'] != null) {
      // data = List<OrderItemData>();
      json['data'].forEach((v) {
        data.add(OrderItemData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    data['requestId'] = requestId;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItemData {
  String? ordNo;
  String? ordType;
  String? ordOwn;
  double? amt;
  // int cashAmount;
  double? cashAmount;
  String? ordSts;
  String? qrCode;
  String? ordChan;
  String? payNo;
  String? payerInfo;
  String? tranFlag;
  String? qrType;
  String? payTime;

  bool? isShowTime = false;

  OrderItemData({
    this.ordNo,
    this.ordType,
    this.ordOwn,
    this.amt,
    this.cashAmount,
    this.ordSts,
    this.qrCode,
    this.ordChan,
    this.payNo,
    this.payerInfo,
    this.tranFlag,
    this.qrType,
    this.payTime,
    this.isShowTime,
  });

  OrderItemData.fromJson(Map<String, dynamic> json) {
    ordNo = json['ordNo'];
    ordType = json['ordType'];
    ordOwn = json['ordOwn'];
    amt = json['amt'];
    cashAmount = json['cashAmount'];
    ordSts = json['ordSts'];
    qrCode = json['qrCode'];
    ordChan = json['ordChan'];
    payNo = json['payNo'];
    payerInfo = json['payerInfo'];
    tranFlag = json['tranFlag'];
    qrType = json['qrType'];
    payTime = json['payTime'];
    isShowTime = json['isShowTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ordNo'] = ordNo;
    data['ordType'] = ordType;
    data['ordOwn'] = ordOwn;
    data['amt'] = amt;
    data['cashAmount'] = cashAmount;
    data['ordSts'] = ordSts;
    data['qrCode'] = qrCode;
    data['ordChan'] = ordChan;
    data['payNo'] = payNo;
    data['payerInfo'] = payerInfo;
    data['tranFlag'] = tranFlag;
    data['qrType'] = qrType;
    data['payTime'] = payTime;
    data['isShowTime'] = isShowTime;
    return data;
  }
}
