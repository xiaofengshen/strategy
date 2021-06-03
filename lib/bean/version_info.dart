/// info : {"androidIsForce":0,"androidUrl":"asd","androidVersion":"2.1.2","createTime":"2021-05-19 20:28:31","h5Url":"asd","id":12,"iosIsForce":0,"iosUrl":"asd","iosVersion":"2.1.3","isDelete":0,"manifestUrl":"asd","updateContent":"asd","updateTime":"2021-05-20 11:46:16","url":"sada"}



class VersionInfo {
  Info info;

  VersionInfo({
      this.info});

  VersionInfo.fromJson(dynamic json) {
    info = json["info"] != null ? Info.fromJson(json["info"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (info != null) {
      map["info"] = info.toJson();
    }
    return map;
  }

}


/// androidIsForce : 0
/// androidUrl : "asd"
/// androidVersion : "2.1.2"
/// createTime : "2021-05-19 20:28:31"
/// h5Url : "asd"
/// id : 12
/// iosIsForce : 0
/// iosUrl : "asd"
/// iosVersion : "2.1.3"
/// isDelete : 0
/// manifestUrl : "asd"
/// updateContent : "asd"
/// updateTime : "2021-05-20 11:46:16"
/// url : "sada"
///这个标注是告诉生成器，这个类是需要生成Model类的

class Info {
  int androidIsForce;
  String androidUrl;
  String androidVersion;
  String createTime;
  String h5Url;
  int id;
  int iosIsForce;
  String iosUrl;
  String iosVersion;
  int isDelete;
  String manifestUrl;
  String updateContent;
  String updateTime;
  String url;

  Info({
      this.androidIsForce, 
      this.androidUrl, 
      this.androidVersion, 
      this.createTime, 
      this.h5Url, 
      this.id, 
      this.iosIsForce, 
      this.iosUrl, 
      this.iosVersion, 
      this.isDelete, 
      this.manifestUrl, 
      this.updateContent, 
      this.updateTime, 
      this.url});

  Info.fromJson(dynamic json) {
    androidIsForce = json["androidIsForce"];
    androidUrl = json["androidUrl"];
    androidVersion = json["androidVersion"];
    createTime = json["createTime"];
    h5Url = json["h5Url"];
    id = json["id"];
    iosIsForce = json["iosIsForce"];
    iosUrl = json["iosUrl"];
    iosVersion = json["iosVersion"];
    isDelete = json["isDelete"];
    manifestUrl = json["manifestUrl"];
    updateContent = json["updateContent"];
    updateTime = json["updateTime"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["androidIsForce"] = androidIsForce;
    map["androidUrl"] = androidUrl;
    map["androidVersion"] = androidVersion;
    map["createTime"] = createTime;
    map["h5Url"] = h5Url;
    map["id"] = id;
    map["iosIsForce"] = iosIsForce;
    map["iosUrl"] = iosUrl;
    map["iosVersion"] = iosVersion;
    map["isDelete"] = isDelete;
    map["manifestUrl"] = manifestUrl;
    map["updateContent"] = updateContent;
    map["updateTime"] = updateTime;
    map["url"] = url;
    return map;
  }

}