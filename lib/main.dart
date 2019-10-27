import 'package:costes/agree.dart';
import 'package:costes/costesmainview.dart';
import 'package:costes/find_OR_change.dart';
import 'package:costes/firebaseController.dart';
import 'package:costes/master/masterorder.dart';
import 'package:costes/ordermenu/detailmenu.dart';
import 'package:costes/users/shoppingCart.dart';
import 'package:costes/users/userinfo.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'ordermenu/getmenu.dart';
import 'package:toast/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void main() async {
  Getmenu.getMenu();
  Getmenu.getListMenuLength();
  Getmenu.getListEss();
  Getmenu.getListAde();
  Getmenu.getListHub();
  Getmenu.getListLatte();
  Getmenu.getListShake();
  Getmenu.getListSummer();
  //AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //Firebase 설정
  
  
  FirebaseController.firebaseconfig();

  HttpClient client = new HttpClient();
  client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
  //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
  String url ='https://cafecostes.com/onesay';
  HttpClientRequest request = await client.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  HttpClientResponse response = await request.close();
  userinfo.onesay = await response.transform(utf8.decoder).join();
  print(userinfo.onesay);

  //유저 정보 로딩 있는지 없는지에 따라 뷰를 바꿔줌
  userinfo.confirm();
  userinfo.read();
}
void signupview(){
  runApp(SignUpView());
}
void costesmainview(){
  runApp(Costesmainview());
}

class MyApp extends StatelessWidget {
  static String ftoken = '';
  static final CREATE_POST_URL = 'https://cafecostes.com/flutter/login';
  TextEditingController titleControler = new TextEditingController();
  TextEditingController bodyControler = new TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return new MaterialApp(
      title: "카페코스테스",
      theme: new ThemeData(
        //primaryColor: Colors.brown,
        primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
      ),
      home: new MyHomePage(title: "costes"),
    );
  }
  
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  

  @override
  _MyAppState createState() => new _MyAppState();
}
class _MyAppState extends State<MyHomePage> {
  static final CREATE_POST_URL = 'https://cafecostes.com/flutter/login';
  TextEditingController titleControler = new TextEditingController();
  TextEditingController bodyControler = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      title: "코스테스",
      theme: ThemeData(
        //primaryColor: Colors.brown,
        primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('로그인',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            ),
          backgroundColor: const Color.fromRGBO(238, 232, 198, 1.0),
        ),
        body: new Container(
          // margin: const EdgeInsets.only(left: 50.0, right: 50.0, top: 30, bottom: 30),
          margin: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: <Widget>[
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: titleControler,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      /*hintText: "id",*/ labelText: '아이디'),
                ),
                new TextField(
                  cursorColor: const Color.fromRGBO(238, 232, 198, 1.0),
                  controller: bodyControler,
                  decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    fillColor: const Color.fromRGBO(238, 232, 198, 1.0),
                      /*hintText: "password",*/ labelText: '비밀번호'),
                  obscureText: true,
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  child: new RaisedButton(
                  color: const Color.fromRGBO(238, 232, 198, 1.0),
                  child: const Text("로그인"),
                  onPressed: () async {
                    HttpClient client = new HttpClient();
                    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
                    //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
                    String url ='https://cafecostes.com/flutter/login';
                    Map map = { "id" : "${titleControler.text}" , "password" : "${bodyControler.text}", "firebaseToken" : MyApp.ftoken};
                    print(MyApp.ftoken);
                    HttpClientRequest request = await client.postUrl(Uri.parse(url));
                    request.headers.set('content-type', 'application/json');
                    request.add(utf8.encode(json.encode(map)));
                    HttpClientResponse response = await request.close();
                    String reply = await response.transform(utf8.decoder).join();
                    print(reply);
                    if (reply == ""){
                      showToast("아이디 또는 비밀번호가 맞지 않습니다.", gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                    }
                    // 로그인 성공시 액션
                    else {
                      var hepp = reply;
                      String jsoned = jsonEncode(hepp);
                      final body = json.decode(hepp);
                      userinfo.userName = body['userName'];
                      //userinfo.userCoupon = body['coupon'];
                      userinfo.id = body['userLoginId'];
                      userinfo.password = body['userLoginPassword'];
                      userinfo.userPermission = body['userPermission'];
                      await userinfo.getCoupon();
                      userinfo.save();
                      print(body['coupon']);
                      print(body['userName']);
                      ShoppingCart.getShoppingCart(body['userName']);
                      costesmainview();
                    }
                  },// onpressed
                  ),
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  child: new RaisedButton(
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                          return Agree();
                      })
                    );
                  },
                  child: const Text("회원가입"),
                  )
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  child: new RaisedButton(
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                          return FindID();
                      })
                    );
                  },
                  child: const Text("아이디 찾기"),
                  )
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  child: new RaisedButton(
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                          return FindPassword();
                      })
                    );
                  },
                  child: const Text("비밀번호 찾기"),
                  )
                ),
              ],
          ),
        ),
      ),
    );
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
  
}