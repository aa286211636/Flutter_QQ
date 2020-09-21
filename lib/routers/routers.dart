import 'package:flutter/material.dart';
import 'package:metashare_flutter/views/tabs.dart';
import 'package:metashare_flutter/pages/theme_page.dart';

//配置路由
final routers = {
  '/tab': (context, {arguments}) => Tabs(),
  '/theme_page': (context, {arguments}) => ThemePage(),

};

var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routers[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
