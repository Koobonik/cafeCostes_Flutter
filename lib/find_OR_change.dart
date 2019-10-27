import 'dart:io';

import 'package:costes/users/userinfo.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'main.dart';

void main() => runApp(FindID());
class FindID extends StatefulWidget{
  @override
  FindID_Screen createState() => new FindID_Screen();
}

class FindID_Screen extends State<FindID>{
  static final CREATE_POST_URL = 'https://cafecostes.com/flutter/signup';
  TextEditingController id_box_text = new TextEditingController();
  TextEditingController pw_box_text = new TextEditingController();
  TextEditingController pw_box_text2 = new TextEditingController();
  TextEditingController nick_name_box_text = new TextEditingController();
  TextEditingController email_box_text = new TextEditingController();

  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      title: "아이디 찾기",
      theme: ThemeData(
        //primaryColor: Colors.brown,
        primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('아이디 찾기'),
            centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () { 
              print("아이디 찾기 뷰 나가기");
              Navigator.of(context).pop();
            },
          ), 
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: <Widget>[
                
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: email_box_text,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      labelText: '이메일로 아이디를 보내드릴 예정입니다.'),
                ),
                // 회원가입 버튼
                ButtonTheme(
                  minWidth: double.infinity,
                  child: new RaisedButton(
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                  onPressed: () async {
                    // 회원가입 버튼 클릭시 동작
                    HttpClient client = new HttpClient();
                    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
                    //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
                    String url ='https://cafecostes.com/flutter/findID';
                    Map map = { "email" : "${email_box_text.text}" };
                    HttpClientRequest request = await client.postUrl(Uri.parse(url));
                    request.headers.set('content-type', 'application/json');
                    request.add(utf8.encode(json.encode(map)));
                    HttpClientResponse response = await request.close();
                    String reply = await response.transform(utf8.decoder).join();
                    print(reply);

                    showToast("${reply}");
                    print(reply.substring(0, 4));
                  },
                  child: const Text("이메일 보내기"),
                  )
                ),
              ],
            ),
          )
        ),
    );
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}

// 이메일 인증 뷰
class EmailAuth extends StatefulWidget{
  @override
  EmailAuth_Screen createState() => new EmailAuth_Screen();
}

class EmailAuth_Screen extends State<EmailAuth>{
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  } 
  TextEditingController email_box_text = new TextEditingController();
  TextEditingController email_code_text = new TextEditingController();
  var _status = false;
  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      title: "이메일 인증",
      theme: ThemeData(
        //primaryColor: Colors.brown,
        primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('이메일 인증'),
            centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () { 
              print("이메일 인증 뷰 나가기");
              Navigator.of(context).pop();
            },
          ), 
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: email_box_text,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      labelText: '이메일'),
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  child: new RaisedButton(
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                  onPressed: () async {
                    if(email_box_text.text == ""){
                      showToast("이메일을 입력해주세요.");
                      return ;
                    }
                    if(!email_box_text.text.contains("@") || !email_box_text.text.contains(".")){
                      showToast("잘못된 이메일 형식 입니다.");
                      return ;
                    }
                    // 회원가입 버튼 클릭시 동작
                    HttpClient client = new HttpClient();
                    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
                    String url ='https://cafecostes.com/flutter/emailAuth';
                    Map map = {"email" : "${email_box_text.text}" };
                    HttpClientRequest request = await client.postUrl(Uri.parse(url));
                    request.headers.set('content-type', 'application/json');
                    request.add(utf8.encode(json.encode(map)));
                    HttpClientResponse response = await request.close();
                    String reply = await response.transform(utf8.decoder).join();
                    print(reply);

                    
                    if(reply == "true"){
                      showToast("인증코드가 발송 되었습니다.");
                      email_box_text.text = "";
                    }
                  },
                  child: const Text("이메일로 인증 코드 보내기"),
                  //SignUpView
                  
                  )
                ),
                Container(height: 50,),
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: email_code_text,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      labelText: '인증코드'),
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  child: new RaisedButton(
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                  onPressed: () async {
                    // 인증코드
                    HttpClient client = new HttpClient();
                    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
                    String url ='https://cafecostes.com/flutter/signupEmailAuth';
                    Map map = {"email" : "${email_code_text.text}" };
                    HttpClientRequest request = await client.postUrl(Uri.parse(url));
                    request.headers.set('content-type', 'application/json');
                    request.add(utf8.encode(json.encode(map)));
                    HttpClientResponse response = await request.close();
                    String reply = await response.transform(utf8.decoder).join();
                    print(reply);

                    if("인증 시간이 초과 되었습니다." == reply){
                      print("인증 시간 초과");
                      showToast(reply);
                      return ;
                    }
                    else if("이미 사용된 코드 입니다." == reply){
                      print("이미 사용된 코드");
                      showToast(reply);
                      return ;
                    }
                    else if(reply != "fail"){
                      // 유저 이메일 담아줌
                      userinfo.userEmail = reply;
                      Navigator.push(context,
                            MaterialPageRoute<void>(builder: (BuildContext context) {
                              print("회원가입 뷰로 넘어가기");
                                return SignUpView();
                            })
                        );
                    }
                    else {
                      showToast("잘못된 코드 입니다.");
                      return ;
                    }
                  }
                  ,
                  child: const Text("인증코드 입력하기"),
                  //SignUpView
                  
                  )
                )

              ]
            ),
          )
      ),
    );
  }
}

