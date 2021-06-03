typedef OnSuccess<T> = void Function(T data);
typedef OnError = void Function(int code, String msg);

class HttpCallback<T> {
  OnSuccess<T> onSuccess;
  OnError onError;

  HttpCallback({this.onSuccess, this.onError});
}
