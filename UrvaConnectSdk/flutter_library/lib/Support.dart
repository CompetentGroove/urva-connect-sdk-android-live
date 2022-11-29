import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_library/ImagePreview.dart';
import 'package:flutter_library/model/InitcallModel.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_library/main.dart';
import 'package:flutter_library/model/Chatmodel.dart';
import 'package:flutter_library/utils/Chatclip.dart';
import 'package:flutter_library/utils/Colors.dart';
import 'package:flutter_library/utils/Constants.dart';
import 'package:flutter_library/utils/CustsomIcon.dart';
import 'package:flutter_library/utils/Dimens.dart';
import 'package:flutter_library/utils/Extension.dart';
import 'package:flutter_library/utils/Session.dart';
import 'package:flutter_library/utils/platform_service.dart';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:uuid/uuid.dart';

// import 'dart:js' as js;
// import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as mime;

// String mFirstNameKey = "mahal";
// String mLastNameKey = "singh";
// String mUUidKey = "9814406463";
// String x_fp_api_key = "mZPP6Wf7ZswjtCwNaxWhHFZMoqwPMKMX";

import 'package:file/local.dart';
// import 'package:file_picker/file_picker.dart';


class Support extends StatefulWidget {
  static String tag = '/Support';

  @override
  SupportState createState() => SupportState();

// @override
// SupportState createState() => SupportState(controller);

}

class SupportState extends State<Support> with TickerProviderStateMixin {
  List<Chatmodel> chatmodel = [];
  bool isPrivate = false;
  late var args;
  TextEditingController? textController;
  List<String> usernames = [];
  String platform = "converge";

  // Supportchatmodel support;
  InitcallModel? initmodel;

  List<dynamic> socketdata = [];
  var privatecolor;
  String? mUsername = "";
  String? uniqcode = "", logourl = "";

  String? FirstName = "";
  String LastName = "";
  String? PhoneNumber = "";
  String? companyName = "";

  var pcolor = telegram;
  var primaryDark = telegram;
  String? media, unique_codes;
  Color HeaderPrimaryColor =
      Color(int.parse("#FF0000".substring(1, 7), radix: 16) + 0xFF000000);
  Color HeaderSecondryColor =
      Color(int.parse("#000000".substring(1, 7), radix: 16) + 0xFF000000);
  //ArsProgressDialog progressDialog;

  bool IsTextFeildDesable = true;
  bool IsBottomSheetOpen = false;
  int offset = 0;
  ScrollController? scrollController;

