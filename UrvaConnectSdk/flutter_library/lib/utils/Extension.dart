import 'dart:async';
import 'dart:math';
import 'package:flutter_library/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'Colors.dart';
import 'Dimens.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
// import 'package:package_info_plus/package_info_plus.dart';

// Future<Uint8List> _loadFileBytes(String url) async {
//   Uint8List bytes;
//   try {
//     bytes = await readBytes(url);
//   } on ClientException {
//     rethrow;
//   }
//   return bytes;
// }


ChangeNavigationBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      //  statusBarColor: Colors.transparent,
      // To make Status bar icons color white in Android devices.
      statusBarIconBrightness: Brightness.dark,
      // statusBarBrightness is used to set Status bar icon color in iOS.
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: color,
      // systemNavigationBarDividerColor: Colors.red,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}


String GetCurrentUtcDate() {
  return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now().toUtc());
}

String getTimeStemp(String? threadid) {
  int min = 100000; //min and max values act as your 6 digit range
  int max = 999999;
  var randomizer = new Random();
  var rNum = min + randomizer.nextInt(max - min);

  return DateTime
      .now()
      .millisecondsSinceEpoch
      .toString()+"_"+rNum.toString();
}
//for sentence cases
extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
}



//global method to check if string is date(yy-mm-dd) only
bool checkOnlydate(String text) {
  return RegExp(
          r'^([1-9][0-9]{3})\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$')
      .hasMatch(text);
}

//global method to check if string is numeric only
bool checkOnlyDigits(String text) {
  return RegExp(r'\d').hasMatch(text);
}
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }


}



//global method to check if string is email
bool checkemail(String text) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(text);
}
void ToastShowLocation(String msg , bool longs) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: longs ? Toast.LENGTH_LONG:Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black26,
      textColor: Colors.white,
      fontSize: 16.0);
}

DismissProgress() async{

  if (IsProgressShowing) {
    try {
      // if (kIsWeb) {
      // if (_progressDialogs != null) {
      //   _progressDialogs.dismiss();
      //   _progressDialogs = null;
      // }
      if (progressDialog != null) {
        // progressDialog!.setLoadingWidget(null);
        progressDialog!.dismiss();
        progressDialog = null;
      }

      // progressDialog

      // }else if(_dialog!= null){
      //   _dialog!.hide();
      //   _dialog= null;
      // }else {
      //     _dialog!.hide();
      //   _dialog= null;
      // }
    } on Exception catch (exception) {
      LOG("eceptyion dissmiss progress===>" + exception.toString());
    } catch (error) {
      LOG("error dissmiss progress===>" + error.toString());
    }

    IsProgressShowing = false;
  }
}

bool IsProgressShowing = false;
// StylishDialog? _progressDialogs = null;
// SimpleFontelicoProgressDialog? _dialog;
CustomProgressDialog? progressDialog = null;

ShowProgress(BuildContext context) async{
  // if (kIsWeb) {
  if (!IsProgressShowing) {

    IsProgressShowing = true;
    progressDialog = CustomProgressDialog(
      context,
      blur: 2,
      onDismiss: () {
      },
    );

    progressDialog!.show();

  }
  // } else {
  // SimpleFontelicoProgressDialogType type =  SimpleFontelicoProgressDialogType.bullets;
  // if (!IsProgressShowing) {
  //   IsProgressShowing = true;
  //   _dialog = SimpleFontelicoProgressDialog(
  //       context: context, barrierDimisable: true,);
  //   _dialog!.show(
  //       message: AppLocalizations.of(context)!.translate("Please_wait"),
  //       backgroundColor: Colors.transparent,
  //       hideText: true,
  //
  //       // width: 100,
  //       // height: 100,
  //       type: type);
  // }
  // }
}



callNext(var className, var context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => className),
  );
}


