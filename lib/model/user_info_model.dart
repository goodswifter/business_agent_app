//用户信息model
class UserInfoModel {
  late String code;
  late String message;
  String? requestId;
  UserItem? userItem;

  UserInfoModel(
      {required this.code,
      required this.message,
      this.requestId,
      this.userItem});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    requestId = json['requestId'];
    userItem = json['data'] != null ? UserItem.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['requestId'] = requestId;
    if (userItem != null) {
      data['data'] = userItem!.toJson();
    }
    return data;
  }
}

class UserItem {
  String? userNo; //用户id
  String? phone; //手机号
  String? payPwd;
  String? pwd;
  String? avatar;
  //用户实名状态   U:初始未认证  S:实名审核通过   W:认证提交未审核  F:用户销毁  R:实名审核拒绝
  String? status;
  String? type; //是个人还是企业  C 个人  B 企业
  String? inTm;
  String? modTm;
  List<UserExts> userExts = []; //用户扩展

  UserItem(
      {this.userNo,
      this.phone,
      this.payPwd,
      this.pwd,
      this.avatar,
      this.status,
      this.type,
      this.inTm,
      this.modTm,
      required this.userExts});

  UserItem.fromJson(Map<String, dynamic> json) {
    userNo = json['userNo'];
    phone = json['phone'];
    payPwd = json['payPwd'];
    pwd = json['pwd'];
    avatar = json['avatar'];
    status = json['status'];
    type = json['type'];
    inTm = json['inTm'];
    modTm = json['modTm'];
    if (json['userExts'] != null) {
      // userExts = List<UserExts>();
      json['userExts'].forEach((v) {
        userExts.add(UserExts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userNo'] = userNo;
    data['phone'] = phone;
    data['payPwd'] = payPwd;
    data['pwd'] = pwd;
    data['avatar'] = avatar;
    data['status'] = status;
    data['type'] = type;
    data['inTm'] = inTm;
    data['modTm'] = modTm;
    if (userExts != null) {
      data['userExts'] = userExts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserExts {
  String? type;
  String? value;
  String? rmk;

  UserExts({this.type, this.value, this.rmk});

  UserExts.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    rmk = json['rmk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['rmk'] = rmk;
    return data;
  }
}

// {
//     "code": "00000000",
//     "message": "success",
//     "requestId": "cd2157af79277464",
//     "data": {
//         "userNo": "2021063016400884100002",
//         "phone": "13716139232",
//         "payPwd": "",
//         "pwd": "",
//         "avatar": "",
//         "status": "U",
//         "type": "C",
//         "inTm": "2021-06-30 16:40:08",
//         "modTm": "2021-06-30 16:40:08",
//         "userExts": [
//             {
//                 "type": "C",
//                 "value": "2021-06-30 16:40:08",
//                 "rmk": "2021-06-30 16:40:08"
//             },
//             {
//                 "type": "C",
//                 "value": "2021-06-30 16:40:08",
//                 "rmk": "2021-06-30 16:40:08"
//             }
//         ]
//     }
// }
