import 'package:strategys/bean/version_info.dart';
import 'package:strategys/net/api.dart';
import 'package:strategys/net/http_callback.dart';
import 'package:strategys/net/http_utils.dart';

class SplashModel{

  checkUpdate(HttpCallback<VersionInfo> callback) async {
    var resultData =
    await HttpUtils.getInstance().post(Api.versionUrl, data: {});
    if (resultData.isSuccess) {
      var versionInfo = VersionInfo.fromJson(resultData.data);
      callback.onSuccess(versionInfo );
    } else {
      callback.onError(resultData.code, resultData.msg);
    }
  }




}