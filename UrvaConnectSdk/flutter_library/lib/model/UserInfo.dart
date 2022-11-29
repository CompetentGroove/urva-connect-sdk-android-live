class UserInfo {
  int? id;
  String? firstName = '';
  String? lastName = '';
  String? username;
  String? empCode;
  String? email;
  String? designation;
  String? mobileNo;
  String? reportingTo;
  String? birthday;
  String? geoAddress;
  String? shiftStart;
  String? shiftEnd;
  int? trackInterval;
  int? archDays;
  String? isAllowedSignout;
  String? signature;
  int? isGps;
  int? isGpsMandatory;
  String? category;
  dynamic fpAttend;
  int? isAttendMandatory;
  int? calendar;
  int? is_manager;
  String? macadd;
  int? bands;
  int? isTapTarget;
  String? isAcceptTerms;
  int? isBypassLocationOnError;
  String? conveyance;
  String? profilePic;
  String? isProfilePicApproved;
  int? isEmailVerify;
  ClaimManagement? claimManagement;
  NearByCustomers? nearByCustomers;
  SmsCallRecording? smsCallRecording;
  OmniChannel? omniChannel;

  UserInfo(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.empCode,
      this.email,
      this.designation = '',
      this.mobileNo,
      this.reportingTo,
      this.birthday,
      this.geoAddress,
      this.shiftStart,
      this.shiftEnd,
      this.trackInterval,
      this.archDays,
      this.isAllowedSignout,
      this.signature,
      this.isGps,
      this.isGpsMandatory,
      this.category,
      this.fpAttend,
      this.isAttendMandatory,
      this.calendar,
      this.macadd,
      this.bands,
      this.isTapTarget,
      this.isAcceptTerms,
      this.isBypassLocationOnError,
      this.conveyance,
      this.profilePic,
      this.isProfilePicApproved,
      this.isEmailVerify,
      this.is_manager,
      this.claimManagement,
      this.nearByCustomers,
      this.smsCallRecording,
      this.omniChannel});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    empCode = json['emp_code'];
    email = json['email'];
    designation = json['designation'];
    mobileNo = json['mobile_no'];
    reportingTo = json['reporting_to'];
    birthday = json['birthday'];
    is_manager=json["is_manager"];
    geoAddress = json['geo_address'];
    shiftStart = json['shift_start'];
    shiftEnd = json['shift_end'];
    trackInterval = json['track_interval'];
    archDays = json['arch_days'];
    isAllowedSignout = json['is_allowed_signout'];
    signature = json['signature'];
    isGps = json['is_gps'];
    isGpsMandatory = json['is_gps_mandatory'];
    category = json['category'];
    fpAttend = json['fp_attend'];
    isAttendMandatory = json['is_attend_mandatory'];
    calendar = json['calendar'];
    macadd = json['macadd'];
    bands = json['bands'];
    isTapTarget = json['is_tap_target'];
    isAcceptTerms = json['is_accept_terms'];
    isBypassLocationOnError = json['is_bypass_location_on_error'];
    conveyance = json['conveyance'];
    profilePic = json['profile_pic'];
    isProfilePicApproved = json['is_profile_pic_approved'];
    isEmailVerify = json['is_email_verify'];
    claimManagement = json['claim_management'] != null
        ? new ClaimManagement.fromJson(json['claim_management'])
        : null;
    nearByCustomers = json['near_by_customers'] != null
        ? new NearByCustomers.fromJson(json['near_by_customers'])
        : null;
    smsCallRecording = json['sms_call_recording'] != null
        ? new SmsCallRecording.fromJson(json['sms_call_recording'])
        : null;
    omniChannel = json['omni_channel'] != null
        ? new OmniChannel.fromJson(json['omni_channel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['is_manager'] = this.is_manager;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['emp_code'] = this.empCode;
    data['email'] = this.email;
    data['designation'] = this.designation;
    data['mobile_no'] = this.mobileNo;
    data['reporting_to'] = this.reportingTo;
    data['birthday'] = this.birthday;
    data['geo_address'] = this.geoAddress;
    data['shift_start'] = this.shiftStart;
    data['shift_end'] = this.shiftEnd;
    data['track_interval'] = this.trackInterval;
    data['arch_days'] = this.archDays;
    data['is_allowed_signout'] = this.isAllowedSignout;
    data['signature'] = this.signature;
    data['is_gps'] = this.isGps;
    data['is_gps_mandatory'] = this.isGpsMandatory;
    data['category'] = this.category;
    data['fp_attend'] = this.fpAttend; 
    data['is_attend_mandatory'] = this.isAttendMandatory;
    data['calendar'] = this.calendar;
    data['macadd'] = this.macadd;
    data['bands'] = this.bands;
    data['is_tap_target'] = this.isTapTarget;
    data['is_accept_terms'] = this.isAcceptTerms;
    data['is_bypass_location_on_error'] = this.isBypassLocationOnError;
    data['conveyance'] = this.conveyance;
    data['profile_pic'] = this.profilePic;
    data['is_profile_pic_approved'] = this.isProfilePicApproved;
    data['is_email_verify'] = this.isEmailVerify;
    // if (this.claimManagement != null) {
    //   data['claim_management'] = this.claimManagement.toJson();
    // }
    // if (this.nearByCustomers != null) {
    //   data['near_by_customers'] = this.nearByCustomers.toJson();
    // }
    // if (this.smsCallRecording != null) {
    //   data['sms_call_recording'] = this.smsCallRecording.toJson();
    // }
    // if (this.omniChannel != null) {
    //   data['omni_channel'] = this.omniChannel.toJson();
    // }
    return data;
  }
}

