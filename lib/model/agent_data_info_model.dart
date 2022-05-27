///代理商登录成功数据  model
class AgentDataInfoModel {
  String? agentId;
  String? password;
  int? loginType;
  String? mobile;
  String? agentName;
  String? userName;
  int? status;

  AgentDataInfoModel(
      {this.agentId,
      this.password,
      this.loginType,
      this.mobile,
      this.agentName,
      this.userName,
      this.status});

  AgentDataInfoModel.fromJson(Map<String, dynamic> json) {
    agentId = json['agentId'];
    password = json['password'];
    loginType = json['loginType'];
    mobile = json['mobile'];
    agentName = json['agentName'];
    userName = json['userName'];
    status = json['status '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['agentId'] = this.agentId;
    data['password'] = this.password;
    data['loginType'] = this.loginType;
    data['mobile'] = this.mobile;
    data['agentName'] = this.agentName;
    data['userName'] = this.userName;
    data['status '] = this.status;
    return data;
  }
}
