import 'package:flutter/material.dart';
import 'package:metashare_flutter/pages/message_page.dart';
import 'package:metashare_flutter/pages/contact_page.dart';
import 'package:metashare_flutter/pages/focus_page.dart';
import 'package:metashare_flutter/pages/movement_page.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with AutomaticKeepAliveClientMixin {
  int currentIndex = 0;
  List pagelist = [MessagePage(), ContactPage(), FocusPage(), MovementPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.pagelist[this.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text('消息'),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              title: Text('联系人'),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.looks),
              title: Text('看点'),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('动态'),
              backgroundColor: Colors.white),
        ],
        currentIndex: this.currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            this.currentIndex = index;
          });
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
