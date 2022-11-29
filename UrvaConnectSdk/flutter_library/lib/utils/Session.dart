import 'dart:convert';


import 'package:flutter_library/model/UserInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String auth_token = "auth_token";
  final String filter = "filter";
  final String intro = "intro";
  String passcode="Passcode";
  //clean whole session
  Future<bool> cleansession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.clear();
  }

  //set data into shared preferences like this
  Future<void> setfilterval(String filter_val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.filter, filter_val);
  }

//set data into shared preferences like this
  void setAuthToken(String auth_token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.auth_token, auth_token);
  }

  //set data into shared preferences like this


  //set data into shared preferences like this
  void setintro(bool val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(this.intro, val);
  }

  void setUserInfo(Map<String, dynamic> userinfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   Map<String, dynamic> decode_options = userinfo;
    String user = jsonEncode(UserInfo.fromJson(decode_options));
    prefs.setString('user', user);
  }

  // void setCompanyInfo(Map<dynamic, dynamic> data) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Map decode_options = data;
  //   String user = jsonEncode(CompanyInfo.fromJson(decode_options));
  //   prefs.setString('company', user);
  // }





  void saveRoles(Map data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('roles', jsonEncode(data));
  }

  void saveDashboard(Map data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('dash', jsonEncode(data));
  }

  Future<Map?> getDashboard() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('dash')!=null? jsonDecode(pref.getString('dash')!):null;
  }
  // Future<RolesPermissions> getRoles() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   return pref.getString('roles')!=null?RolesPermissions.fromJson( jsonDecode(pref.getString('roles'))):null;
  // }



  void saveAllInfo(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('all_info_data', data);
  }
   Future<String?>  GetAllInfo() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('all_info_data');
  }



  void saveThreads(Map data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = jsonEncode(data);
    prefs.setString('threads', user);
  }


   Future<Map?> getThreads() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('threads')!=null ? jsonDecode(pref.getString('threads')!):null;
  }

  void setsecuritysettings(Map data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('security', jsonEncode(data));
  }
  Future<String?> getSecuritySharedPrefrences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  return   prefs.getString('security');
  }


  Future<String> setThreadID(String threadid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentThreadid', threadid);
    return 'saved';
  }
  Future<String>  getCurrentThreadid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var thread = prefs.getString('currentThreadid') ?? '';
return thread;
  }

  void setnotificationsettings(Map data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('notify', jsonEncode(data));
  }

  void settags(List<dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tags', jsonEncode(data));
  }
  Future<List<dynamic>?> gettags() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return jsonDecode(pref.getString('tags')??"[]");
  }

   Future<Map?> getsecuritysettings() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return jsonDecode(pref.getString('security')??"{}");
  }
   Future<Map?> getnotificationsettings() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return jsonDecode(pref.getString('notify')??"{}");
  }

  Future<UserInfo> getUserInfo() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(pref.getString('user')!);
    return UserInfo.fromJson(userMap);
  }





  // Future<CompanyInfo> getCompanyInfo() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   Map userMap = jsonDecode(pref.getString('company'));
  // // print("get company indo===>"+pref.getString('company'));
  //   return CompanyInfo.fromJson(userMap);
  // }

//get value from shared preferences
  Future<String?> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return  pref.getString(this.auth_token) ;
  }

  //get value from shared preferences
  Future<String?> getcode() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return  pref.getString(passcode) ;
  }

  //get value from shared preferences
  Future<String?> getfilterval() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(this.filter) ;
  }

  //get value from shared preferences
  Future<bool> getintro() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getBool(this.intro) ?? false;
  }


  void SetCategory(String datacat) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("category", datacat);
  }

  Future<String?> GetCategory() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return  pref.getString("category") ;
  }


  void setFaqTagsList(List<String> list) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("FAQ_TAG", list);
  }
  Future<List<String>?> getFaqTagsList() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return  pref.getStringList("FAQ_TAG") ;
  }



  void SetSocketNames(List<String> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Sockets', jsonEncode(data));
  }
  Future<List<String>?> GetSocketNames() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return jsonDecode(pref.getString('Sockets')??"[]");
  }

}
