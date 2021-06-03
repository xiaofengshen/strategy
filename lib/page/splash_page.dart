import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:strategys/bean/version_info.dart';
import 'package:strategys/config/config.dart';
import 'package:strategys/net/http_callback.dart';
import 'package:strategys/page/splash_model.dart';
import 'package:strategys/utils/screen_adapter.dart';
import 'package:strategys/utils/y_colors.dart';
import 'package:strategys/view/version_dialog.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashModel splashModel;

  @override
  void initState() {
    super.initState();
    //检测权限
    // 检测更新
    //现在更新安装

    splashModel = SplashModel();

    _listenForPermissionStatus();
  }

  _listenForPermissionStatus() async {
    var request = await Permission.storage.request();
    if (request.isGranted) {
      //同意
      print('权限同意');
      splashModel.checkUpdate(HttpCallback(
        onError: (code, msg) {},
        onSuccess: (data) async {
          //   var info = data.info;

          PackageInfo packageInfo = await PackageInfo.fromPlatform();

          String appName = packageInfo.appName;
          String packageName = packageInfo.packageName;
          String version = packageInfo.version;
          String buildNumber = packageInfo.buildNumber;
          print('appName=$appName');
          print('packageName=$packageName');
          print('version=$version');
          print('buildNumber=$buildNumber');

          var androidVersion = data.info.androidVersion.replaceAll(".", "");
          var locationVersion = version.replaceAll(".", "");
          if (int.parse(androidVersion) > int.parse(locationVersion)) {
            //弹窗更新
            if (Platform.isAndroid) {
              showUpdataDialog(context, data.info.updateContent,
                  data.info.androidIsForce, data.info.androidUrl, version);
            }
          }
        },
      ));
    } else {
      //拒绝
      print('权限拒绝');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: YColors.color_161F2F,
      child: Stack(
        children: [
          Align(
            child: Image.asset(
              "assets/images/splash_logo.png",
              height: ScreenAdapter.height(128),
              width: ScreenAdapter.width(289),
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: ScreenAdapter.height(137)),
              child: Align(
                child: Image.asset(
                  "assets/images/splash_center.png",
                  height: ScreenAdapter.height(39),
                  width: ScreenAdapter.width(340),
                ),
                alignment: Alignment.bottomCenter,
              )),
        ],
      ),
    );
  }

  double _percent = 0;
  String _percentContent = "";

  ///更新弹窗
  void showUpdataDialog(context, String updateContent, int androidIsForce,
      String androidUrl, String version) {
    showDialog(
      barrierDismissible: androidIsForce != 1,
      useSafeArea: androidIsForce != 1,
      useRootNavigator: androidIsForce != 1,
      context: context,
      builder: (context) {

        return  StatefulBuilder(builder:
            (BuildContext context, void Function(void Function()) setState) {

              return AlertDialog(
                title: Text("版本更新 更新进度$_percentContent"),
                content: Text(updateContent),
                actions: [
                  ElevatedButton(
                      onPressed: ()  {
                        //

                          Navigator.pop(context);
                        showPercentIndicator(context,androidUrl,version);


                      },
                      child: Text("更新"))
                ],
              );
            });
      },
    );
  }

  /// 显示下载进度
  void showPercentIndicator(BuildContext context, String androidUrl, String version) async{


    showDialog(
      context: context,
      builder: (context) {
      return VersionDialog(androidUrl,version);
      },
    );




  }
}
