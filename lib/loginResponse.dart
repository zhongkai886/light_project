class LoginResponse {
  Data? data;
  String? token;

  LoginResponse({this.data, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? password;
  String? name;
  String? email;
  String? sex;
  String? status;

  Data(
      {this.id,
      this.userId,
      this.password,
      this.name,
      this.email,
      this.sex,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    password = json['password'];
    name = json['name'];
    email = json['email'];
    sex = json['sex'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['password'] = this.password;
    data['name'] = this.name;
    data['email'] = this.email;
    data['sex'] = this.sex;
    data['status'] = this.status;
    return data;
  }
}