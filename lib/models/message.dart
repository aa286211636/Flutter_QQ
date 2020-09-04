
class Message {
  int hasread;
  String username;
  String content;
  String createdtime;
  String headurl;

  Message.fromJson(Map data) {
    createdtime = data['createdtime'];
    content = data['content'];
    hasread = data['hasread'];
    username = data['username'];
    headurl = data['headurl'];
  }
}

