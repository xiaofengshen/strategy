import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:strategys/config/config.dart';
import 'package:strategys/utils/screen_adapter.dart';

class VersionDialog extends StatefulWidget {
  String url;
  String version;


  VersionDialog(this.url, this.version);

  @override
  _VersionDialogState createState() => _VersionDialogState(url,version);
}

class _VersionDialogState extends State<VersionDialog> {

  String url;
  String version;


  double _percent=0.0;
  String _percentContent="";


  _VersionDialogState(this.url, this.version);
@override
  Future<void> initState()  {
    // TODO: implement initState
    super.initState();
    initDown();



  }

  @override
  Widget build(BuildContext context) {

  return  Dialog(
      child:    Container(
        alignment: Alignment.center,
        color: Colors.white,
        width: ScreenAdapter.width(200),
        height: ScreenAdapter.height(200),
        child: LinearPercentIndicator(
          width: ScreenAdapter.width(200),
          animation: false,
          lineHeight: 20.0,
          animationDuration: 2500,
          percent:_percent,
          center: Text(_percentContent),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: Colors.green,
        ),
      ),
    );
  }

  void initDown() async{

    Directory storageDir = await getExternalStorageDirectory();
    String storagePath = storageDir.path;
    File file = new File(
        '$storagePath/${Config.APP_NAME}v$version.apk');
    if (!file.existsSync()) {
      file.createSync();
    }

    Dio dio = Dio();
    dio.download(
      url,
      file.path,
      onReceiveProgress: (count, total) {
        print('下载 ${count / total}');
        setState(() {
          _percent = count / total;
          _percentContent =
              (count * 100 / total).toInt().toString() + "%";
          print('改变 $_percentContent');
          if(count >= total){
            //安装
            InstallPlugin.installApk(file.path, 'com.startegys.strategys')
                .then((result) {
              print('install apk $result');
            });

          }



        });
      },
    );
  }
}
