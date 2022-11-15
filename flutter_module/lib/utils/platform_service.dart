import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class PlatformService {
  static var deviceInfo = DeviceInfoPlugin();


  static Future<Map> get deviceId async {
    if(kIsWeb){
      return {
        'device_id': "80:58:f8:25:83:79",
        'os_version': "10",
        'model': "chrome",
        'appversion': "2.3",
        'host': "80:58:f8:25:83:79",
        'srno': "80:58:f8:25:83:79"
      };

    }
    else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      return {
        'device_id': iosInfo.identifierForVendor,
        'os_version': iosInfo.systemVersion,
        'model': iosInfo.model,
        'appversion': iosInfo.systemVersion,
        'host': iosInfo.utsname.nodename,
        'srno': iosInfo.utsname.sysname
      };
    } else if (Platform.isAndroid) {
     var androidInfo = await deviceInfo.androidInfo;
      return {
        'device_id': androidInfo.androidId,
        'os_version': androidInfo.version.baseOS,
        'model': androidInfo.model,
        'appversion': androidInfo.version.sdkInt,
        'host': androidInfo.host,
        'srno': androidInfo.version.incremental
      };
    }
    return {
      'device_id': "",
      'os_version': "",
      'model': "",
      'appversion': "",
      'host': "",
      'srno': ""
    };
  }
}
