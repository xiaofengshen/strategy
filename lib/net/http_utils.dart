
import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:strategys/net/result_data.dart';




class HttpUtils {
  static Dio dio;

  static var _instance;

  HttpUtils._internal() {
    dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      var headers = options.headers;

      headers["token"] = "hahhhahhah";

      // print("path +++++++++++${    options.uri}");

      print("\n================== 请求数据 ==========================");
      //    print("url = ${options.uri.toString()}");
      print("headers = ${options.headers}");
      print("params = ${options.data}");
      print("path = ${options.path}");

      return handler.next(options);
    }, onResponse: (response, handler) {
      print("\n================== 响应数据 ==========================");
      print("code = ${response.statusCode}");
      print("data = ${response.data}");
      print("\n");
      return handler.next(response);
    }, onError: (dioError, handler) {
      print("\n================== 错误响应数据 ======================");
      print("type = ${dioError.type}");
      print("message = ${dioError.message}");
      print("stackTrace = ${dioError.stackTrace}");
      print("\n");

      return handler.next(dioError);
    }));
  }

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory HttpUtils.getInstance() => _getInstance();

  /// 获取单例内部方法
  static _getInstance() {
    // 只能有一个实例
    if (_instance == null) {
      _instance = HttpUtils._internal();
    }
    return _instance;
  }

  Future<ResultData> get(String path, {data, bool noTip = false}) {
    return _request(path, Options(method: "GET"), data: data, noTip: noTip);
  }

  Future<ResultData> post(String path, {data, bool noTip = false}) {
    return _request(path, Options(method: "POST"), data: data, noTip: noTip);
  }

  Future<ResultData> _request(String path, Options options,
      {data, bool noTip}) async {
    Connectivity _connectivity = Connectivity();
    var checkConnectivity = await _connectivity.checkConnectivity();

    if (checkConnectivity == ConnectivityResult.none) {
      //无网络
      return ResultData(false, CodeData.net_err_code,
          CodeData.errorHandleFunction(CodeData.net_err_code, "请检查网络", noTip));
    }
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      // config the http client
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return 'PROXY 192.168.0.177:8888';
      };
      // you can also create a new HttpClient to dio
      // return HttpClient();
    };
    //超时时间
    dio.options.connectTimeout = 15000;
    Response response;
    try {
      response = await dio.request(path, data: data, options: options);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.connectTimeout) {
        errorResponse.statusCode = CodeData.net_time_out;
      } else if (e.type == DioErrorType.sendTimeout) {
        errorResponse.statusCode = CodeData.net_time_out;
      } else if (e.type == DioErrorType.response) {
        errorResponse.statusCode = CodeData.response_err;
      } else if (e.type == DioErrorType.cancel) {
        errorResponse.statusCode = CodeData.cancel_err;
      } else if (e.type == DioErrorType.other) {
        errorResponse.statusCode = CodeData.unkonw_err;
      }
      return ResultData(
          false,
          errorResponse.statusCode,
          CodeData.errorHandleFunction(
              errorResponse.statusCode, e.message, noTip));
    }

    try {
      if (options.contentType != null && options.contentType == "text") {
        return ResultData(true, CodeData.SUCCESS, "成功", data: response.data);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        //成功

        var responseData = response.data;
        var data2 = responseData["data"];
        var result = responseData["result"];

        var msg = responseData["msg"];
        String code = responseData["code"];
        if (code == "200") {
          return ResultData(true, int.parse(code), msg, data: data2);
        } else {
          return ResultData(
              false, int.parse(code), CodeData.errorHandleFunction(int.parse(code), msg, noTip));
        }
      }
    } catch (e) {
      print(e.toString() + path);

      return ResultData(false, response.statusCode, e.toString());
    }
  }
}