SnackBarShowGlobal(BuildContext context, String message){
  final snackBar = SnackBar(
    content:  Text(message),
    // action: SnackBarAction(
    //   label: 'Undo',
    //   onPressed: () {
    //     // Some code to undo the change.
    //   },
    // ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);

}


Widget text(String text,
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
  return Text(textAllCaps ? text.toUpperCase() : text,
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
void ToastShow(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black26,
      textColor: Colors.white,
      fontSize: 16.0);
}

//global method to initialize socket
initSocket(String? token ,String? url) async {
  print("socketv url===>"+url!);
  print("socketv token===>"+token!);

  socket = io(url, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
    'query': {'token': token},
    },
  );
  // print("INIT SOCKETSDDDDDD");
  socket?.on('connect', (_) {
    print('sock_connect  connect');
  });
  socket?.onConnecting((data) {
    print('sock_connect  onConnecting '+data.toString());
  });
  socket?.onReconnectAttempt((data) {
   // ToastShow("reconnect  "+data.toString());
    print('sock_connect  onReconnectAttempt'+data.toString());
  });
  socket?.onError((data) {
    print('sock_connect  onError   '+data.toString());
   // ToastShow("error ==>"+data.toString());
  });
socket?.onConnectTimeout((data) {
  print('sock_connect  onConnectTimeout'+data.toString());
});
  socket?.onReconnectError((data) {
    print('sock_connect  onReconnectError'+data.toString());
  });
  socket?.onReconnect((data) {
    print('sock_connect  onReconnect'+data.toString());
  });
 socket?.on("disconnect", (_) => print('Disconnected'));

 socket?.connect();

}

// Future<int> uploadfileCommon(
//     String uniqueCode,
//     filePath,
//     String type,
//     Uint8List mUnit8file,
//     Chatmodel model,
//     String FileNameWeb,
//     String  token) async {
//
//   var  request = new MultipartRequest("POST",
//         Uri.parse(base_domain +'/api/connect/sdk/1.0/upload-file'));
//
//   request.headers.addAll({
//     'x-urva-key': x_fp_api_key,
//     'x-urva-secretkey': token.toString()
//   });
//
//   print("upload file sd===>"+{
//     'x-urva-key': x_fp_api_key,
//     'x-urva-secretkey': token.toString()
//   }.toString()
//   );
//   if (kIsWeb) {
//
//     List mfile = FileNameWeb.split(".");
//     request.files.add(await http.MultipartFile.fromBytes('file', mUnit8file,
//         contentType: new MediaType(type, mfile[1].toString()),
//         filename: FileNameWeb));
//   } else {
//     request.files.add(await MultipartFile.fromPath('file', filePath,
//         contentType: MediaType(type, filePath.toString().split('.').last)));
//   }
//
//   print("uploding");
//
//   var response = await request.send();
//
//   print("upload Response=>"+response.statusCode.toString()
//   );
//   if (response.statusCode == 200) {
//     //  _progressDialog.dismiss();
//
//     String jsonResponse;
//     try {
//       var value = await response.stream.bytesToString();
//       //    print(value.toString());
//       jsonResponse = value.toString();
//     } catch (error) {
//       print(error.toString());
//     }
//     print("uplopad file s d===>"+jsonResponse.toString());
//
//     final data = jsonDecode(jsonResponse);
//
//     // if (kIsWeb) {
//     //   model.file = data['message']['full_msg']['MediaUrl0'];
//     //   model.local = false;
//     //   model.unit8list = null;
//     // }
//
//     model.isUploading = "";
//
//    // mCallback(model);
//
//   } else {
//     // DismissProgress();
//     model.isUploading = "";
//
//     ToastShow("Not uplaoders===>" + response.statusCode.toString());
//     print("respon xser code zsd===>" + response.statusCode.toString());
//
//  //   mCallback(model);
//   }
//
//   // request.send().then((response) async {
//   //
//   //   // final respStr = await response.stream.bytesToString();
//   //
//   //
//   // });
// }
//

PackageInfoGet() async {
  // packageInfo = await PackageInfo.fromPlatform();
  // String appName = packageInfo.appName;
  // String packageName = packageInfo.packageName;
  // String version = packageInfo.version;
  // print("package info ==>" +
  //     appName.toString() +
  //     "<===>" +
  //     packageName.toString() +
  //     "<===>" +
  //     version.toString());
}


// OnSocket(String uniqcode,mUsername){
//   if (!socket.connected)
//     socket?.on("sdk:receive:$uniqcode:$mUsername", (data) {
//       print("recuever =>" + data.toString());
//       _reciever(data);
//     });
// }


