class LoginModel {
  bool? status;
  String? message; 
  UserData? data;
  LoginModel();
    LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null? UserData.fromJson(json['data'] ):null;
  
  }
}

class UserData {
  int? id;
  String? email;
  String? name;
  String? image;
  String? phone;
  int? points;
  int? credit;
  String? token;
  /*UserData({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.image = '',
    this.points = 0,
    this.credit = 0,
    this.token = '',
  });*/
  //named constuctor
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
