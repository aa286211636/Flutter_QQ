import 'package:flutter/material.dart';
import 'package:fsuper/fsuper.dart';
import 'package:metashare_flutter/models/message.dart';
import 'package:metashare_flutter/utils/screen.dart';

class MessageList extends StatelessWidget {
  final List<Message> messages;

  const MessageList({Key key, this.messages}) : super(key: key);

  Widget buildModule(BuildContext context, Message module) {
    return MessageItem(
      message: module,
    );
  }

  @override
  Widget build(BuildContext context) {
    var children = messages
        .map((item) => MessageItem(
              message: item,
            ))
        .toList();

    return Column(
      children: children,
    );
  }
}

class MessageItem extends StatelessWidget {
  final Message message;

  const MessageItem({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //頭像
                    CircleAvatar(
                      backgroundImage: NetworkImage(message.headurl),
                      radius: 25,
                    ),
                    //間距
                    SizedBox(
                      width: 10,
                    ),
                    //名字與內容
                    Container(
                      height: 44,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message.username,
                              style: TextStyle(fontSize: 16, color: Colors.black)),
                          Container(
                              width: Screen.width(context) * 0.5,
                              child: Text(message.content,overflow: TextOverflow.ellipsis))
                        ],
                      ),
                    )
                  ],
                ),
                //時間與未讀消息
                Container(
                  height: 44,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(message.createdtime), 
                      //設置Offstage控制顯示和隱藏
                      Offstage(
                        offstage: message.hasread == 1,
                        child: FSuper(
                          height: 20,
                          width: 20,
                          corner: FCorner.all(10),
                          backgroundColor: Colors.redAccent,
                          text: '3',
                          style:TextStyle(color: Colors.white),
                          textAlignment: Alignment.center,
                        )
                      )
                    ],
                  ),
                )
              ],
            )),
        //分割線
        Divider(
          height: 1,
          color: Color(0xFFDCDCDC),
        )
      ],
    );
  }
}
