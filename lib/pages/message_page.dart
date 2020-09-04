import 'package:fbutton/fbutton.dart';
import 'package:flutter/material.dart';
import 'package:metashare_flutter/providers/provider_manager.dart';
import 'package:metashare_flutter/utils/request.dart';
import 'package:fsearch/fsearch.dart';
import 'package:fsuper/fsuper.dart';
import 'package:metashare_flutter/models/message.dart';
import 'package:metashare_flutter/utils/screen.dart';
import 'package:metashare_flutter/views/msg_listview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ffloat/ffloat.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  //初始化数据
  List<Message> dataArr = [];
  var image;
  final picker = ImagePicker();
  FFloatController _floatcontroller; //浮动窗口控制器

//加载模拟请求
  @override
  void initState() {
    super.initState();
    getData();
    _floatcontroller = FFloatController();
  }

  //获取相册图片
  Future<PickedFile> loadImage(ImageSource imageSource) async {
    PickedFile file = await picker.getImage(source: imageSource);
    return file;
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

  //浮动控件
  Widget buildFloatWidget() {
    return FFloat(
      (setter) {
        return buildFloatContent();
      },
      controller: _floatcontroller,
      alignment: FFloatAlignment.bottomRight,
      corner: FFloatCorner.all(8),
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      margin: EdgeInsets.only(right: 15),
      triangleAlignment: TriangleAlignment.end,
      triangleOffset: Offset(-8, 0),
      triangleWidth: 15,
      triangleHeight: 10,
      color: Provider.of<ThemeProvider>(context).themecolor,
      anchor: IconButton(
          icon: Icon(Icons.add, size: 30),
          onPressed: () {
            _floatcontroller.show();
          }),
    );
  }

  //浮动内容Item
  Widget buildFloatContentItem(IconData data, String title) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          Icon(data,
              color: Provider.of<ThemeProvider>(context).themecolor ==
                      Colors.yellow
                  ? Colors.black
                  : Colors.white),
          Text(
            title,
            style: TextStyle(
                color: Provider.of<ThemeProvider>(context).themecolor ==
                        Colors.yellow
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  //浮动内容
  Widget buildFloatContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFloatContentItem(Icons.chat, '  创建群聊'),
        buildFloatContentItem(Icons.person_add, '  加好友/群'),
        buildFloatContentItem(Icons.select_all, '  扫一扫'),
        buildFloatContentItem(Icons.format_textdirection_l_to_r, '  面对面快传'),
        buildFloatContentItem(Icons.attach_money, '  收付款'),
      ],
    );
  }

  //导航控件
  Widget buildNavLeading(context) {
    //https://i.stack.imgur.com/Dw6f7.png
    return FSuper(
      height: Screen.navigationBarHeight(context),
      margin: EdgeInsets.only(left: 60),
      text: 'Lisa',
      textAlignment: Alignment.centerLeft,
      textAlign: TextAlign.left,
      spans: [
        FSuper.VerticalSpace(3),
        TextSpan(text: 'iPhoneX在线-4G', style: TextStyle(fontSize: 12))
      ],
      child1Alignment: Alignment.centerLeft,
      child1Margin: EdgeInsets.only(right: 60),
      child1: CircleAvatar(
        backgroundImage: NetworkImage(
            'http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg'),
      ),
    );
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

//其他设备登录控件
  Widget buildOtherLogin() {
    return Container(
      width: double.infinity,
      height: 30,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FButton(
            image: Icon(Icons.phone_iphone),
            imageMargin: 5,
            imageAlignment: ImageAlignment.left,
            text: 'iPad QQ已登录',
            color: Color.fromRGBO(249, 249, 249, 1),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildNavLeading(context),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_camera, size: 30),
              onPressed: () {
                loadImage(ImageSource.gallery);
              }),
          buildFloatWidget()
        ],
      ),
      //SingleChildScrollView防止键盘溢出屏幕警告
      body: SingleChildScrollView(
          child: Column(
        children: [
          buildSearch(),
          buildOtherLogin(),
          SizedBox(height: 10),
          Divider(height: 1, color: Colors.grey),
          MessageList(messages: dataArr)
        ],
      )),
    );
  }
}
