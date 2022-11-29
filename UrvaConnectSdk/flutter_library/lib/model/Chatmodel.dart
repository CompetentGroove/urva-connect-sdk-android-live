import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_library/utils/Colors.dart';
import 'package:flutter_library/utils/Extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Chatmodel {
  String? id="";
  String? name="", oldMap="", newMap="";
  String? fname = '';
  bool? local = true;
  String? msg;
  String? msgtype="";
  int exp = 1;
  var isSender;
  String? type="";
  var lat, long;
  var file;
  var duration;
  var date;
  bool uploaded = true;
  bool loaded = false;
  bool? isPrivate = false;
  bool? isurl = false;
  var color;
  bool isSelected = false;
  bool isHovering = false;
  var messageBody;
  String? receiverUser="";
  var receiverUserColorPrimary;
  var receiverUserColorSecondry;
  bool? receiverUserHeader = false;

  var pcolor = telegram;
  var panelcolor = Color(0xFFffc7c7);
  var privatecolor;

  String? sender;
  String? col_id;
  String? thread_id;
  String? user_ids;
  String? received_at;
  String? chat_id;
  String? syncStatus;
  String? smsStatus;
  String Type="";
  String? sendbyUSer ="";
  String? s_msg_uniq_id ="";
  String? DateFromServer ="";

  String? System_type ="";
  String? status ="";
  Uint8List? unit8list;


  String? thread_title ="";
  String? thread_added_date ="";
  String? thread_assignedto ="";
  String? isUploading = "";

  Chatmodel({
    this.name,
    this.id,
    this.msg,
    this.oldMap,
    this.newMap,
    this.file,
    this.color,
    this.local,
    this.fname,
    this.isSender,
    this.type,
    this.long,
    this.isPrivate,
    this.isurl,
    this.msgtype,
    this.date,
    this.messageBody,
    this.lat,
    this.duration,
    this.receiverUser,
    this.receiverUserColorPrimary,
    this.receiverUserColorSecondry,
    this.receiverUserHeader,
    this.sender,
    this.col_id,
    this.thread_id,
    this.user_ids,
    this.received_at,
    this.chat_id,
    this.syncStatus,
    this.smsStatus,
    this.sendbyUSer,
    this.s_msg_uniq_id,
    this.DateFromServer,
    this.System_type,
    this.status,

    this.thread_title,
    this.thread_added_date,
    this.thread_assignedto,
    this.isUploading,
/*,
 this.pcolor,
  this.panelcolor,
  this.privatecolor,*/
  });

  factory Chatmodel.fromJson(Map<dynamic, dynamic> json, String User,) {
    var pcolor = white;
    var Headercolor = red;
    String date = '';
    RegExp exp =
    new RegExp(r'(?:(?:https?|http):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');

    bool isurl = exp.hasMatch(json['full_msg']['Body'] ?? "");
    String type = "Message";
    String fname = '';
    bool islocal = true;
    bool isprivate = false;

    if (DateFormat('yyyy/MM/dd').format(DateTime.now()) ==
        DateFormat('yyyy/MM/dd').format(DateTime.fromMillisecondsSinceEpoch(
            json['full_msg']['date'] * 1000))) {
      date = 'Today';
    } else if (DateFormat('yyyy/MM/dd').format(DateTime.now().subtract(Duration(days: 1))) == DateFormat('yyyy/MM/dd').format(DateTime.fromMillisecondsSinceEpoch(
        json['full_msg']['date'] * 1000))) {
      date = 'Yesterday';
    } else if (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(json['full_msg']['date'] * 1000)) <= Duration(days: 7)) {
      date = DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(json['full_msg']['date'] * 1000));
    } else
      date = DateFormat('dd MMM yyyy').format(
          DateTime.fromMillisecondsSinceEpoch(json['full_msg']['date'] * 1000));

    if (json['full_msg']['MediaContentType0'] != null) {
      islocal = false;
      if (json['full_msg']['MediaContentType0'].toString().contains('image')) {
        type = 'image';
      } else if (json['full_msg']['MediaContentType0']
          .toString()
          .contains('audio')) {
        type = 'audio';
      } else if (json['full_msg']['MediaContentType0']
          .toString()
          .contains('video')) {
        type = 'video';

      } else if (json['full_msg']['MediaContentType0'].toString().contains('application') ||
          json['full_msg']['MediaContentType0'].toString().contains('pdf') ||
          json['full_msg']['MediaContentType0'].toString().contains('doc')) {
        type = 'doc';
        fname = json['full_msg']['MediaUrl0'].toString().split('/').last ;

      }
    }
    else if (json['full_msg']['MediaUrl0'] != null) {
      islocal = false;
      if (json['MediaContentType0'].toString().contains('image/')) {
        type = 'image';
      } else if (json['MediaContentType0'].toString().contains('audio/')) {
        type = 'audio';
      } else if (json['MediaContentType0'].toString().contains('video/')) {
        type = 'video';
      }
      else if (json['full_msg']['MediaUrl0'].toString().contains('pdf') ||
          json['full_msg']['MediaUrl0'].toString().contains('doc')) {

        type = 'doc';
        fname = json['full_msg']['MediaUrl0'].toString().split('/').last;

      }
    }
    if (json['full_msg']['Latitude'] != null) {
      type = 'location';
    }
    if (json['msg_type'] != null &&
        json['msg_type'] != 'OTP_SENT' &&
        json['full_msg']['type'] != null &&
        json['full_msg']['type'] == 'private') isprivate = true;


    if (json['platform'] == 'whatsapp') {
      pcolor = whatsapp;
    } else if (json['platform'] == 'telegram'){
      pcolor = telegram;
    }
    else if (json['platform'] == 'twitter') {
      pcolor = twitter;
    } else if (json['platform'] == 'google') {
      pcolor = google;
    } else if (json['platform'] == 'Converge') {
      pcolor = chatabselected;
    }

    bool receiverUserHeader = false;
    bool IsSender = false;

    Color HeaderPrimaryColor = Color(int.parse("#FF0000".substring(1, 7), radix: 16) + 0xFF000000);
    Color HeaderSecondryColor = Color(int.parse("#000000".substring(1, 7), radix: 16) + 0xFF000000);



    if (json['user'] != null && json['user'] != "null"
        && json['user'].toString().length > 0
        && json['user'] == User.toString()) {
        IsSender = true;
        receiverUserHeader = false;


      // String firstletterUsername = json['user'].toString().substring(0, 1);
      // //   String mFirstRandomLatter=getRandomString(1);
      // String mlatter = firstletterUsername.toLowerCase();
      // var value = Headercolors['$mlatter'];


      // String colorval1 = value![0];
      // String colorval2 = value![1];
      // HeaderPrimaryColor = Color(int.parse(colorval2.substring(1, 7), radix: 16) + 0xFF000000);
      // HeaderSecondryColor = Color(int.parse(colorval1.substring(1, 7), radix: 16) + 0xFF000000);

      // if(json['category'] == 'S'){
      //   IsSender =true;
      // }
      // } else if (json['category'] == 'R' && json['user'] == null) {
      //   IsSender = false;
      // }
      // // else if (json['full_msg']['Body'] == 'Video Call ended') {
      // //   IsSender = false;
      // // }
      // else if (json['category'] == 'R') {
      //   IsSender = false;
      // } else {
      //   IsSender = true;
      // }
    }
      else{
      IsSender = false;
    }


    // chat: {
    //   first_name: Harry
    // },
    // full_msg: {
    //
    // }

      var userName= json['full_msg']['chat']['first_name'].toString();

    if (json['user'] == null || json['user'].toString() == "null") {
      receiverUserHeader = false;
    }

    if (json['platform'] == "telegram") {
      // print('zzz===>' +
      //     json['_id'].toString() +
      //     "<===>" +
      //     json['platform'].toString() +
      //     "<====>" +
      //     json['full_msg']['Body'].toString());
    }

    //   print("sms statuuasd sd===>"+smsStatus.toString());
    return Chatmodel(
        DateFromServer:  json['full_msg']['date'].toString(),
        name: userName,
        s_msg_uniq_id: "",
        isSender: IsSender,
        id: json['_id'].toString(),
        //  return Chatmodel(isSender: json['category'] == 'R' ? false : (json['full_msg']['Body'] == 'Video Call ended' ? false : true),
        receiverUser: json['user'].toString(),
        receiverUserHeader: receiverUserHeader,
        receiverUserColorPrimary: HeaderPrimaryColor,
        receiverUserColorSecondry: HeaderSecondryColor,
        msg: json['full_msg']['Body'] ?? "",
        oldMap: json['full_msg']['old_mapping'] ?? "",
        newMap: json['full_msg']['new_mapping'] ?? "",
        type: type,
        local: islocal,
        msgtype: json['msg_type'],
        isurl: isurl,
        messageBody: json,
        date: date,
        color: pcolor,
        chat_id: json['chat_id'],
        thread_id: json['full_msg']['thread_id'],
        isPrivate: isprivate,
        smsStatus:json['full_msg']['SmsStatus'],
        fname: fname,
        file: json['full_msg']['MediaUrl0'] ?? "",
        lat: json['full_msg']['Latitude'],
        long: json['full_msg']['Longitude'],
        received_at: json['received_at'],

        System_type:json['full_msg']['type'].toString(),
        status : json['full_msg']['status'].toString(),

        // thread_title: threadtitles,
        // thread_added_date: threadadded_at,
        // thread_assignedto:threadassigned_to,

        duration: DateFormat('hh:mm a').format(
            DateTime.fromMillisecondsSinceEpoch(
                json['full_msg']['date'] * 1000)));
  }



  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }


  factory Chatmodel.fromJsonsocket(Map<String, dynamic> json, String User) {
    var pcolor = white;
    String date = '';

//    print("Json bodssssssssss=ssss==>" + json.toString() );
//    String mJsonstring = json['chat'].toString();

    bool private = false;

    RegExp exp =
    new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    bool isurl = exp.hasMatch(json['Body'] ?? "");
    String type = "Message";
    String fname = '';
    if (DateFormat('yyyy/MM/dd').format(DateTime.now()) ==
        DateFormat('yyyy/MM/dd').format(DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000))) {

      date = 'Today';

    } else if (DateFormat('yyyy/MM/dd').format(DateTime.now().subtract(Duration(days: 1))) ==
        DateFormat('yyyy/MM/dd').format(DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000))) {

      date = 'Yesterday';

    } else if (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000)) <= Duration(days: 7)) {

      date = DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000));

    } else
      date = DateFormat('yyyy/MM/dd').format(DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000));

    if (json['MediaContentType0'] != null) {
      if (json['MediaContentType0'].toString().contains('image/')) {
        type = 'image';
      } else if (json['MediaContentType0'].toString().contains('audio/')) {
        type = 'audio';
      } else if (json['MediaContentType0'].toString().contains('video/')) {
        type = 'video';
      } else if (json['MediaContentType0'].toString().contains('application/')) {
        type = 'doc';
        fname = json['MediaUrl0'].toString().split('/').last ;
        // fname = json['MediaUrl0'].toString().split('/').last +
        //     "." +
        //     json['MediaContentType0'].toString().split('/').last;
      }

    }

    if (json['type'] == "private") {
      private = true;
    }

    if (json['Latitude'] != null) {
      type = 'location';
    }
    if (json['platform'] == 'whatsapp')
      pcolor = whatsapp;
    else if (json['platform'] == 'telegram')
      pcolor = telegram;
    else if (json['platform'] == 'twitter')
      pcolor = twitter;
    else if (json['platform'] == 'google') pcolor = google;

    bool receiverUserHeader = false;
    bool IsSender = false;

    Color HeaderPrimaryColor = Color(int.parse("#FF0000".substring(1, 7), radix: 16) + 0xFF000000);
    Color HeaderSecondryColor = Color(int.parse("#000000".substring(1, 7), radix: 16) + 0xFF000000);
    //print("=============user ====>>"+json['user'].toString());

    // if (json['user'] != null && json['user'] != "null" && json['user'].toString().length > 0 && json['user'] != User.toString()) {
    //
    //   IsSender = false;
    //   receiverUserHeader = true;
    //
    //   String firstletterUsername = json['user'].toString().substring(0, 1);
    //   String firstletterUse= firstletterUsername.toLowerCase();
    //   var value = Headercolors['$firstletterUse'];
    //
    //   // String colorvalue1 = value[0];
    //   // String colorvalue = value[1];
    //
    //   // HeaderPrimaryColor = Color(int.parse(colorvalue.substring(1, 7), radix: 16) + 0xFF000000);
    //   // HeaderSecondryColor = Color(int.parse(colorvalue1.substring(1, 7), radix: 16) + 0xFF000000);
    // }


    if (json['user'] == null || json['user'].toString() == "null") {
      receiverUserHeader = false;
    }

    //print("date asd====>"+json['date'].toString());

    return Chatmodel(
        DateFromServer:  json['date'].toString(),
        s_msg_uniq_id: getTimeStemp(""),
        isSender: IsSender,
        receiverUser: json['user'].toString(),
        receiverUserHeader: receiverUserHeader,
        receiverUserColorPrimary: HeaderPrimaryColor,
        receiverUserColorSecondry: HeaderSecondryColor,
        //id: json['_id'].toString(),
        id:getTimeStemp(json['thread_id']).toString(),
        msg: json['Body'] ?? "",
        type: type,
        syncStatus: "1",
        chat_id: json['chat_id'],
        //     element.chatid == args['chat_id']
        fname: fname,
        thread_id: json['thread_id'],
        color: pcolor,
        msgtype: json['msgtype'] ?? json['type'] ?? "DEFAULT",
        local: false,
        oldMap: json['old_mapping'],
        newMap: json['new_mapping'],
        date: date,
        received_at: GetCurrentUtcDate(),
        isPrivate: private,
        isurl: isurl,
        smsStatus: json['SmsStatus'],
        lat: json['Latitude'],
        long: json['Longitude'],
        file: json['MediaUrl0'] ?? "",

        // System_type:json['full_msg']['type'].toString(),
        // status : json['full_msg']['status'].toString(),


        duration: DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000)));
  }


}
