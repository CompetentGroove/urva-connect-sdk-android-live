class InitcallModel {
  int? status;
  Data? data;
  String? message;

  InitcallModel({this.status, this.data, this.message});

  InitcallModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  UserInfo? userInfo;
  List<Categories>? categories;
  String? token;
  OrgInfo? orgInfo;

  Data({this.userInfo, this.categories, this.token, this.orgInfo});

  Data.fromJson(Map<String, dynamic> json) {
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    token = json['token'];
    orgInfo = json['org_info'] != null
        ? new OrgInfo.fromJson(json['org_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
    if (this.orgInfo != null) {
      data['org_info'] = this.orgInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? username;
  int? id;
  String? phone;
  String? firstName;

  UserInfo({this.username, this.id, this.phone, this.firstName});

  UserInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    id = json['id'];
    phone = json['phone'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['first_name'] = this.firstName;
    return data;
  }

}

class Categories {
  String? name;
  String? code;
  String? description;
  String? image;

  Categories({this.name, this.code, this.description, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}

class OrgInfo {
  String? logo;
  String? primaryColor;
  String? primaryDarkColor;
  String? companyName;
  String? unique_code;
  String? api_key;


  OrgInfo(
      {this.logo, this.primaryColor, this.primaryDarkColor, this.companyName,this.unique_code});

  OrgInfo.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    primaryColor = json['primary_color'];
    primaryDarkColor = json['primary_dark_color'];
    companyName = json['company_name'];
    unique_code =json['unique_code'];
    api_key  =json['api_key'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['primary_color'] = this.primaryColor;
    data['primary_dark_color'] = this.primaryDarkColor;
    data['company_name'] = this.companyName;
    data['unique_code'] = this.unique_code;
    data['api_key'] = this.api_key;
    return data;
  }

}