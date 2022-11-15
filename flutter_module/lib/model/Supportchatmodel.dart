class Supportchatmodel {
  int? status;
  Data? data;
  String? message;
  Supportchatmodel({this.status, this.data, this.message});

  Supportchatmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  UserInfo? userInfo;
  Permission? permission;
  String? token;

  Data({this.userInfo, this.permission, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
    permission = json['permission'] != null
        ? new Permission.fromJson(json['permission'])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo?.toJson();
    }
    if (this.permission != null) {
      data['permission'] = this.permission?.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class UserInfo {
  int? id;
  String? cOL0;
  String? cOL1;
  String? cOL2;
  String? cOL3;
  String? cOL4;
  String? cOL5;
  String? cOL6;
  String? cOL7;
  String? cOL8;
  String? cOL9;
  String? cOL10;
  String? cOL11;
  String? cOL12;
  String? cOL13;
  String? cOL14;
  String? cOL15;
  String? cOL16;
  String? cOL17;
  String? cOL18;
  String? cOL19;
  String? cOL20;
  String? cOL21;
  String? cOL22;
  String? cOL23;
  String? cOL24;
  String? cOL25;
  String? cOL26;
  String? cOL27;
  String? createdDate;
  int? createdBy;
  String? createdByType;
  String? modifiedDate;
  int? modifiedBy;
  String? modifiedByType;
  String? fieldId;
  String? lastUsedAt;
  String? lastUsedBy;
  String? lastUsedByType;
  int? usedCount;
  String? state;
  String? latitude;
  String? longitude;
  int? modifyCount;
  int? isTax;
  String? exemptTaxReason;
  String? intraTax;
  String? interTax;
  String? type;
  String? uNumber;
  String? discountScheme;
  String? lastInvited;
  String? username;
  OrgInfo? orgInfo;

  UserInfo(
      {this.id,
        this.cOL0,
        this.cOL1,
        this.cOL2,
        this.cOL3,
        this.cOL4,
        this.cOL5,
        this.cOL6,
        this.cOL7,
        this.cOL8,
        this.cOL9,
        this.cOL10,
        this.cOL11,
        this.cOL12,
        this.cOL13,
        this.cOL14,
        this.cOL15,
        this.cOL16,
        this.cOL17,
        this.cOL18,
        this.cOL19,
        this.cOL20,
        this.cOL21,
        this.cOL22,
        this.cOL23,
        this.cOL24,
        this.cOL25,
        this.cOL26,
        this.cOL27,
        this.createdDate,
        this.createdBy,
        this.createdByType,
        this.modifiedDate,
        this.modifiedBy,
        this.modifiedByType,
        this.fieldId,
        this.lastUsedAt,
        this.lastUsedBy,
        this.lastUsedByType,
        this.usedCount,
        this.state,
        this.latitude,
        this.longitude,
        this.modifyCount,
        this.isTax,
        this.exemptTaxReason,
        this.intraTax,
        this.interTax,
        this.type,
        this.uNumber,
        this.discountScheme,
        this.lastInvited,
        this.username,
        this.orgInfo});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cOL0 = json['COL0'].toString();
    cOL1 = json['COL1'].toString();
    cOL2 = json['COL2'].toString();
    cOL3 = json['COL3'].toString();
    cOL4 = json['COL4'].toString();
    cOL5 = json['COL5'].toString();
    cOL6 = json['COL6'].toString();
    cOL7 = json['COL7'].toString();
    cOL8 = json['COL8'].toString();
    cOL9 = json['COL9'].toString();
    cOL10 = json['COL10'].toString();
    cOL11 = json['COL11'].toString();
    cOL12 = json['COL12'].toString();
    cOL13 = json['COL13'] ?? "";
    cOL14 = json['COL14'].toString();
    cOL15 = json['COL15'].toString();
    cOL16 = json['COL16'].toString();
    cOL17 = json['COL17'].toString();
    cOL18 = json['COL18'].toString();
    cOL19 = json['COL19'].toString();
    cOL20 = json['COL20'].toString();
    cOL21 = json['COL21'].toString();
    cOL22 = json['COL22'].toString();
    cOL23 = json['COL23'].toString();
    cOL24 = json['COL24'].toString();
    cOL25 = json['COL25'].toString();
    cOL26 = json['COL26'].toString();
    cOL27 = json['COL27'].toString();
    createdDate = json['created_date'].toString();
    createdBy = json['created_by'];
    createdByType = json['created_by_type'].toString();
    modifiedDate = json['modified_date'].toString();
    modifiedBy = json['modified_by'];
    modifiedByType = json['modified_by_type'].toString();
    fieldId = json['field_id'].toString();
    lastUsedAt = json['last_used_at'].toString();
    lastUsedBy = json['last_used_by'].toString();
    lastUsedByType = json['last_used_by_type'].toString();
    usedCount = json['used_count'];
    state = json['state'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    modifyCount = json['modify_count'];
    isTax = json['is_tax'];
    exemptTaxReason = json['exempt_tax_reason'].toString();
    intraTax = json['intra_tax'].toString();
    interTax = json['inter_tax'].toString();
    type = json['type'].toString();
    uNumber = json['u_number'].toString();
    discountScheme = json['discount_scheme'].toString();
    lastInvited = json['last_invited'].toString();
    username = json['username'].toString();
    orgInfo = json['org_info'] != null
        ? new OrgInfo.fromJson(json['org_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['COL0'] = this.cOL0;
    data['COL1'] = this.cOL1;
    data['COL2'] = this.cOL2;
    data['COL3'] = this.cOL3;
    data['COL4'] = this.cOL4;
    data['COL5'] = this.cOL5;
    data['COL6'] = this.cOL6;
    data['COL7'] = this.cOL7;
    data['COL8'] = this.cOL8;
    data['COL9'] = this.cOL9;
    data['COL10'] = this.cOL10;
    data['COL11'] = this.cOL11;
    data['COL12'] = this.cOL12;
    data['COL13'] = this.cOL13;
    data['COL14'] = this.cOL14;
    data['COL15'] = this.cOL15;
    data['COL16'] = this.cOL16;
    data['COL17'] = this.cOL17;
    data['COL18'] = this.cOL18;
    data['COL19'] = this.cOL19;
    data['COL20'] = this.cOL20;
    data['COL21'] = this.cOL21;
    data['COL22'] = this.cOL22;
    data['COL23'] = this.cOL23;
    data['COL24'] = this.cOL24;
    data['COL25'] = this.cOL25;
    data['COL26'] = this.cOL26;
    data['COL27'] = this.cOL27;
    data['created_date'] = this.createdDate;
    data['created_by'] = this.createdBy;
    data['created_by_type'] = this.createdByType;
    data['modified_date'] = this.modifiedDate;
    data['modified_by'] = this.modifiedBy;
    data['modified_by_type'] = this.modifiedByType;
    data['field_id'] = this.fieldId;
    data['last_used_at'] = this.lastUsedAt;
    data['last_used_by'] = this.lastUsedBy;
    data['last_used_by_type'] = this.lastUsedByType;
    data['used_count'] = this.usedCount;
    data['state'] = this.state;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['modify_count'] = this.modifyCount;
    data['is_tax'] = this.isTax;
    data['exempt_tax_reason'] = this.exemptTaxReason;
    data['intra_tax'] = this.intraTax;
    data['inter_tax'] = this.interTax;
    data['type'] = this.type;
    data['u_number'] = this.uNumber;
    data['discount_scheme'] = this.discountScheme;
    data['last_invited'] = this.lastInvited;
    data['username'] = this.username;
    if (this.orgInfo != null) {
      data['org_info'] = this.orgInfo?.toJson();
    }
    return data;
  }
}

class OrgInfo {
  String? uniqueCode;
  String? logo;
  String? apiKey;
  String? primary_color;
  String? primary_dark_color;



  OrgInfo({this.uniqueCode, this.logo, this.apiKey});

  OrgInfo.fromJson(Map<String, dynamic> json) {
    uniqueCode = json['unique_code'];
    logo = json['logo'];
    apiKey = json['api_key'];
    primary_color = json['primary_color'];
    primary_dark_color = json['primary_dark_color'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unique_code'] = this.uniqueCode;
    data['logo'] = this.logo;
    data['api_key'] = this.apiKey;
    data['primary_color'] = this.primary_color;
    data['primary_dark_color'] = this.primary_dark_color;
    return data;
  }
}

class Permission {
  String? collection;
  String? phone;
  String? firstName;
  String? chatId;

  Permission({this.collection, this.phone, this.firstName, this.chatId});

  Permission.fromJson(Map<String, dynamic> json) {
    collection = json['collection'];
    phone = json['phone'];
    firstName = json['first_name'];
    chatId = json['chat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collection'] = this.collection;
    data['phone'] = this.phone;
    data['first_name'] = this.firstName;
    data['chat_id'] = this.chatId;
    return data;
  }
}