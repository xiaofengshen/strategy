import 'package:flutter/material.dart';
import 'package:strategys/page/splash_page.dart';

var routers = {
  "/splashPage": (context) => SplashPage(),
  // "/registerPage": (context,{arguments}) => RegisterPage(arguments: arguments,),
  // "/Register2Page": (context,{arguments}) => Register2Page(arguments: arguments,),
  // "/tbsListPage": (context,{arguments}) => TbsListPage(),
  // "/tbsListPage2": (context,{arguments}) => TbsListPage2(),
  // "/drawerPage": (context,{arguments}) => DrawerPage(),
  // "/buttonPage": (context,{arguments}) => ButtonPage(),
  // "/dialogPage": (context,{arguments}) => DialogPage(),
  // "/imagePage": (context,{arguments}) => ImagePage(),
};

Function onGenerateRoute = (settings) {
// 统一处理
  final String name = settings.name;
  print(name);
  final Function pageContentBuilder = routers[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));

      return route;
    } else {
      final Route route = MaterialPageRoute(
          builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};