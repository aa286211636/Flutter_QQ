import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fsuper/fsuper.dart';
import 'package:provider/provider.dart';
import 'package:metashare_flutter/providers/provider_manager.dart';

class ThemePage extends StatefulWidget {
  ThemePage({Key key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  //颜色集合
  var themColor = [
    Colors.purple,
    Colors.blue,
    Colors.red,
    Colors.black,
    Colors.yellow,
    Colors.green,
    Colors.brown
  ];
 
 //
  List<Widget> buildThemeItem(context) {
    List<Widget> newList = List();
    newList.add(Text('主题'));
    for (var item in themColor) {
      newList.add(
        FSuper(
          height: 30,
          width: 30,
          backgroundColor: item,
          onClick: () {
            Provider.of<ThemeProvider>(context, listen: false)
                .changeTheme(item);
          },
        ),
      );
    }
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('主题'),
        ),
        body: Container(
          width: double.infinity,
          height: 64,
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: buildThemeItem(context)),
        ));
  }
}
