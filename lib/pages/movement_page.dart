import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fsearch/fsearch.dart';
import 'package:ftoast/ftoast.dart';
import 'package:fsuper/fsuper.dart';
import 'package:metashare_flutter/utils/screen.dart';

class MovementPage extends StatefulWidget {
  MovementPage({Key key}) : super(key: key);

  @override
  _MovementPageState createState() => _MovementPageState();
}

class _MovementPageState extends State<MovementPage> {
//搜索控件
  Widget buildSearch() {
    return Column(
      children: [
        FSearch(
          height: 44,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.only(left: 20, right: 20),
          backgroundColor: Color(0xFFF3F3F3),
          hints: ['搜索', ''],
          hintPrefix: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          corner: FSearchCorner.all(22),
        )
      ],
    );
  }

  //分割線
  Widget bulidDivider(double height) {
    return Container(
      height: height,
      color: Color(0xFFF3F3F3),
    );
  }

//好友动态组件
  Widget buildZoneWidget() {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular((8)), // 圆角度
      ),
      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FSuper(
            text: '好友动态',
            style: TextStyle(color: Colors.black, fontSize: 18),
            textAlign: TextAlign.left,
            margin: EdgeInsets.only(left: 45),
            child1: Icon(
              Icons.star,
              color: Colors.yellow,
              size: 40,
            ),
            child1Alignment: Alignment.centerLeft,
            child1Margin: EdgeInsets.only(right: 45),
          ),
          FSuper(
            redPoint: true,
            redPointSize: 10,
            redPointOffset: Offset(-25, 15),
            margin: EdgeInsets.only(right: 10),
            child1: Container(
              width: 40,
              height: 40,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg'),
              ),
            ),
            child2: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            child1Margin: EdgeInsets.only(right: 40),
          )
        ],
      ),
    );
  }

  //列表Item
  Widget buildWrapItem(IconData data, String title) {
    return Container(
      height: (Screen.width(context) - 32) / 3,
      width: (Screen.width(context) - 32) / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            data,
            size: 30,
            //随机色
            color: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),
                Random().nextInt(256), 1),
          ),
          SizedBox(
            height: 10,
          ),
          Text(title)
        ],
      ),
    );
  }

  //列表组件
  Widget buildWarpWidget() {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 1,
        runSpacing: 1,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          buildWrapItem(Icons.near_me, '附近'),
          buildWrapItem(Icons.directions_run, '邂逅'),
          buildWrapItem(Icons.games, '游戏'),
          buildWrapItem(Icons.ac_unit, '扩列'),
          buildWrapItem(Icons.movie_filter, '波动动漫'),
          buildWrapItem(Icons.audiotrack, '语音房'),
          buildWrapItem(Icons.book, '阅读'),
          buildWrapItem(Icons.shopping_cart, '购物'),
          buildWrapItem(Icons.video_library, '微视'),
          buildWrapItem(Icons.home, '兴趣部落'),
          buildWrapItem(Icons.music_note, '全民K歌'),
          buildWrapItem(Icons.music_video, '音乐'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('动态'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.sync, size: 30),
                onPressed: () {
                  FToast.toast(context, msg: '动态列表');
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [buildSearch(), buildZoneWidget(), buildWarpWidget()],
          ),
        ));
  }
}
