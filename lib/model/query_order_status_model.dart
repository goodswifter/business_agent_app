class QueryOrderStatusModel {
  String? code;
  String? message;
  String? requestId;
  OrderItem? data;

  QueryOrderStatusModel({this.code, this.message, this.requestId, this.data});

  QueryOrderStatusModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    requestId = json['requestId'];
    data = json['data'] != null ? OrderItem.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    data['requestId'] = requestId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OrderItem {
  String? ordNo;
  String? ordType;
  String? ordOwn;
  double? amt;
  double? cashAmount;
  String? ordSts;
  String? qrCode;
  String? ordChan;
  String? payNo;
  String? payerInfo;
  String? tranFlag;
  String? qrType;
  String? payTime;

  OrderItem(
      {this.ordNo,
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
      this.payTime});

  OrderItem.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
