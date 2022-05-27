class GraphicVerificationModel {
  String? code;
  String? message;
  String? requestId;
  GraphicVerificationItem? data;

  GraphicVerificationModel(
      {this.code, this.message, this.requestId, this.data});

  GraphicVerificationModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    requestId = json['requestId'];
    data = json['data'] != null
        ? GraphicVerificationItem.fromJson(json['data'])
        : null;
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

class GraphicVerificationItem {
  String? img;
  String? imgId;

  GraphicVerificationItem({this.img, this.imgId});

  GraphicVerificationItem.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    imgId = json['imgId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['img'] = this.img;
    data['imgId'] = this.imgId;
    return data;
  }
}
