import 'package:flutter/material.dart';
import 'package:fsuper/fsuper.dart';
import 'package:metashare_flutter/utils/screen.dart';
import 'package:metashare_flutter/views/tabs.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool isCodeLogin = false;
  bool isvisible = false;
//验证码登录视图
  Widget buildCodeView() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Text('+86'),
              ),
              Container(
                width: Screen.width(context) - 120,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                      hintText: '请输入手机号'),
                ),
              )
            ],
          ),
          Container(
            child: Divider(
              color: Colors.black87,
            ),
          ),
          Container(
            child: Text('未注册的手机号验证后自动创建美团账户',
                style: TextStyle(fontSize: 10, color: Colors.grey)),
          )
        ],
      ),
    );
  }

  //密码登录视图
  Widget buildPwdView() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Text('+86'),
              ),
              Container(
                width: Screen.width(context) - 120,
                height: 50,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                      hintText: '请输入手机号'),
                ),
              )
            ],
          ),
          Container(
            child: Divider(
              color: Colors.black87,
            ),
          ),
          Container(
            width: Screen.width(context) - 70,
            height: 70,
            child: TextField(
              maxLength: 12,
              obscureText: !isvisible,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                  hintText: '请输入密码',
                  suffix: IconButton(
                      icon: Icon(
                        isvisible ? Icons.visibility : Icons.visibility_off,
                        size: 18,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isvisible = !isvisible;
                        });
                      })),
            ),
          ),
          Container(
            child: Divider(
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        actions: [
          FSuper(
            text: '帮助',
            style: TextStyle(color: Colors.black, fontSize: 16),
            padding: EdgeInsets.only(right: 20, top: 20),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(25, 50, 20, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '欢迎登录美团',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                Builder(
                  builder: (context) {
                    if (isCodeLogin) {
                      return buildCodeView();
                    } else {
                      return buildPwdView();
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                FSuper(
                  width: Screen.width(context) - 60,
                  height: 50,
                  text: isCodeLogin ? '获取短信验证码' : '登录',
                  style: TextStyle(fontSize: 17),
                  textAlignment: Alignment.center,
                  backgroundColor: Color.fromRGBO(252, 240, 191, 1),
                  corner: FCorner.all(5),
                  onClick: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return Tabs();
                    }), (route) => route == null);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FSuper(
                      text: isCodeLogin ? '密码登录' : '验证码登录',
                      onClick: () {
                        setState(() {
                          isCodeLogin = !isCodeLogin;
                        });
                      },
                    ),
                    FSuper(
                      text: '遇到问题',
                    )
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      child: IconButton(
                          icon: Icon(Icons.tag_faces, color: Colors.white),
                          onPressed: null),
                      backgroundColor: Colors.blue,
                      radius: 25,
                    ),
                    CircleAvatar(
                      child: IconButton(
                          icon: Icon(Icons.tag_faces, color: Colors.white),
                          onPressed: null),
                      backgroundColor: Colors.green,
                      radius: 25,
                    ),
                    CircleAvatar(
                      child: IconButton(
                          icon: Icon(Icons.tag_faces, color: Colors.white),
                          onPressed: null),
                      backgroundColor: Colors.cyan,
                      radius: 25,
                    )
                  ],
                ),
                FSuper(
                  margin: EdgeInsets.only(top: 40),
                  text: '登录代表同意',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                  spans: [
                    TextSpan(
                        text: '美团点评用户协议、隐私政策',
                        style: TextStyle(color: Colors.yellow, fontSize: 11)),
                    TextSpan(
                        text: '并授权使用您的美团点评账号信息（如昵称，头像，收货地址）以便您统一管理',
                        style: TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
