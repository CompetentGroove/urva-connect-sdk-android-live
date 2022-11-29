// @JS()
// library callable_function;
// import 'package:js/js.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_library/Support.dart';
import 'package:flutter_library/utils/Constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_library/utils/routes.dart';
import 'package:provider/provider.dart';

//
// @JS('functionName')
// external set _functionName(void Function(String test) f);
// @JS()
// external void functionName();

List urlparametersList = [];
void _someDartFunction(String datas) async {
  urlparametersList = [];
  String initialLink = datas;
  urlparametersList = initialLink.split(",");
  GetDataFromLink();
}

void GetDataFromLink() async{

  for (int i = 0; i < urlparametersList.length; i++) {
    print('=sdsasasds==>' + urlparametersList[i]);
    if (i == 0) {
      base_domain = urlparametersList[i];
    } else if (i == 1) {
      mFirstNameKey = urlparametersList[i];
    } else if (i == 2) {
      mLastNameKey = urlparametersList[i];
    } else if (i == 3) {
      mUUidKey = urlparametersList[i];
    } else if (i == 4) {
      x_fp_api_key = urlparametersList[i];
    }else if (i == 5) {
      OrgCode = urlparametersList[i].toString();
    }

    // mUUidKey = call.arguments['uuid'];
    // OrgCode = call.arguments['org'];

  }
    runApp(HomeCheck());
}

final controller = StreamController<String>();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // _functionName = allowInterop(_someDartFunction);

  if (!kIsWeb) {
    final model = await CounterModel();
    runApp(  ChangeNotifierProvider.value(value: model, child: HomeCheck()),);
  }

}

// String dartFunc() => 'Hello World';

class HomeCheck extends StatefulWidget {
  HomeCheck({
    Key? key,
  }) : super(key: key);

  @override
  AllChatsState createState() => AllChatsState();
}

class AllChatsState extends State<HomeCheck> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    //   LoginCall(context,"sdf");

    return MaterialApp(
      //  title: 'Flutter Demo',
      routes:  Routes.routes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Support());

    //  Support()
  }
}

class CounterModel extends ChangeNotifier {
  CounterModel() {
    _channel.setMethodCallHandler(_handleMessage);
    _channel.invokeMethod<void>('requestKey');
  }

  final _channel = MethodChannel('competent.groove.convergesdk/sendinfo');
  String? GetJson = "";
  String? get count => GetJson;

  void increment() {
    _channel.invokeMethod<void>('methodCannelKey');
  }

  Future<dynamic> _handleMessage(MethodCall call) async {
    if (call.method.toString() == "reportKey") {
      if (Platform.isIOS) {
        if (call.arguments['url'] != "") {
          mUUidKey = call.arguments['uuid'];
          OrgCode = call.arguments['org'];
          base_domain = call.arguments['url'];
          FCM_TOKEN = call.arguments['fcm_token'];
          x_fp_api_key =call.arguments['x-urva-key'];
          mFirstNameKey =call.arguments['first_name'];
          mLastNameKey =call.arguments['last_name'];

          controller.sink.add("Data!");
        }
      } else {
        GetJson = call.arguments as String?;
        dynamic datas = jsonDecode(GetJson!);
        if (datas['url'] != "") {
          mUUidKey = datas['uuid'];
          OrgCode = datas['org'];
          base_domain = datas['url'];
          FCM_TOKEN = datas['fcm_token'];
          x_fp_api_key =datas['x-urva-key'];
          mFirstNameKey =datas['first_name'];
          mLastNameKey =datas['last_name'];
          controller.sink.add("Data!");
        }
      }
    }
  }
}
