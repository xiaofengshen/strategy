import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  static double width(double width) {
    return ScreenUtil().setWidth(width);
  }

  static double height(double height) {
    return ScreenUtil().setHeight(height);
  }

  static double screenHeight() {
    return ScreenUtil().screenHeight;
  }

  static double screenWidth() {
    return ScreenUtil().screenWidth;
  }
  static double setSp(double fontSize) {
    return ScreenUtil().setSp(fontSize);
  }
}
