import 'package:flutter/material.dart';
import 'package:fsearch/fsearch.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:metashare_flutter/providers/provider_manager.dart';
import 'package:metashare_flutter/views/contact_tabview.dart';
import 'package:ftoast/ftoast.dart';

class ContactPage extends StatefulWidget {
  ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _titles; //tab标签
  int _currentIndex; //選中下標

  @override
  void initState() {
    super.initState();
    _titles = ['好友', '分组', '群聊', '设备', '通讯录', '订阅号'];
    _tabController =
        TabController(length: _titles.length, vsync: ScrollableState());
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

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

  //可能认识的人
  Widget buildKnowItem(String headUrl, String name) {
    return Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(headUrl),
                  radius: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text(
                          name,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text('3位共同好友', overflow: TextOverflow.ellipsis),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 30,
                  child: FlatButton(
                    child: Text('添加',
                        style: TextStyle(
                            //当主题色为黄色时，按钮文字颜色为黑色
                            color: Provider.of<ThemeProvider>(context)
                                        .themecolor ==
                                    Colors.yellow
                                ? Colors.black
                                : Colors.white)),
                    color: Provider.of<ThemeProvider>(context).themecolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    onPressed: () {},
                  ),
                ),
                IconButton(icon: Icon(Icons.close), onPressed: null)
              ],
            )
          ],
        ));
  }

//选项卡组件
  Widget buildTabBar(BuildContext context) {
    return TabBar(
        //设置tab是否可水平滑动
        isScrollable: true,
        //控制器
        controller: _tabController,
        indicatorColor: Colors.transparent,
        //设置tab选中得颜色
        unselectedLabelColor: Colors.grey,
        indicator: RectangularIndicator(
          //獲取主題色
          color: Provider.of<ThemeProvider>(context).themecolor,
          bottomLeftRadius: 10,
          bottomRightRadius: 10,
          topLeftRadius: 10,
          topRightRadius: 10,
          verticalPadding: 8,
          horizontalPadding: 5,
          paintingStyle: PaintingStyle.fill,
        ),
        onTap: (int index) {
          FToast.toast(context, msg: '点击了' + _titles[index]);
          setState(() {
            this._currentIndex = index;
          });
        },
        tabs: _titles.map((item) {
          return Tab(text: item);
        }).toList());
  }

  //分割線
  Widget bulidDivider(double height) {
    return Container(
      height: height,
      color: Color(0xFFF3F3F3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('联系人'),
        leading: IconButton(
            icon: Icon(Icons.color_lens,size: 30),
            onPressed: () {
              Navigator.pushNamed(context, '/theme_page');
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add,size: 30),
            onPressed: () {
                FToast.toast(context, msg: '添加好友');
            }),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearch(),
            Container(
              margin: EdgeInsets.fromLTRB(16, 5, 16, 15),
              child: Text('可能认识的人 >'),
            ),
            buildKnowItem(
                'http://imgs.aixifan.com/block_1552374040919-Yq9eDMIyq2?imageView2/1/w/508/h/260/q/100',
                '张三'),
            buildKnowItem(
                'https://i0.hdslb.com/bfs/bangumi/6bbd679d4c04cfed5d5431607df6a9838c7d7932.jpg@1260w_600h.jpg',
                'Rapper'),
            bulidDivider(10),
            ListTile(
              title: Text('新朋友'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
            bulidDivider(10),
            buildTabBar(context),
            ContactTabView(selectIndex: this._currentIndex)
          ],
        ),
      ),
    );
  }
}
