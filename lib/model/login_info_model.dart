class LoginInfoModel {
  String? code;
  String? message;
  String? requestId;
  Data? data;

  LoginInfoModel({this.code, this.message, this.requestId, this.data});

  LoginInfoModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    requestId = json['requestId'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['requestId'] = this.requestId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  String? refreshToken;

  Data({this.token, this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