class FindPassword extends StatefulWidget{
  @override
  FindPassword_Screen createState() => new FindPassword_Screen();
}

class FindPassword_Screen extends State<FindPassword>{
  TextEditingController id_box_text = new TextEditingController();
  TextEditingController pw_box_text = new TextEditingController();
  TextEditingController pw_box_text2 = new TextEditingController();
  TextEditingController nick_name_box_text = new TextEditingController();
  TextEditingController email_box_text = new TextEditingController();

  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      title: "임시 비밀번호 설정",
      theme: ThemeData(
        //primaryColor: Colors.brown,
        primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('임시 비밀번호 설정'),
            centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () { 
              print("비밀번호 찾기 뷰 나가기");
              Navigator.of(context).pop();
            },
          ), 
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: id_box_text,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      labelText: '아이디'),
                ),
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: email_box_text,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      labelText: '이메일'),
                ),
                // 회원가입 버튼
                ButtonTheme(
                  minWidth: double.infinity,
                  child: new RaisedButton(
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                  onPressed: () async {
                    // 회원가입 버튼 클릭시 동작
                    HttpClient client = new HttpClient();
                    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
                    String url ='https://cafecostes.com/flutter/findPassword';
                    Map map = {"id" : "${id_box_text.text}", "email" : "${email_box_text.text}" };
                    HttpClientRequest request = await client.postUrl(Uri.parse(url));
                    request.headers.set('content-type', 'application/json');
                    request.add(utf8.encode(json.encode(map)));
                    HttpClientResponse response = await request.close();
                    String reply = await response.transform(utf8.decoder).join();
                    print(reply);

                    showToast("${reply}");
                    print(reply.substring(0, 4));
                  },
                  child: const Text("임시 비밀번호 이메일로 보내기"),
                  )
                ),
              ],
            ),
          )
        ),
    );
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}


// 회원 가입 뷰
class SignUpView extends StatefulWidget{
  @override
  SignUpViewScreen createState() => new SignUpViewScreen();
}