class ClaimManagement {
  bool? isOcr;
  List<Ocr>? ocr;
  bool? allowComments;
  bool? allowAttachFiles;

  ClaimManagement(
      {this.isOcr, this.ocr, this.allowComments, this.allowAttachFiles});

  ClaimManagement.fromJson(Map<String, dynamic> json) {
    isOcr = json['is_ocr'];
    if (json['ocr'] != null) {
      // ocr = new List<Ocr>();
      // json['ocr'].forEach((v) {
      //   ocr.add(new Ocr.fromJson(v));
      // });
    }
    allowComments = json['allow_comments'];
    allowAttachFiles = json['allow_attach_files'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_ocr'] = this.isOcr;
    // if (this.ocr != null) {
    //   data['ocr'] = this.ocr.map((v) => v.toJson()).toList();
    // }
    data['allow_comments'] = this.allowComments;
    data['allow_attach_files'] = this.allowAttachFiles;
    return data;
  }
}

class Ocr {
  String? template;
  String? library;
  String? templateSeperatar;
  String? ml;

  Ocr({this.template, this.library, this.templateSeperatar, this.ml});

  Ocr.fromJson(Map<String, dynamic> json) {
    template = json['template'];
    library = json['library'];
    templateSeperatar = json['template_seperatar'];
    ml = json['ml'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['template'] = this.template;
    data['library'] = this.library;
    data['template_seperatar'] = this.templateSeperatar;
    data['ml'] = this.ml;
    return data;
  }
}

class NearByCustomers {
  int? travelDistance;
  int? customersNearby;
  int? limitRecords;
  String? name;

  NearByCustomers(
      {this.travelDistance,
      this.customersNearby,
      this.limitRecords,
      this.name});

  NearByCustomers.fromJson(Map<String, dynamic> json) {
    travelDistance = json['travel_distance'];
    customersNearby = json['customers_nearby'];
    limitRecords = json['limit_records'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['travel_distance'] = this.travelDistance;
    data['customers_nearby'] = this.customersNearby;
    data['limit_records'] = this.limitRecords;
    data['name'] = this.name;
    return data;
  }
}

class SmsCallRecording {
  String? collection;
  String? columnName;

  SmsCallRecording({this.collection, this.columnName});

  SmsCallRecording.fromJson(Map<String, dynamic> json) {
    collection = json['collection'];
    columnName = json['column_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collection'] = this.collection;
    data['column_name'] = this.columnName;
    return data;
  }
}

class OmniChannel {
  String? collection;
  String? phone;
  String? firstName;
  String? chatId;

  OmniChannel({this.collection, this.phone, this.firstName, this.chatId});

  OmniChannel.fromJson(Map<String, dynamic> json) {
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
