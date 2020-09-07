import 'package:flutter/material.dart';
import 'package:fsearch/fsearch.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:metashare_flutter/providers/provider_manager.dart';
import 'package:ftoast/ftoast.dart';
import 'package:metashare_flutter/utils/screen.dart';
import 'package:metashare_flutter/video/chewie_video_custom.dart';

class FocusPage extends StatefulWidget {
  FocusPage({Key key}) : super(key: key);

  @override
  _FocusPageState createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _titles; //tab标签
  int _currentIndex; //選中下標

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _titles = ['关注', '推荐', '视频', '好友', '小说', '热点', '科技'];
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

//选项卡组件
  Widget buildTabBar(BuildContext context) {
    return TabBar(
        //设置tab是否可水平滑动
        isScrollable: true,
        //控制器
        controller: _tabController,
        indicatorColor: Colors.transparent,
        //设置tab选中得颜色
        labelColor: Colors.white,
        unselectedLabelColor: Color(0xfff5f5dc),
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

  //图片组件
  Widget buildImage(String url) {
    return Container(
      width: (Screen.width(context) - 40) / 3,
      child: AspectRatio(
        aspectRatio: 1.5 / 1,
        child: Image(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //图片Item组件
  Widget buildImageItem() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildImage(
                  'https://i0.hdslb.com/bfs/bangumi/6bbd679d4c04cfed5d5431607df6a9838c7d7932.jpg@1260w_600h.jpg'),
              buildImage(
                  'https://i0.hdslb.com/bfs/bangumi/7c2d61371956daabb2b9a1fb5fe43e2cc9f46f5c.jpg@1260w_600h.jpg'),
              buildImage(
                  'https://i0.hdslb.com/bfs/bangumi/b773f9d1733747302778eca86f0c00d6c79f6d06.jpg@1260w_600h.jpg'),
            ],
          ),
          Container(
            width: Screen.width(context) - 20,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              '【3D首公开】请接收来自心萪的七夕礼物~在这里祝大家七夕快乐！',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text('小怪侃世界     246评论'),
          ),
          Divider(color: Color(0xFFD3D3D3)),
        ],
      ),
    );
  }

  //视频Item组件
  Widget buildVideoItem() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Screen.width(context) - 20,
            child: ChewieVideoCustom(
                'https://www.runoob.com/try/demo_source/mov_bbb.mp4'),
          ),
          Container(
            width: Screen.width(context) - 20,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              '【3D首公开】请接收来自心萪的七夕礼物~在这里祝大家七夕快乐！',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text('小怪侃世界     246评论'),
          ),
          Divider(color: Color(0xFFD3D3D3)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildSearch(),
        titleSpacing: -15,
        bottom: buildTabBar(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [buildImageItem(), buildVideoItem(), buildImageItem()],
        ),
      ),
    );
  }
}