class SignUpViewScreen extends State<SignUpView>{
  static final CREATE_POST_URL = 'https://cafecostes.com/flutter/signup';
  TextEditingController id_box_text = new TextEditingController();
  TextEditingController pw_box_text = new TextEditingController();
  TextEditingController pw_box_text2 = new TextEditingController();
  TextEditingController nick_name_box_text = new TextEditingController();
  TextEditingController email_box_text = new TextEditingController();
  TextEditingController birthday_box_text = new TextEditingController();

  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      title: "회원가입",
      theme: ThemeData(
        //primaryColor: Colors.brown,
        primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('회원가입'),
            centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () { 
              print("회원가입 뷰 나가기");
              Navigator.of(context).pop();
            },
          ), 
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: id_box_text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      hintText: "영문 및 숫자로만 입력해주세요. (4자 이상)",
                      labelText: '로그인 아이디'),
                ),
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: pw_box_text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      hintText: "9글자 이상으로 입력해주세요.",
                      labelText: '비밀번호'),
                  obscureText: true,
                ),
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: pw_box_text2,
                  decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      hintText: "9글자 이상으로 입력해주세요.",
                      labelText: '비밀번호 확인'),
                  obscureText: true,
                ),
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: nick_name_box_text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      hintText: "영문 및 숫자로만 입력해주세요. (3자 이상)",
                      labelText: '닉네임'),
                ),
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: birthday_box_text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      hintText: "ex) 960130",
                      labelText: '생년월일'),
                ),
                // new TextField(
                //   cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                //   controller: email_box_text,
                //   decoration: InputDecoration(
                //     fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                //       labelText: '이메일 (아이디 비밀번호 찾을 때 이용)'),
                // ),
                // 회원가입 버튼
                ButtonTheme(
                  minWidth: double.infinity,
                  child: new RaisedButton(
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                  onPressed: () async {

                    // 회원가입 버튼 클릭시 동작들


                    // 아이디
                    if(id_box_text.text.length < 4){
                      showToast("로그인 아이디는 영문 및 숫자로 4자 이상으로 해주세요", gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                      return ;
                    }

                    // 비밀번호
                    if(pw_box_text.text.length < 9){
                      showToast("비밀번호는 9자 이상으로 생성해주세요.");
                      return ;
                    }

                    // 비밀번호 중복 체크
                    if(pw_box_text.text != pw_box_text2.text){
                      showToast("비밀번호가 일치하지 않습니다.");
                      return ;
                    }


                    // 
                    if(nick_name_box_text.text.length < 3){
                      showToast("닉네임은 3자 이상으로 지어주세요");
                      return ;
                    }

                    // 유저 인풋 예외처리
                    if(birthday_box_text.text.length != 6){
                      showToast("생년월일은 숫자 6자리만 입력해주세요");
                      return ;
                    }

                    //
                    
                    // 회원가입 버튼 클릭시 동작
                    HttpClient client = new HttpClient();
                    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
                    //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
                    String url ='https://cafecostes.com/flutter/signup';
                    Map map = { "id" : "${id_box_text.text}" , "password" : "${pw_box_text.text}", "password2" : "${pw_box_text2.text}" , "nickname" : "${nick_name_box_text.text}", "email" : "${userinfo.userEmail}", "birthday" : "${birthday_box_text.text}" };
                    HttpClientRequest request = await client.postUrl(Uri.parse(url));
                    request.headers.set('content-type', 'application/json');
                    request.add(utf8.encode(json.encode(map)));
                    HttpClientResponse response = await request.close();
                    String reply = await response.transform(utf8.decoder).join();
                    print(reply);

                    showToast("${reply}");
                    print(reply.substring(0, 5));
                    if(reply.substring(0, 5) == "회원가입이"){
                      Navigator.pushNamed(context, "/");
                    }
                  },
                  child: const Text("회원가입"),
                  )
                ),
              ],
            ),
          )
        ),
    );
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}


class ChangePassword extends StatefulWidget{
  @override
  ChangePasswordScreen createState() => new ChangePasswordScreen();
}

class ChangePasswordScreen extends State<ChangePassword>{
  TextEditingController id_box_text = new TextEditingController();
  TextEditingController pw_box_text = new TextEditingController();
  TextEditingController pw_box_text2 = new TextEditingController();
  TextEditingController nick_name_box_text = new TextEditingController();
  TextEditingController email_box_text = new TextEditingController();

  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      title: "비밀번호 변경",
      theme: ThemeData(
        //primaryColor: Colors.brown,
        primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('비밀번호 변경'),
            centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () { 
              print("비밀번호 변경 뷰 나가기");
              Navigator.of(context).pop();
            },
          ), 
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: id_box_text,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      labelText: '아이디'),
                ),
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: email_box_text,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      labelText: '현재 비밀번호'),
                      obscureText: true,
                ),
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: pw_box_text,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      labelText: '변경할 비밀번호'),
                      obscureText: true,
                ),
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: pw_box_text2,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      labelText: '변경할 비밀번호 확인'),
                      obscureText: true,
                ),
                
                // 비밀번호 변경 버튼
                ButtonTheme(
                  minWidth: double.infinity,
                  child: new RaisedButton(
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                  onPressed: () async {
                    // 비밀번호 변경 버튼 클릭시 동작
                    HttpClient client = new HttpClient();
                    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
                    String url ='https://cafecostes.com/flutter/changePassword';
                    Map map = { "id" : "${id_box_text.text}" , "password" : "${pw_box_text.text}", "password2" : "${pw_box_text2.text}" , "email" : "${email_box_text.text}"};
                    HttpClientRequest request = await client.postUrl(Uri.parse(url));
                    request.headers.set('content-type', 'application/json');
                    request.add(utf8.encode(json.encode(map)));
                    HttpClientResponse response = await request.close();
                    String reply = await response.transform(utf8.decoder).join();
                    print(reply);

                    showToast("${reply}");
                    print(reply.substring(0, 4));
                    if(reply.substring(0, 4) == "성공적으"){
                      userinfo.id = id_box_text.text;
                      userinfo.password = pw_box_text.text;
                      userinfo.save();
                    }
                  },
                  child: const Text("비밀번호 변경하기"),
                  )
                ),
              ],
            ),
          )
        ),
    );
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}