import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResultData {

  bool isSuccess; //是否成功
  int code; // 状态码
  String msg; //信息
  var data;

  ResultData(this.isSuccess, this.code, this.msg,{this.data}); //数据

}

class CodeData {
  static final net_err_code = 4001; //没有网络
  static final net_time_out = 4002; //网络超时
  static final unkonw_err=4003 ;  //未知错误
  static final response_err=4004 ;  //响应错误
  static final cancel_err=4005 ;  //取消访问
  static final SUCCESS=200 ;  //成功
  static final EventBus eventBus = new EventBus();




  static errorHandleFunction(int code,String  message,bool noTip) {
    if(noTip) {
      return message;
    }
    eventBus.fire( HttpErrorEvent(code, message));
    return message;
  }
}

class EventBus {

  fire(HttpErrorEvent httpErrorEvent){
    Fluttertoast.showToast(
        msg: httpErrorEvent.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}

class HttpErrorEvent {
  int code;
  String message;

  HttpErrorEvent(this.code, this.message);


}
