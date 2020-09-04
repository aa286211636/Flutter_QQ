import 'package:flutter/material.dart';
import 'package:metashare_flutter/views/custom_expansiontile.dart';
import 'package:metashare_flutter/utils/request.dart';
import 'package:metashare_flutter/models/message.dart';
import 'package:metashare_flutter/utils/screen.dart';

class ContactTabView extends StatefulWidget {
  final int selectIndex;
  ContactTabView({Key key, this.selectIndex}) : super(key: key);

  @override
  _ContactTabViewState createState() => _ContactTabViewState();
}

class _ContactTabViewState extends State<ContactTabView> {
  List<String> groups;
  bool expanded;
  List<Message> dataArr = [];

  @override
  void initState() {
    super.initState();
    groups = ['同學', '公司同事', 'Family', 'Hommie'];
    expanded = false;
    getData();
  }

  //获取数据
  Future<void> getData() async {
    //本地读取模拟数据
    var responseJson = await Request.get(action: "message");
    List<Message> modules = [];
    responseJson.forEach((data) {
      modules.add(Message.fromJson(data));
    });
    setState(() {
      this.dataArr = modules;
    });
  }

  //创建expandItem
  Widget buildExpanItem(Message message) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(message.headurl),
            radius: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    message.username,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )),
              Container(
                margin: EdgeInsets.only(left: 15),
                width: Screen.width(context) * 0.7,
                child: Text(message.content, overflow: TextOverflow.ellipsis),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> buildList() {
    List<Widget> list = [];
    this.dataArr.forEach((item) {
      list.add(buildExpanItem(item));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.selectIndex) {
      default:
        return ListView.separated(
          /* SingleChildScrollView 和 ListView 都有滚动属性physics 他们默认是都是可以滚动的,
             ListView 嵌套 ListView.builder 需要后者shrinkWrap = true,不然报错；
             禁用 ListView 的滚动physics 保留 SingleChildScrollView 的滚动
             Listview 执行 physics 属性 new NeverScrollableScrollPhysics(),*/
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: groups.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 1,
              color: Color(0xFFF3F3F3),
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return CustomExpansionTile(
              dividerDisplayTime: DividerDisplayTime.always,
              title: Text(groups[index]),
              //是否展開
              initiallyExpanded: expanded,
              //左側widget
              leading: Icon(
                expanded ? Icons.arrow_drop_down : Icons.arrow_right,
                size: 30,
              ),
              //右側widget
              trailing: Text(this.dataArr.length.toString() + '/' + this.dataArr.length.toString()),
              children: buildList(),
              onExpansionChanged: (isExpand) {
                setState(() {
                  this.expanded = isExpand;
                });
              },
            );
          },
        );
    }
  }
}
