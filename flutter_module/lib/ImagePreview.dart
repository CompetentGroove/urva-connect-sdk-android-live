import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/utils/Dimens.dart';
import 'package:flutter_module/utils/Extension.dart';

class Preview extends StatelessWidget {
  static String tag = '/Preview';
  Preview({this.url, this.local,this.pcolor,this.name,this.time,this.date,this.uint8list});
  var url;
  double? height, width;
  var pcolor;
  var args;
  String? date,time,name;
  bool? loaded = false, local;
  Uint8List? uint8list;
String emoji='😄';

  @override
  Widget build(BuildContext context) {

    args = ModalRoute.of(context)!.settings.arguments;

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    String mTitle="";
    if(time==""){
      mTitle ="$emoji by $name on $date";
    }else{
      mTitle ="$emoji by $name on $date at $time";
    }


    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: text(mTitle, textColor: Colors.white, fontSize: textSizeLargeMedium),
        backgroundColor: pcolor,
      ),
        body: SafeArea(
            child:Center(
        child: (kIsWeb) ?
            (uint8list!=null) ? Image.memory(
              uint8list!,
             ) : Image.network(
              url,
            ) :
            local! ?  Image.file(
                    File(url),
                    fit: BoxFit.cover,
                  )
                :
            CachedNetworkImage(
              imageUrl: url,
              errorWidget: (context, url, error) => Icon(Icons.error),
            )

            )

        )

    );
  }
}