  String? _extension;
  late var _pickingType;
  Map<String, String>? _paths;
  String? _path;
  bool IsFileManagerPermissionEnable = true;
  late SessionManager prefs;
  @override
  void initState() {
    offset = 0;

     prefs = SessionManager();
    prefs.getCurrentThreadid().then((value) {
      SelectedThreadID=value;
    });
    textController = TextEditingController();

    final subscription = controller.stream.listen((String data) {
      print("controllerd===>");
      offset=0;
      CheckAuth();
    });

    PackageInfoGet();

    // mFirstNameKey = "harpreet";
    // mLastNameKey = "singh";
    // mUUidKey = "9814406463";
    // x_fp_api_key = "mZPP6Wf7ZswjtCwNaxWhHFZMoqwPMKMX";
    // mUrl = "https://demo.feetport.com";
    // OrgCode = "9122";

    if (kIsWeb) {
      CheckAuth();
    }

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    // });


    scrollController = ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.atEdge) {
        if (scrollController!.position.pixels == 0) {
        } else {
          if (!IsConnectionAvailable) {
            return;
          }
          ShowProgress(context);
          prefs.getThreads().then((value) async {
            if(value != null && value!=""){

              var headers = {
                'x-urva-key': value['x-urva-key'].toString(),
                'x-urva-secretkey': value['x-urva-secretkey'].toString()
              };

              print("herader sd===>"+headers.toString());
                getChats(true,headers);

            }else{
              // if (base_domain != "") {
              //   await LoginCall(context);
              // }
            }

          });

        }
      }
    });

  }



  void CheckAuth() async {
    if (kIsWeb) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        ShowProgress(context);
        CallDelay();
      });
    } else {
      Future.delayed(Duration.zero, () {
        ShowProgress(context);
        CallDelay();
      });
    }
  }

  void CallDelay() async {

    prefs.getThreads().then((value)  {
      if(value != null && value!=""){
        NotShowCategory = true;
      }
    });
    if (base_domain != "") {
       LoginCall(context);
    }
  }
  Future<Null> CreateNewThreadApi(BuildContext context, String category) async {
    // var headers = {
    //   'x-urva-key': x_fp_api_key,
    //   'Content-Type': 'application/json',
    // };
    ShowProgress(context);
    // var headers = {
    //   'x-urva-key': initmodel?.data?.orgInfo?.api_key.toString(),
    //   'x-urva-secretkey':  initmodel?.data?.token.toString(),
    //   'Content-Type': 'application/json'
    // };

    var uuid = Uuid();
    String uniqueId = uuid.v1();
    var bodys =   await sendmessage(category.trim().toString()  , uniqueId, true);

    var jsons = jsonEncode(bodys);
   print("bodyyds===>"+jsons.toString());

    var body =   await sendmessage(category.trim().toString()  , uniqueId , true);

   print("asssssssss===>"+Uri.parse(base_domain! + CommanURl+'new-thread').toString());

    var request = http.Request( 'POST', Uri.parse(base_domain! + CommanURl+'new-thread'));
    request.body = json.encode( body);
    request.headers.addAll({
      'x-urva-key': initmodel!.data!.orgInfo!.api_key.toString(),
      'x-urva-secretkey':  initmodel!.data!.token.toString(),
      'Content-Type': 'application/json'
    });
    http.StreamedResponse response = await request.send();

    print("json respoloa sd=create new thread==>"+response.statusCode.toString());

    if (response.statusCode == 200) {
    DismissProgress();
      String jsonResponse = "";
      try {
        var value = await response.stream.bytesToString();
        jsonResponse = value.toString();

        print("json respoloa sd=create new thread==>"+jsonResponse.toString());

      } catch (error) {
        print(error.toString());
      }
     //   setState(() {
          NotShowCategory = true;
    //    });
      final data = jsonDecode(jsonResponse);

      prefs.setThreadID(data['thread_id']);

      var headers = {
        'x-urva-key': initmodel!.data!.orgInfo!.api_key.toString(),
        'x-urva-secretkey':  initmodel!.data!.token.toString()
      };

      SelectedThreadID = data['thread_id'];

       getChats(false, headers);

   //   {"status":200,"message":"Chat thread created","thread_id":"chat_20220608064434007031754"}

      print("json respoloa sd=creaSSSSSSSSSte new threaddddd==>"+jsonResponse.toString());
    }
    else if( response.statusCode   == 206){
        DismissProgress();
      String jsonResponse = "";
      try {
        var value = await response.stream.bytesToString();
        jsonResponse = value.toString();
      } catch (error) {
        print(error.toString());
      }
      setState(() {
        NotShowCategory = true;
      });

      print("json respoloa sd=creaSSSSSSSSSte new thread==>"+jsonResponse.toString());
      setState(() {
        NotShowCategory = true;
      });
    }
    else {
      String jsonResponse = "";
      try {
        var value = await response.stream.bytesToString();
        jsonResponse = value.toString();
      } catch (error) {
        print(error.toString());
      }
    //  final data = jsonDecode(jsonResponse);
      print("error asd===>"+jsonResponse.toString());
   //   ToastShowLocation(data['message'].toString(), true);
      chatmodel.clear();
      DismissProgress();
      print("Error Response " + response.reasonPhrase!);
    }
  }
  Future<Null> LoginCall(BuildContext context) async {

    var headers = {
      'x-urva-key': x_fp_api_key!,
      'Content-Type': 'application/json',
    };
    print("herader sdssss===>"+headers.toString());
    var request = http.Request( 'POST', Uri.parse(base_domain! + CommanURl+'init'));
    print("init api uri===>"+ Uri.parse(base_domain! + CommanURl+'init').toString());

    request.body = json.encode(await InitApiBody());
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    print("init api sd===>"+response.statusCode.toString());

    if (response.statusCode == 200) {
      String jsonResponse = "";
      try {
        var value = await response.stream.bytesToString();
        jsonResponse = value.toString();
      } catch (error) {
        print(error.toString());
      }
        print("init api sd===>"+jsonResponse.toString());

      prefs.saveAllInfo(jsonResponse);

      final data = jsonDecode(jsonResponse);
      initmodel = InitcallModel.fromJson(data);

      if (socket == null || !socket!.connected) {
        print("socket for connection");
        initSocket(initmodel!.data?.token!, base_domain!);
      }else{
        print("socket for connection11111111111111");
      }

      ShowData(jsonResponse);
    } else {
      String jsonResponse = "";
      try {
        var value = await response.stream.bytesToString();
        jsonResponse = value.toString();
      } catch (error) {
        print(error.toString());
      }
      final data = jsonDecode(jsonResponse);
      ToastShowLocation(data['message'].toString(), true);
      chatmodel.clear();
       DismissProgress();
      print("Error Response " + response.reasonPhrase!);
    }
  }
  //   SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
  //   systemNavigationBarColor: pcolor,
  //   systemNavigationBarIconBrightness: Brightness.light,
  //   systemNavigationBarDividerColor: Colors.blue,
  // );
  void ShowData(String newData) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String newData = prefs.getString('all_info_data');

    if (newData != null && newData != "null") {
      final data = jsonDecode(newData);
      initmodel = InitcallModel.fromJson(data);

      mUsername = initmodel?.data?.userInfo?.username;
      uniqcode = initmodel?.data?.orgInfo?.unique_code;
      logourl = initmodel?.data?.orgInfo?.logo;
      FirstName = initmodel?.data?.userInfo?.firstName;
      LastName = "";
      PhoneNumber = initmodel?.data?.userInfo?.phone;
      companyName = initmodel?.data?.orgInfo?.companyName;
      String? pcolors = initmodel?.data?.orgInfo?.primaryDarkColor!;
      String? pcolorDarks = initmodel?.data?.orgInfo?.primaryColor!;


      pcolor =  Color(int.parse(pcolors!.substring(1, 7), radix: 16) + 0xFF000000);
      primaryDark =  Color(int.parse(pcolorDarks!.substring(1, 7), radix: 16) + 0xFF000000);
      chatabselected = pcolor;


      var headers = {
        'x-urva-key': initmodel!.data!.orgInfo!.api_key.toString(),
        'x-urva-secretkey':  initmodel!.data!.token.toString()
      };
      // var heads = {
      //   'x-urva-key': initmodel?.data?.orgInfo.api_key.toString(),
      //   'x-urva-secretkey':  initmodel?.data?.token.toString()
      // };
      print("json asdsssss=444444444==>"+headers.toString());

      prefs.saveThreads(headers);

      getChats(false ,  headers);

      if (!socket!.connected)
        socket?.on("sdk:receive:$uniqcode:$mUsername", (data) {
          print("recuever =>" + data.toString());
          _reciever(data);
        });

      socket?.on("sdk:thread-closed", (data) async {
        print("Closed thread socket  =>" + data.toString());
            NotShowCategory = false;
             await  prefs.cleansession();
             if (base_domain != "") {
                 LoginCall(context);
               }
      });


      Future.delayed(Duration.zero, () {
        ChangeNavigationBarColor(pcolor);
      });

    }


  }

  _reciever(dynamic data) {
    socketdata.add(data);
    print("facebook ddds==>" + data.toString());

    if (!mounted) return;
    setState(() {
      chatmodel.add(Chatmodel.fromJsonsocket(data, "$mUsername"));
    });
  }

  Future<Null> uploadfile(filePath, String? type, Uint8List? mUnit8file, String FileNameWeb) async {

    String? token = initmodel!.data!.token!;
    String? apiKey = initmodel!.data!.orgInfo!.api_key!;

    var headers = {
      'x-urva-key': apiKey,
      'x-urva-secretkey': token,
      'to': mUUidKey!,
      'org_code':OrgCode.toString()
    };

    print("header sds===>"+headers.toString());

    print("upload file sd===>"+ Uri.parse(base_domain! + CommanURl +'upload-file').toString());
    var request = http.MultipartRequest( 'POST', Uri.parse(base_domain! + CommanURl +'upload-file'));
    if (kIsWeb) {
      List mfile = FileNameWeb.split(".");
      request.files.add(await http.MultipartFile.fromBytes('file', mUnit8file!,
          contentType: new MediaType(type!, mfile[1].toString()),
          filename: FileNameWeb));
    } else {
      request.files.add(await  http.MultipartFile.fromPath('file', filePath,
          contentType: MediaType(type!, filePath.toString().split('.').last)));
    }

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    print("Upload image sd===>"+response.statusCode.toString());

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<Null> getChats(bool IsOldMessage ,var headers) async {

    print("assssss===>"+ Uri.parse(base_domain! +CommanURl+'messages?offset=' +offset.toString()+'&thread_id='+SelectedThreadID!).toString());
    var request = http.Request( 'GET',  Uri.parse(base_domain! +CommanURl+'messages?offset=' +offset.toString()+'&thread_id='+SelectedThreadID!));
    request.body = '''''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     DismissProgress();
      String jsonResponse = "";
      try {
        var value = await response.stream.bytesToString();
        jsonResponse = value.toString();
      } catch (error) {
        print(error.toString());
      }

       print("message data chat==>"+jsonResponse.toString());

      final data = jsonDecode(jsonResponse);
      // print("datat pagiunation sd===>" +
      //     data['data']['pagination']['offset'].toString() +
      //     "<===>" +
      //     data['data']['pagination']['count'].toString());
      // print("lengthhhsd===>"+data['data']['records'].length.toString());


      List<Chatmodel> mOldchatmodel = [];
      if (IsOldMessage) {
          if(data['data']['records'].length > 0 ){

              for (Map i in data['data']['records']) {
                mOldchatmodel.add(Chatmodel.fromJson(i, "$mUsername"));
              }

            mOldchatmodel.addAll(chatmodel);
            chatmodel.clear();
            chatmodel.addAll(mOldchatmodel);
          }
      }
      else {
        chatmodel =[];
        for (Map i in data['data']['records']) {
          chatmodel.add(Chatmodel.fromJson(i, "$mUsername"));
        }
      }

      print(":show sdtatu sd===>"+data['thread_data']['status'].toString());

      if(data['thread_data']['status']!=null
          && data['thread_data']['status'].toString().toLowerCase() =="progress" ||
            data['thread_data']['status'].toString().toLowerCase() =="open") {
        NotShowCategory = true;
      }
      else
        if( data['thread_data']['status']!=null &&
          data['thread_data']['status'].toString().toLowerCase() == "closed"){

          NotShowCategory = false;
         await prefs.cleansession();

        // prefs.getThreads().then((value)  {
        //   if(value != null && value!=""){
        //     NotShowCategory = true;
        //   }
        // });

        }

      offset = data['data']['pagination']['count'] + offset;
      ChangeNavigationBarColor(pcolor);
      if(mounted)
      setState(() {});
    }
    else {

   DismissProgress();
      print(response.reasonPhrase);

    }

  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: pcolor,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.blue,
    ));

    return Scaffold(
      appBar:  AppBar(
        brightness: Brightness.dark,

        title: Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: white,
                ),
                onPressed: () {
                  SystemNavigator.pop();
                }),
            Container(
                width: 50,
                height: 50,
                child: (logourl == "")
                    ? Container()
                    : Image.network(logourl!)),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName.toString(),
                  style: TextStyle(
                      color: white, fontSize: textSizeLargeMedium),
                ),
                Text(
                  FirstName.toString(),
                  style: TextStyle(
                      color: white.withOpacity(0.5),
                      fontSize: textSizeMedium),
                )
              ],
            )
          ],
        ),
        backgroundColor: pcolor,
      ),
      body: (NotShowCategory)
          ? Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: (chatmodel.isEmpty || chatmodel == null)
                          ? Container(
                              //   fit: FlexFit.loose,
                              child: Center(
                                  //   height: MediaQuery.of(context).size.height ,
                                  child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Image.asset(
                                      supportscreen,
                                      fit: BoxFit.fill,
                                      width: 250,
                                    ),
                                    text("Your chats will show up here",
                                        textColor: Color(0xFF455a64),
                                        isLongText: true,
                                        isCentered: true,
                                        fontSize: textSizeLargeMedium,
                                        fontFamily: fontBold),
                                  ]),
                            )))
                          // :Container()
                          : ListView.builder(
                              reverse: true,
                              controller: scrollController,

                              itemCount: chatmodel.length,
                              itemBuilder: (context, i) {
                                if (chatmodel.isNotEmpty) {
                                  Chatmodel? chatm = null;
                                  int newPostion = i;

                                  try {
                                    if (newPostion > 0) {
                                      newPostion -= 1;
                                    }

                                    chatm = chatmodel[
                                        chatmodel.length - 1 - newPostion >= 0
                                            ? chatmodel.length - 1 - newPostion
                                            : 0];
                                  } on Exception catch (_) {
                                  } catch (error) {}

                                  bool IsDurationSamewithPreviousDur = true;

                                  if (chatm?.duration ==
                                      chatmodel[chatmodel.length - 1 - i >= 0
                                              ? chatmodel.length - 1 - i
                                              : 0]
                                          .duration) {
                                    Chatmodel chatms = chatmodel[
                                        chatmodel.length - 1 - i >= 0
                                            ? chatmodel.length - 1 - i
                                            : 0];

                                    IsDurationSamewithPreviousDur = false;

                                    if (chatm?.isSender.toString() !=
                                        chatms.isSender.toString()) {
                                      IsDurationSamewithPreviousDur = true;
                                    }
                                  }

                                  if (i == 0) {
                                    IsDurationSamewithPreviousDur = true;
                                  }

                                  return buildChatMessages(
                                      chatmodel[chatmodel.length - 1 - i >= 0
                                          ? chatmodel.length - 1 - i
                                          : 0],
                                      chatmodel.length - 1 - i,
                                      IsDurationSamewithPreviousDur,
                                      chatmodel);
                                } else {
                                  return Container();
                                }
                              }),
                    ),
                    (kIsWeb)
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                IsBottomSheetOpen = !IsBottomSheetOpen;
                              });

                              // Future.delayed(const Duration(milliseconds: 1000),
                              //     () {
                              //   if (IsBottomSheetOpen) {
                              //     controller1.reverse();
                              //   }
                              // });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                  left: 8, right: 8, top: 8, bottom: 8),
                              color: pcolor.withOpacity(0.2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Continue the conversation",
                                    style:
                                        TextStyle(color: pcolor, fontSize: 16),
                                  ),
                                  (IsBottomSheetOpen)
                                      ? Icon(
                                          Icons.arrow_downward,
                                          color: pcolor,
                                        )
                                      : Icon(
                                          Icons.arrow_upward,
                                          color: pcolor,
                                        )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    inputBar()
                  ],
                ),
                (kIsWeb)
                    ? (IsBottomSheetOpen)
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                IsBottomSheetOpen = false;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              color: Colors.black26,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              IsBottomSheetOpen = false;
                                            });
                                          },
                                          child: SizedBox())),
                                  Container(
                                      height: 220,
                                      color: Colors.white,
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          var url =
                                                              "https://twitter.com/feetport";
                                                          var encoded =
                                                              Uri.encodeFull(
                                                                  url);
                                                          launchurl(encoded);

                                                          // var url = "https://tw.me/feetport";
                                                          // var encoded =
                                                          // Uri.encodeFull(url);
                                                          // launchurl(encoded);
                                                        },
                                                        child: Container(
                                                          height: 60,
                                                          width: 60,
                                                          //   margin: EdgeInsets.all(100.0),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFF1C9BE9),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Center(
                                                            child: Wrap(
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    child:
                                                                        CustomIcon(
                                                                      twitter_icon,
                                                                      color:
                                                                          white,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text("Twitter inbox"),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          // var url =
                                                          //     "https://m.me/harpreetsaini77";
                                                          // var encoded =
                                                          //     Uri.encodeFull(url);
                                                          // launchurl(encoded);
                                                        },
                                                        child: Container(
                                                          height: 60,
                                                          width: 60,
                                                          //   margin: EdgeInsets.all(100.0),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFF0177F7),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Center(
                                                            child: Wrap(
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    height: 28,
                                                                    width: 28,
                                                                    child:
                                                                        CustomIcon(
                                                                      messangerfb_icon,
                                                                      color:
                                                                          white,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                          " Facebook\nmessenger"),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          // const url =
                                                          //     "https://wa.me/+13603693690?text=";
                                                          // var encoded =
                                                          //     Uri.encodeFull(url);
                                                          // launchurl(encoded);
                                                        },
                                                        child: Container(
                                                          height: 60,
                                                          width: 60,
                                                          //   margin: EdgeInsets.all(100.0),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFF28A219),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Container(
                                                            height: 10,
                                                            width: 10,
                                                            child: Center(
                                                              child: Wrap(
                                                                children: [
                                                                  Center(
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          28,
                                                                      width: 28,
                                                                      child:
                                                                          CustomIcon(
                                                                        whatsappunselected_icon,
                                                                        color:
                                                                            white,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text("WhatsApp"),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          const url =
                                                              "https://t.me/converge_bot";
                                                          var encoded =
                                                              Uri.encodeFull(
                                                                  url);
                                                          launchurl(encoded);
                                                        },
                                                        child: Container(
                                                          height: 60,
                                                          width: 60,
                                                          //   margin: EdgeInsets.all(100.0),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFF2EA5D4),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Center(
                                                            child: Wrap(
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    height: 28,
                                                                    width: 28,
                                                                    child:
                                                                        CustomIcon(
                                                                      telegramunselected_icon,
                                                                      color:
                                                                          white,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text("Telegram"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          var url =
                                                              GoogleConvergeLink;
                                                          var encoded =
                                                              Uri.encodeFull(
                                                                  url);
                                                          launchurl(encoded);
                                                        },
                                                        child: Container(
                                                          height: 60,
                                                          width: 60,
                                                          //   margin: EdgeInsets.all(100.0),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFF48B564),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Icon(
                                                            Icons.location_on,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text("Google Maps"),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        width: 60,
                                                        //   margin: EdgeInsets.all(100.0),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0xFFD25858),
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: Icon(
                                                          Icons.call,
                                                          color: white,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text("Calls"),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        width: 60,
                                                        //   margin: EdgeInsets.all(100.0),
                                                        decoration:
                                                            BoxDecoration(
                                                                //   color: Colors.orange,
                                                                shape: BoxShape
                                                                    .circle),
                                                        //    child: Icon(Icons.whatshot),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      //   Text("Twitter inbox"),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        width: 60,
                                                        //   margin: EdgeInsets.all(100.0),
                                                        decoration:
                                                            BoxDecoration(
                                                                //      color: Colors.orange,
                                                                shape: BoxShape
                                                                    .circle),
                                                        //    child: Icon(Icons.whatshot),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      //  Text("Twitter inbox"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              margin: EdgeInsets.only(bottom: 100),
                            ),
                          )
                        : Container()
                    : Container()
              ],
            )
          : (initmodel != null && initmodel!.data!.categories!.isNotEmpty)
              ? Container(
                 margin: EdgeInsets.only(top: 8),
                height: MediaQuery.of(context).size.height-150,
                child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: initmodel!.data!.categories!.length,
                    itemBuilder: (context, index) {
                      return BuildCategoryView(initmodel!.data!.categories![index]);
                    }),
              )
              : Container(),
    );
  }
  SendMessagebySocket(bool FirstCategoryMessage) async{
    var uuid = Uuid();
    String uniqueId = uuid.v1();


    if(socket!.connected){
      print("send message===>" +  sendmessage(textController?.text.trim().toString()  , uniqueId , FirstCategoryMessage)
          .toString());

      socket!.emit('sdk:single-message', await sendmessage(textController!.text.trim().toString()  , uniqueId , FirstCategoryMessage));

    }else{
      ToastShow("socket not connect!");
    }

    sendmessageModel(uniqueId);
    IsTextFeildDesable = true;
  }
  Widget BuildCategoryView(Categories catagory) {
    return GestureDetector(
      onTap: () {
          selectedCatogary = catagory;

          IsTextFeildDesable =false;
    //      textController.text = catagory.code.toString();
        //  SendMessagebySocket(true);

          prefs.SetCategory(catagory.code.toString());


          // remove after that
          // setState(() {
          //   NotShowCategory = true;
          // });
          // remove after that

          CreateNewThreadApi(context ,catagory.code.toString());

            // setState(() {
            // });
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
          child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 45,
                margin: EdgeInsets.only(
                  right: 4,
                  left: 12,
                  top: 4,
                  bottom: 4
                ),
                height: 45,
                      decoration: BoxDecoration(
                        color: pcolor, // border color
                        shape: BoxShape.circle,
                      ),

                child: Icon(
                   Icons.description,
                  color: white,
                  size: 26,
                ),
              ),
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Column(  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    text(catagory.name,
                        fontSize: textSizeLargeMedium,
                        fontweght: FontWeight.bold),
                    RichText(
                      text: new TextSpan(
                        children: <TextSpan>[
                          new TextSpan(
                              text: catagory.description,
                              style: new TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    // (datamodel.msg.callData.conversationDuration != null &&
                    //         datamodel.msg.callData.conversationDuration != "" &&
                    //         datamodel.msg.callData.conversationDuration != "null")
                    //     ? Container(
                    //         child: Text(
                    //             datamodel.msg.callData.conversationDuration
                    //                     .toString() +
                    //                 " sec",
                    //             style: new TextStyle(color: Colors.grey)),
                    //       )
                    //     : Container(),
                ],
              ),
                  )),
            ],
          ),
          Divider(),
        ],
      )),
    );
  }

  Future<void> launchurl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      if (await canLaunch('http://' + url)) {
        await launch('http://' + url);
      }
    }
  }

  Widget text(String? text,
      {var fontSize = textSizeMedium,
      textColor = social_textColorPrimary,
      var fontFamily = fontRegular,
      var isCentered = false,
      var isOverflow = false,
      var maxLine = 1,
      var fontstyles = FontStyle.normal,
      var fontweght: FontWeight.w400,
      var latterSpacing = 0.25,
      var textAllCaps = false,
      var isunderline = false,
      var isLongText = false}) {
    // print("textvalue sd==>"+text);
    return Text(textAllCaps ? text!.toUpperCase() : text!,
        textAlign: isCentered ? TextAlign.center : TextAlign.start,
        maxLines: isLongText ? null : maxLine,
        overflow: isOverflow ? TextOverflow.ellipsis : TextOverflow.visible,
        style: TextStyle(
            fontWeight: fontweght,
            fontFamily: fontFamily,
            decoration:
                isunderline ? TextDecoration.underline : TextDecoration.none,
            fontSize: fontSize,
            color: textColor,
            fontStyle: fontstyles,
            height: 1.5,
            letterSpacing: latterSpacing));
  }

  dynamic sendlocation(lat, long) {
    return {
      'to': args['chat_id'].toString(),
      'message': {
        'sender': 'dipak',
        'col_id': args['col_id'].toString(),
        'text': 'location text',
        'persistentAction': ['geo:' + lat + ',' + long + '| '],
        'chat': {
          "id": args['chat_id'].toString(),
          "first_name": args['name'].toString(),
          "last_name": args['lname'].toString(),
        },
        'thread_id': args['thread_id'].toString(),
        'platform': platform,
        'received_at': getduration(true)
      }
    };
  }


  dynamic InitApiBody() async{
    if(kIsWeb){
   return   {
        "f_data": {
              "first_name": mFirstNameKey,
              "lst_name": mLastNameKey,
              "uuid": mUUidKey
              },
              "d_data": {
              "imei": "null",
              "sim_serial_no": "null",
              "mac_address": "80:58:f8:25:83:79",
              "device_model": "motorola-Moto G5 Plus (XT1686)",
              "os_ver": "10",
              "os": "Web",
              "app_ver": "2.6",
              "screen_w": "1080",
              "screen_h": "1882",

              "build": "194",
              "ip_address": "fe80::2c9f:b0ff:fece:3bf%dummy0",
              "timezone": "(GMT+5:30) Asia\\/Kolkata",
              "try_count": "7",
              "gcm_regid": ""
         }
       };
    }  else if(Platform.isIOS){
    return  {
        "f_data": {
            "first_name": mFirstNameKey,
            "lst_name": mLastNameKey,
            "uuid": mUUidKey
            },
            "d_data": {
            "imei": "null",
            "sim_serial_no": "null",
            "mac_address": "80:58:f8:25:83:79",
            "device_model": "motorola-Moto G5 Plus (XT1686)",
            "os_ver": "10",
            "app_ver": "2.6",
            "screen_w": "1080",
            "screen_h": "1882",
            "os": "Web",
            "build": "194",
            "ip_address": "fe80::2c9f:b0ff:fece:3bf%dummy0",
            "timezone": "(GMT+5:30) Asia\\/Kolkata",
            "try_count": "7",
            "gcm_regid": ""
            }
    };
    }
    else {
      Map deviceinfo;
      String os;
      if (Platform.isAndroid)
        os = "android";
      else if (Platform.isIOS)
        os = 'ios';
      else if (Platform.isMacOS)
        os = 'macos';
      else if (Platform.isWindows)
        os = 'windows';
      else
        os = 'web';

      deviceinfo = await PlatformService.deviceId;
      return {
        "f_data": {
          "first_name": mFirstNameKey,
          "lst_name": mLastNameKey,
          "uuid": mUUidKey
        },
        "d_data": {
          "imei": deviceinfo['device_id'].toString(),
          "sim_serial_no": deviceinfo['srno'].toString(),
          "mac_address": deviceinfo['srno'].toString(),
          "device_model": deviceinfo['model'].toString(),
          "os_ver": deviceinfo['os_version'].toString(),
          "app_ver": "1.0.0",
          "screen_w": MediaQuery
              .of(context)
              .size
              .width,
          "screen_h": MediaQuery
              .of(context)
              .size
              .height,
          "os": os,
          "build": "1",
          "ip_address": deviceinfo['host'].toString(),
          "timezone": "(GMT+5:30) Asia\\/Kolkata",
          "try_count": "7",
          "fcm_token": FCM_TOKEN
        }
      };
    }
  }
  dynamic deviceData() async{

    Map deviceinfo;
    String os;
    if(kIsWeb)
      os='web';
   else if (Platform.isAndroid)
      os = "android";
    else if (Platform.isIOS)
      os = 'ios';
    else if (Platform.isMacOS)
      os = 'macos';
    else if (Platform.isWindows)
      os = 'windows';
    else
      os = 'web';

    deviceinfo = await PlatformService.deviceId;

    DateTime dateTime = DateTime.now();
    // print("timezone ==>"+dateTime.timeZoneName.toString());
    // print("timezone offset===>"+dateTime.timeZoneOffset.toString());

    return {
      "imei": deviceinfo['device_id'].toString(),
      "sim_serial_no": deviceinfo['srno'].toString(),
      "mac_address": deviceinfo['srno'].toString(),
      "device_model": deviceinfo['model'].toString(),
      "os_ver": deviceinfo['os_version'].toString(),
      "app_ver": "1.0.0",
      "screen_w": MediaQuery.of(context) .size .width,
      "screen_h": MediaQuery .of(context).size .height,
      "os": os,
      "build": "1",
      "ip_address": deviceinfo['host'].toString(),
      // "timezone": "(GMT+5:30) Asia\\/Kolkata",
      "timezone": dateTime.timeZoneName.toString()+" "+dateTime.timeZoneOffset.toString(),

      "try_count": "7",
      "fcm_token": FCM_TOKEN
    };
  }

  dynamic sendmessage(String? message, String mUniqueId , bool FirstCategoryMessage) async {

    String? apiKey = initmodel?.data?.orgInfo!.api_key;
    if(FirstCategoryMessage){
      message =  selectedCatogary!.code;
      var devicedata= await  deviceData();


      return {
        "SmsMessageSid": mUniqueId,
        "NumMedia": "0",
        "ProfileName": "$FirstName $LastName",
        "SmsSid": mUniqueId,
        "WaId": PhoneNumber,
        "SmsStatus": "received",
        "Body": message.toString(),
        "NumSegments": "1",
        "MessageSid": mUniqueId,
        "From": PhoneNumber,
        "ApiVersion": "2021-07-01",
        "api_key":apiKey,
        "category":message.toString() ,
        "d_data": devicedata
      };
      // d_data
      // category

    }else{

      // print("send message 2222222222===>"+{
      //   "SmsMessageSid": mUniqueId,
      //   "NumMedia": "0",
      //   "ProfileName": "$FirstName $LastName",
      //   "SmsSid": mUniqueId,
      //   "WaId": PhoneNumber,
      //   "SmsStatus": "received",
      //   "Body": message.toString(),
      //   "NumSegments": "1",
      //   "MessageSid": mUniqueId,
      //   "From": PhoneNumber,
      //   "api_key":apiKey,
      //   "ApiVersion": "2021-07-01"
      // }.toString());

      return {
        "SmsMessageSid": mUniqueId,
        "NumMedia": "0",
        "ProfileName": "$FirstName $LastName",
        "SmsSid": mUniqueId,
        "WaId": PhoneNumber,
        "SmsStatus": "received",
        "Body": message.toString(),
        "NumSegments": "1",
        "MessageSid": mUniqueId,
        "From": PhoneNumber,
        "api_key":apiKey,
        "ApiVersion": "2021-07-01"
      };
    }

  }


  // dynamic sendmessage(String message, String mUniqueId) {
  //   return {
  //     "SmsMessageSid": mUniqueId,
  //     "NumMedia": "0",
  //     "ProfileName": "$FirstName $LastName",
  //     "SmsSid": mUniqueId,
  //     "WaId": PhoneNumber,
  //     "SmsStatus": "received",
  //     "Body": message.toString(),
  //     "NumSegments": "1",
  //     "MessageSid": mUniqueId,
  //     "From": PhoneNumber,
  //     "ApiVersion": "2021-07-01"
  //   };
  // }

  Widget buildChatMessages(Chatmodel model, int index, bool previousItemModel,
      List<Chatmodel> mNewChatModels) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final pcolordarken =
    //     TinyColor.fromString(toHex(model.pcolor).toString()).darken(10).color;
    final pcolordarken =  GetColorDarken(model.pcolor, 10);
    // final reciverColordarken =
    //     TinyColor.fromString(toHex(recievercolor).toString()).darken(10).color;
    final reciverColordarken =  GetColorDarken(recievercolor, 10);
    if (model.smsStatus == null) {
      model.smsStatus = "3";
    }
    return GestureDetector(
        child: (model.status == 'system' && model.System_type == 'ESCLATED')
            ? Center(
                child: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    //   width: width,
                    child: RichText(
                      text: new TextSpan(
                        children: <TextSpan>[
                          new TextSpan(
                              text: model.msg.toString(),
                              style: new TextStyle(color: Colors.white)),
                        ],
                      ),
                    )),
              )
            : (model.status == 'system' && model.System_type == 'NEW_THREAD')? Center(
          child: Card(
            elevation: 2,
            child: Container(
                padding: EdgeInsets.all(10),
                //     color: Colors.black54 ,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.all(Radius.circular(8.0)),
                  // border: Border.all(
                  //   color: Colors.black54,
                  // //  width: 1,
                  // )
                ),
                //   width: width,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 3),
                        child: Icon(
                          Icons.phone_android_outlined,
                          color: pcolor,
                        )),
                    SizedBox(
                      width: 6,
                    ),
                    RichText(
                      text: new TextSpan(
                        children: <TextSpan>[
                          new TextSpan(
                              text: model.msg,
                              style:
                              new TextStyle(color: pcolor)),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        )  :

        (model.msgtype != null && model.msgtype == "UPDATE_MAPPED_USER" ||
                    model.msgtype == "CASE_CLOSED" ||
                    model.msgtype == "TRANSFER_CHAT"  )
                ? Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    color: model.msgtype == "CASE_CLOSED"
                        ? pcolor
                        : pcolor.withOpacity(0.5),
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        model.msgtype == "CASE_CLOSED"
                            ? Icon(
                                Icons.close,
                                color: pcolor,
                              )
                            : model.msgtype == "TRANSFER_CHAT"
                                ? Icon(
                                    Icons.question_answer,
                                    color: pcolor,
                                  )
                                : Icon(
                                    Icons.contacts,
                                    color: pcolor,
                                  ),
                        SizedBox(
                          width: 4,
                        ),
                        Flexible(
                            fit: FlexFit.loose,
                            child:
                            RichText(
                              text: new TextSpan(
                                children: <TextSpan>[
                                  new TextSpan(
                                      text: model.msgtype == "CASE_CLOSED"
                                          ? "Thread resolved by" + " "
                                          : model.msgtype == "TRANSFER_CHAT"
                                              ? model.msg : 'Contact_mapping_changed_from',
                                      style: new TextStyle(
                                          color: model.msgtype == "CASE_CLOSED" ? Colors.white : pcolor)),
                                  new TextSpan(
                                      text: model.msgtype == "CASE_CLOSED" ? FirstName  : model.oldMap,
                                      style: new TextStyle(
                                          fontSize: 15.0,
                                          color: model.msgtype == "CASE_CLOSED"  ? Colors.white : pcolor,
                                          fontWeight: FontWeight.bold)),
                                  new TextSpan(
                                      text: model.msgtype == "CASE_CLOSED" ? " " + "at" + " "  : '',
                                      style: new TextStyle(
                                          color: model.msgtype == "CASE_CLOSED"
                                              ? Colors.white  : pcolor)),
                                  new TextSpan(
                                      text: model.msgtype == "CASE_CLOSED"
                                          ? model.duration
                                          : "",
                                      style: new TextStyle(
                                          fontSize: 15.0,
                                          color: model.msgtype == "CASE_CLOSED"  ? Colors.white  : pcolor,
                                          fontWeight: FontWeight.bold)),
                                  new TextSpan(   text: model.msgtype == "CASE_CLOSED"
                                          ? " " + "on" + " "
                                          : model.msgtype == "TRANSFER_CHAT" ? ""  : " " + "to" + " ",
                                      style: new TextStyle(
                                          color: model.msgtype == "CASE_CLOSED"
                                              ? Colors.white  : pcolor)
                                  ),
                                  new TextSpan(
                                      text: model.msgtype == "CASE_CLOSED"
                                          ? model.date : model.newMap,
                                      style: new TextStyle(
                                          fontSize: 15.0,   color: model.msgtype == "CASE_CLOSED"   ? Colors.white  : pcolor,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                        ),
                      ],
                    )  )
                : getmsgtype(model)
                        ? Container(
                            margin: EdgeInsets.only(bottom: 8),
                            width: width,
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              margin:
                                  EdgeInsets.only(top: 8, right: 12, left: 12),
                              decoration: BoxDecoration(
                                color: model.isSender ? pcolor : recievercolor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (model.msgtype ?.contains('OUTGOING_VIDEO_CALL') ?? false)
                                    Icon(
                                      Icons.videocam,
                                      size: 16,
                                      color: white,
                                    )
                                  else if (model.msgtype ?.contains('OUTGOING_CALL') ?? false)
                                    Icon(
                                      Icons.call,
                                      size: 16,
                                      color: !model.isSender
                                          ? unselectedtab
                                          : white,
                                    )
                                  else if (model.msgtype  ?.contains('OTP_SENT') ?? false)
                                    new Image.asset(
                                      incoming,
                                      width: 14,
                                      height: 14,
                                      fit: BoxFit.scaleDown,
                                      color: !model.isSender
                                          ? unselectedtab
                                          : white,
                                      alignment: Alignment.center,
                                    ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  text(
                                    model.msg ?? "",
                                    textColor:
                                        model.isSender ? white : unselectedtab,
                                    fontSize: textSizeMedium,
                                    isLongText: true,
                                    fontFamily: fontMedium,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(
                            child: Column(
                            children: [
                              lastmessagedate(index, mNewChatModels)
                                  ? Container()
                                  : Container(
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Divider(color: pcolor),
                                            flex: 1,
                                          ),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 15),
                                              alignment: Alignment.center,
                                              child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  margin: EdgeInsets.only(
                                                      top: 8,
                                                      right: 12,
                                                      left: 12),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        pcolor.withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: text(
                                                    model.date,
                                                    textColor: pcolor,
                                                    fontSize: textSizeMedium,
                                                    isLongText: true,
                                                    fontFamily: fontMedium,
                                                  ))),
                                          Flexible(
                                            child: Divider(
                                              color: pcolor,
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                              Container(
                                  color: model.isSelected
                                      ? themecolor
                                      : white,
                                  child: Container(
                                      width: width,
                                      margin: EdgeInsets.only(
                                          left: spacing_standard,
                                          right: spacing_standard),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: model.isSender
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                        mainAxisAlignment: model.isSender
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                model.isPrivate ?? false
                                                    ? model.isSender
                                                        ? Icon(
                                                            Icons.lock,
                                                            color:
                                                                recievercolor,
                                                          )
                                                        : Container()
                                                    //      (model.smsStatus == "undelivered")
                                                    : Container(),
                                                (platform == WhatsappPlatform &&
                                                        model.smsStatus ==
                                                            "undelivered")
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            top: 5),
                                                        child: Icon(
                                                          Icons.info_outline,
                                                          color: Colors.red,
                                                        ),
                                                      )
                                                    : Container(),
                                                Row(
                                                  children: [
                                                    platform == WhatsappPlatform
                                                        ? (model.syncStatus ==
                                                                "0")
                                                            ? Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10),
                                                                child: Icon(
                                                                  Icons
                                                                      .info_outline,
                                                                  size: 18,
                                                                  color: Colors
                                                                      .red[400],
                                                                ))
                                                            : Container()
                                                        : Container(),
                                                    Stack(
                                                        clipBehavior: Clip.none,
                                                        // overflow: Overflow.visible,
                                                        children: <Widget>[
                                                          Container(
                                                            //   padding: EdgeInsets.all(8),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 8,
                                                                    right: 12,
                                                                    left: 2),
                                                            decoration:
                                                                BoxDecoration(
                                                              //       pcolordarken
                                                              //   model.isPrivate
                                                              //   reciverColordarken
                                                              color: model.receiverUserHeader ??
                                                                      false
                                                                  ? model.isPrivate ??
                                                                          false
                                                                      ? reciverColordarken
                                                                      : recievercolor
                                                                  : model
                                                                          .isSender
                                                                      ? model.isPrivate ??
                                                                              false
                                                                          ? pcolordarken
                                                                          : pcolor
                                                                      : model.isPrivate ??
                                                                              false
                                                                          ? reciverColordarken
                                                                          : recievercolor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            constraints:
                                                                BoxConstraints(
                                                              minWidth:
                                                                  model.type ==
                                                                          'image'
                                                                      ? 100
                                                                      : 0,
                                                              minHeight:
                                                                  model.type ==
                                                                          'image'
                                                                      ? 200
                                                                      : 0,
                                                              maxWidth:
                                                                  model.type ==
                                                                          'audio'
                                                                      ? 300
                                                                      : 200,

                                                              //    maxHeight: 200
                                                            ),
                                                            child:
                                                                model.receiverUserHeader ??
                                                                        false
                                                                    ? Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 8,
                                                                                right: 8,
                                                                                top: 4),
                                                                            child:
                                                                                text(
                                                                              model.receiverUser ?? "",
                                                                        //      textColor: TinyColor.fromString(toHex(model.receiverUserColorSecondry).toString()).darken(20).color,
                                                                              // textColor: model.receiverUserColorSecondry,
                                                                                  textColor:  GetColorDarken(model.receiverUserColorSecondry, 20),
                                                                              fontSize: textSizeMedium,
                                                                              isLongText: true,
                                                                              fontweght: FontWeight.bold,
                                                                              fontFamily: fontMedium,
                                                                            ),
                                                                          ),
                                                                          // SizedBox(
                                                                          //   height: 3,
                                                                          // ),

                                                                          Container(
                                                                            padding: EdgeInsets.only(
                                                                                left: 8,
                                                                                right: 8,
                                                                                bottom: 8),
                                                                            child:
                                                                                BuildMediaWithColorBackground(model),
                                                                          )
                                                                        ],
                                                                      )
                                                                    : Container(
                                                                        padding:
                                                                            EdgeInsets.all(8),
                                                                        child: buildmedia(
                                                                            model),
                                                                      ),
                                                          ),
                                                          !model.isSender
                                                              ? Positioned(
                                                                  left: -3,
                                                                  top: 8,
                                                                  child: lastMessageLeft(
                                                                          index,
                                                                          mNewChatModels)
                                                                      ? Container()
                                                                      : ClipPath(
                                                                          clipper:
                                                                              TriangleClipper(),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                15,
                                                                            width:
                                                                                22,
                                                                            color: model.receiverUserHeader ?? false
                                                                                ?
                                                                                //receiverColor
                                                                                model.isPrivate ?? false
                                                                                    ? reciverColordarken
                                                                                    : recievercolor
                                                                                //    ?  model.receiverUserColorSecondry.withOpacity(0.3)
                                                                                : model.isPrivate ?? false
                                                                                    ? reciverColordarken
                                                                                    : recievercolor,
                                                                          ),
                                                                        ),
                                                                )
                                                              : Positioned(
                                                                  right: 1,
                                                                  top: 8,
                                                                  child: lastMessageright(
                                                                          index,
                                                                          mNewChatModels)
                                                                      ? Container()
                                                                      : ClipPath(
                                                                          clipper:
                                                                              TriangleClipper(),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                15,
                                                                            width:
                                                                                22,
                                                                            color: model.receiverUserHeader ?? false
                                                                                ?
                                                                                //   model.receiverUserColorSecondry.withOpacity(0.4)

                                                                                recievercolor
                                                                                : model.isPrivate ?? false
                                                                                    ? pcolordarken
                                                                                    : pcolor,
                                                                          ),
                                                                        ),
                                                                )
                                                        ]),
                                                  ],
                                                ),
                                                model.isPrivate ?? false
                                                    ? model.isSender
                                                        ? Container()
                                                        : Icon(
                                                            Icons.lock,
                                                            color:
                                                                recievercolor,
                                                          )
                                                    : Container(),
                                              ]),
                                          (previousItemModel)
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      left: (  model.isSender)?12:0, right: 12),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      (platform == WhatsappPlatform)
                                                          ? (model.syncStatus ==  "0")
                                                              ? Icon(
                                                                  Icons
                                                                      .timelapse,
                                                                  size: 12,
                                                                  color: Colors
                                                                          .grey[
                                                                      500],
                                                                )
                                                              : model.isSender
                                                                  //
                                                                  ? Icon(
                                                                      (model.smsStatus ==
                                                                              "undelivered")
                                                                          ? Icons
                                                                              .info_outline
                                                                          : (model.smsStatus == "delivered")
                                                                              ? Icons.done_all
                                                                              : (model.smsStatus == "read")
                                                                                  ? Icons.done_all
                                                                                  : (model.smsStatus == "sent")
                                                                                      ? Icons.check
                                                                                      : Icons.check,
                                                                      size: 12,
                                                                      color: (model.smsStatus ==
                                                                              "read")
                                                                          ? Colors
                                                                              .blueAccent
                                                                          : unselectedtab,
                                                                    )
                                                                  : Container()
                                                          : Container(),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      text(model.duration,
                                                          textColor:
                                                              unselectedtab,
                                                          fontSize:
                                                              textSizeSmall,
                                                          isOverflow: true,
                                                          isLongText: true),
                                                    ],
                                                  ))
                                              : Container()
                                        ],
                                      )))
                            ],
                          )));
  }

  buildmedia(Chatmodel model) {
    if (model.type == 'Message') {
      if (model.msg?.startsWith('@') ?? false) {
        try {
          final regExp = new RegExp(r"@\w+");
          return RichText(
            text: TextSpan(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: model.isSender ? white : unselectedtab,
                  fontSize: textSizeMedium),
              text: regExp.stringMatch(model.msg ?? ""),
              children: <TextSpan>[
                TextSpan(
                    text: model.msg?.replaceFirst(
                        regExp.stringMatch(model.msg ?? "") ?? '', ''),
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: model.isSender ? white : unselectedtab,
                        fontSize: textSizeMedium)),
              ],
            ),
          );
        } catch (error) {
          return text(
            model.msg ?? "",
            textColor: model.isSender ? white : unselectedtab,
            fontSize: textSizeMedium,
            isLongText: true,
            fontFamily: fontMedium,
          );
        }
      } else if (model.isurl ?? false) {
        return InkWell(
          child: text(
            model.msg ?? "",
            textColor: model.isSender ? white : Colors.blue,
            isunderline: true,
            fontSize: textSizeMedium,
            isLongText: true,
            fontFamily: fontMedium,
          ),
          onTap: () {
            //   launchurl(model.msg);
          },
        );
      } else if (model.msg?.contains(".") ?? false) {
        return InkWell(
          child: text(
            model.msg ?? "",
            textColor: model.isSender ? white : Colors.blue,
            //     isunderline: true,
            fontSize: textSizeMedium,
            isLongText: true,
            fontFamily: fontMedium,
          ),
          onTap: () {
            //  launchurl(model.msg);
          },
        );
      } else
        return text(
          model.msg ?? "",
          textColor: model.isSender ? white : unselectedtab,
          fontSize: textSizeMedium,
          isLongText: true,
          fontFamily: fontMedium,
        );
    } else if (model.type == 'image') {
      if (kIsWeb) {
        if (model.unit8list != null) {
          return GestureDetector(
            child: Image.memory(
              model.unit8list!,
              fit: BoxFit.cover,
            ),
            onTap: () {
              callNext(
                  Preview(
                      url: model.file,
                      local: model.local,
                      pcolor: pcolor,
                      uint8list: model.unit8list,
                      name: model.name,
                      date: model.date,
                      time: model.duration),
                  context);
            },
          );
        } else {
          return GestureDetector(
            child: Image.network(
              model.file,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
            onTap: () {
              callNext(
                  Preview(
                      url: model.file,
                      local: model.local,
                      pcolor: pcolor,
                      name: model.name,
                      date: model.date,
                      time: model.duration),
                  context);
            },
          );
        }
      } else {
        if (model.local!) {
          return GestureDetector(
            child: Image.file(
              File(model.file),
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new Preview(
                          url: model.file,
                          local: model.local,
                          pcolor: pcolor,
                          name: model.name,
                          date: model.date,
                          time: model.duration)));
            },
          );
        } else if (model.file.toString().split('.').last == "gif") {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new Preview(
                          url: model.file,
                          local: model.local,
                          pcolor: pcolor,
                          name: model.name,
                          date: model.date,
                          time: model.duration)));
            },
            child: Container(
              color: Colors.white,
              child: CachedNetworkImage(
                imageUrl: model.file,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          );
        } else {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new Preview(
                          url: model.file,
                          local: model.local,
                          pcolor: pcolor,
                          name: model.name,
                          date: model.date,
                          time: model.duration)));
            },
            child: Container(
              color: Colors.white,
              child: CachedNetworkImage(
                imageUrl: model.file,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          );
        }
      }
    } else if (model.type == 'video') {
      return Container(
     //   onTap: () {},
      );
    } else if (model.type == 'audio') {
      //  print("audio call");
      //   return PlayerWidget(url: model.file);

      return Container();
    } else if (model.type == 'location') {
      return Stack(clipBehavior: Clip.none, children: <Widget>[
        Container()

        // GestureDetector(
        //   onTap: () {
        //     openMapsSheet(context, model.lat, model.long);
        //   },
        // )
        //
      ]);
    } else if (model.type == 'doc' || model.type == 'pdf') {
      return GestureDetector(
        child: Container(
            constraints: BoxConstraints(minWidth: 200),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              model.fname!.contains('pdf')
                  ? CustomIcon(
                      pdficon,
                      size: 30,
                      color: white,
                    )
                  : Icon(
                      Icons.insert_drive_file,
                      size: 30,
                      color: model.isSender ? white : unselectedtab,
                    ),
              new Text(
                model.fname!,
                style: new TextStyle(
                  fontSize: 14.0,
                  color: model.isSender ? white : unselectedtab,
                ),
              ),
            ])),
        onTap: () {
          // model.local
          //     ? OpenFile.open(model.file)
          //     : loadFile(model.file, model.fname)
          //     .then((value) => {OpenFile.open(value)});
        },
      );
    }
  }

  BuildMediaWithColorBackground(Chatmodel model) {
    //print("model type sd===>" + model.type.toString());
    if (model.type == 'Message') {
      if (model.msg?.startsWith('@') ?? false) {
        try {
          final regExp = new RegExp(r"@\w+");
          return RichText(
            text: TextSpan(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: model.isSender ? white : unselectedtab,
                  fontSize: textSizeMedium),
              text: regExp.stringMatch(model.msg ?? ""),
              children: <TextSpan>[
                TextSpan(
                    text: model.msg?.replaceFirst(
                        regExp.stringMatch(model.msg ?? "") ?? "", ''),
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: model.isSender ? white : unselectedtab,
                        fontSize: textSizeMedium)),
              ],
            ),
          );
        } catch (error) {
          return text(
            model.msg ?? "",
            textColor: model.isSender ? white : unselectedtab,
            fontSize: textSizeMedium,
            isLongText: true,
            fontFamily: fontMedium,
          );
        }
      }
      else if (model.isurl ?? false) {
        return InkWell(
          child: text(
            model.msg ?? "",
            textColor: model.isSender ? white : Colors.blue,
            isunderline: true,
            fontSize: textSizeMedium,
            isLongText: true,
            fontFamily: fontMedium,
          ),
          onTap: () {
            //     launchurl(model.msg);
          },
        );
      }
      else
        return Container(
          //   height: 40,
          decoration: BoxDecoration(
              color: model.receiverUserHeader ?? false
                  ? Colors.transparent
                  //model.receiverUserColorSecondry.withOpacity(0.3)
                  : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: IntrinsicHeight(
            child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start ,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  // constraints: BoxConstraints(minHeight: 36),
                  decoration: BoxDecoration(
                      color: model.receiverUserHeader ?? false
                          ? recievercolor
                          //model.receiverUserColorSecondry

                          : model.isSender
                              ? white
                              : unselectedtab,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5))),
                  //    width: 6,
                  //    height: 38,
                  // color:model.receiverUserHeader
                  //   ? model.receiverUserColorSecondry :model.isSender ? white : unselectedtab,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Align(
                      alignment: Alignment.centerLeft,

                      // text(
                      //   model.msg,
                      //   textColor: model.isSender ? white : unselectedtab,
                      //   fontSize: textSizeMedium,
                      //   isLongText: true,
                      //   fontFamily: fontMedium,
                      // );

                      child: RichText(
                        text: new TextSpan(
                          style: TextStyle(
                              fontSize: textSizeMedium,
                              fontFamily: fontMedium,
                              color: model.isSender ? white : unselectedtab),
                          text: model.msg,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
    } else if (model.type == 'image') {
      if (model.local ?? false)
        return GestureDetector(
          child: Image.file(
            File(model.file),
            fit: BoxFit.cover,
          ),
          onTap: () {
            callNext(
                Preview(
                    url: model.file,
                    local: model.local,
                    pcolor: pcolor,
                    name: args['name'],
                    date: model.date,
                    time: model.duration),
                context);
          },
        );
      else {
        return GestureDetector(
            onTap: () {
              callNext(
                  Preview(
                      url: model.file,
                      local: model.local,
                      pcolor: pcolor,
                      name: args['name'],
                      date: model.date,
                      time: model.duration),
                  context);
            },
            child: CachedNetworkImage(
              imageUrl: model.file,
              fit: BoxFit.cover,
              // placeholder: (context, url) =>  Container(
              //   child: CircularProgressIndicator(),
              //   height: 50.0,
              //   width: 50.0,
              // ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ));
      }
    } else if (model.type == 'video') {
      return GestureDetector(
          onTap: () {
            // callNext(
            //     new VideoWidget(
            //       url: model.local ? File(model.file).path : model.file,
            //       play: true,
            //       local: model.local,
            //       pcolor: pcolor,
            //     ),
            //     context);
          },
          child: Stack(
            children: [
              Container(
                height: 200,
                width: 200,
                // child: new VideoWidget(
                //     play: false,
                //     url: model.local ? File(model.file).path : model.file,
                //     local: model.local,
                //     pcolor: pcolor),
              ),
            ],
          ));
    } else if (model.type == 'audio') {
      //  print("audio call");
      //  return PlayerWidget(url: model.file);
      return Container();
    } else if (model.type == 'location') {
      //  return Container();

      return Stack(clipBehavior: Clip.none, children: <Widget>[
        kIsWeb
            ? new Image(
                image: new AssetImage(maps),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              )
            : Container(
                height: 200,
                width: 200,
                // child: Googlemap(
                //   fullmap: false,
                //   coordinates: LatLng(
                //       converttodouble(model.lat), converttodouble(model.long)),
                // ),
              ),
      ]);
    } else if (model.type == 'doc' || model.type == 'pdf') return Container();
  }

  getmsgtype(Chatmodel model) {
    return (model.msgtype == 'OTP_SENT' || model.msgtype == 'SYSTEM');
  }

  String toHex(Color color) {
    return "#${color.red.toRadixString(16).padLeft(2, "0")}"
        "${color.green.toRadixString(16).padLeft(2, "0")}"
        "${color.blue.toRadixString(16).padLeft(2, "0")}";
  }

  //for checking previous message allignment
  bool lastmessagedate(int index, List<Chatmodel> mNewChatModel) {
    Chatmodel data, previous;
    if (index <= 0) return false;

    data = mNewChatModel[index];
    previous = mNewChatModel[index - 1];

    if ((data.date != null && data.date == previous.date)) {
      return true;
    } else {
      return false;
    }
  }

  //for checking previous message allignment
  bool lastMessageright(int index, List<Chatmodel> mNewChatModel) {
    Chatmodel previous;
    if (index <= 0) return false;

    previous = mNewChatModel[index - 1];

    if ((index > 0 &&
        previous.isSender &&
        lastmessagedate(index, mNewChatModel))) {
      return true;
    } else {
      return false;
    }
  }

  bool lastMessageLeft(int index, List<Chatmodel> mNewChatModel) {
    Chatmodel previous;
    if (index <= 0) return false;

    previous = mNewChatModel[index - 1];

    if ((index > 0 &&
        !previous.isSender &&
        lastmessagedate(index, mNewChatModel))) {
      return true;
    } else {
      return false;
    }
  }

  String GetCurrentUtcDate() {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now().toUtc());
  }

  String getduration(bool timestamp) {
    return timestamp
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : DateFormat('hh:mm a').format(DateTime.now());
  }

  inputBar() {
    final roundedContainer = ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        height: 42,
        padding: EdgeInsets.only(left: 8),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: textController,
                onChanged: (text) {

                  if(textController!.text.trim()==""){
                    return;
                  }

                  if (text.length > 1) {
                    IsTextFeildDesable = false;
                  } else {
                    IsTextFeildDesable = true;
                  }
                  setState(() {

                  });

                },
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.go,
                style: TextStyle(color: Colors.black),
                onSubmitted: (String value) {

                  if ( textController!.text.trim().length > 1) {
                    SendMessagebySocket(false);
                  }

                  },
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                  hintText: "Type a message",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      color: recievercolor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
                color: recievercolor,
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Row(
                    children: <Widget>[
                      attachment(),
                      Expanded(
                        child: roundedContainer,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (textController!.text.trim().length < 1) {
                            //   ToastShow("Please enter message!");
                            return;
                          }
                          SendMessagebySocket(false);
                        },
                        child: CircleAvatar(
                          backgroundColor: (IsTextFeildDesable)
                              ? chatabselected.withOpacity(0.5)
                              : chatabselected,
                          child: Icon(
                            Icons.send,
                            color: white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  // SendMessagebySocket() {
  //   var uuid = Uuid();
  //   String uniqueId = uuid.v1();
  //   socket?.emit('sdk:single-message',
  //       sendmessage(textController?.text.trim().toString() ?? "", uniqueId));
  //   print("send message sd===>" +
  //       sendmessage(textController?.text.trim().toString() ?? "", uniqueId)
  //           .toString());
  //   sendmessageModel(uniqueId);
  //   IsTextFeildDesable = true;
  // }

  String getTimeStemp(String threadid) {
    int min = 100000; //min and max values act as your 6 digit range
    int max = 999999;
    //   var randomizer = new Random();
//    var rNum = min + randomizer.nextInt(max - min);

    return DateTime.now().millisecondsSinceEpoch.toString().toString();
  }

  sendmessageModel(String uniquId) {
    RegExp email = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
        caseSensitive: false);

    RegExp urlExp = RegExp(
        r"(http|ftp|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?");

    String mIsUniq = getTimeStemp("Thread");
    setState(() {
      Chatmodel models = Chatmodel();
      models.msg = textController?.text.trim();
      models.duration = getduration(false);
      models.type = "Message";
      models.msgtype = 'DEFAULT';
      models.date = 'Today';
      models.isSender = true;
      models.isPrivate = isPrivate;

      if (email.hasMatch(textController?.text?.trim() ?? "")) {
        models.isurl = true;
      } else if (urlExp.hasMatch(textController?.text.trim() ?? '')) {
        models.isurl = true;
      } else {
        models.isurl = false;
      }

      //  models.isurl = Uri.parse(textController.text.trim()).isAbsolute;

      models.receiverUser = "$mUsername";
      models.receiverUserHeader = false;
      models.receiverUserColorPrimary = false;
      models.receiverUserColorSecondry = false;

      models.sender = "$mUsername";
      models.col_id = "cpl".toString();
      models.thread_id = "threads ";
      models.fname = "harpre";
      models.user_ids = usernames.toString();

      models.received_at = GetCurrentUtcDate();
      models.smsStatus = "send";
      models.sendbyUSer = "true";

      models.DateFromServer = getduration(true);

      models.id = mIsUniq;
      models.s_msg_uniq_id = mIsUniq;

      chatmodel.add(models);
    });
    textController?.text = "";
  }

  void _openFileExplorer() async {
    try {
      _path = null;
      //
      // FilePickerResult? result = await FilePicker.platform.pickFiles(
      //     allowMultiple: false,
      //     type: _pickingType,
      //     allowedExtensions: (_extension?.isNotEmpty ?? false)
      //         ? _extension?.replaceAll(' ', '')?.split(',')
      //         : null);

      // if (result != null) {
      //   if (kIsWeb) {
      //     PlatformFile file = result.files.first;
      //     Uint8List? unit8list = result.files.single.bytes;
      //
      //     if (!mounted) return;
      //     setState(() {
      //       _startUpload("", media, file.name, false, unit8list);
      //     });
      //
      //     //     RefreshChatThreadList(context);
      //
      //   } else {
      //     List<File> files = result.paths.map((path) => File(path!)).toList();
      //
      //     if (!mounted) return;
      //     setState(() {
      //       for (File file in files) {
      //         String fileName = file.path.split('/').last;
      //
      //         // String fileName = file.path.split('/').last;
      //         _startUpload(file.path, media, fileName, false, null);
      //
      //         //    RefreshChatThreadList(context);
      //
      //       }
      //     });
      //   }
   //   }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  void _startUpload(filepath, media, filename, isLast, Uint8List? munit) async {
    Chatmodel model = Chatmodel();
    model.file = filepath;
    model.duration = getduration(false);
    model.type = media;
    model.local = true;
    model.date = 'Today';
    model.msgtype = 'DEFAULT';
    model.isPrivate = false;
    model.name = initmodel!.data!.userInfo!.firstName;
    model.fname = filename.toString();
    model.isSender = true;
    model.receiverUser = "";
    model.receiverUserHeader = false;
    model.receiverUserColorPrimary = HeaderPrimaryColor;
    model.receiverUserColorSecondry = HeaderSecondryColor;
    model.sender = "";
    model.col_id = "";
    model.thread_id = "";
    model.fname = "";
    model.user_ids = "";
    model.id = getduration(true);
    model.received_at = GetCurrentUtcDate();
    model.smsStatus = "send";
    model.sendbyUSer = "true";

    String dateForSubString = getduration(true);
    if (dateForSubString.length > 10) {
      String newdate = dateForSubString.substring(0, 10);
      model.DateFromServer = newdate;
    } else {
      model.DateFromServer = getduration(true);
    }

    model.unit8list = munit;
    model.isUploading = "upload";

    if (isLast) {
      chatmodel.insert(chatmodel.length, model);
    } else
      chatmodel.add(model);
    uploadfile(filepath, media, munit, filename);
  }

  //to show options for varios media to be selected
  Widget attachment() {
    if (!IsFileManagerPermissionEnable) {
      return Container();
    }

    return GestureDetector(
      onTap: () {
        media = "image";
        _extension = null;
      //  _pickingType = FileType.image;
        _openFileExplorer();
      },
      child: Container(
          margin: EdgeInsets.only(left: 8, right: 8),
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.attach_file,
            color: pcolor,
          )),
    );
  }
}
