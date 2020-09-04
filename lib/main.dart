import 'package:flutter/material.dart';
import 'views/tabs.dart';
import 'package:provider/provider.dart';
import 'providers/provider_manager.dart';
import 'routers/routers.dart';

void main() {
  //注册监听
  runApp(MultiProvider(
    providers: [
      //改变主题监听注册
      ChangeNotifierProvider(create: (_) => ThemeProvider(Colors.blue)),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Tabs(),
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).theme,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
