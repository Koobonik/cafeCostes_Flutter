import 'dart:convert';
import 'dart:io';

import 'package:costes/costesmainview.dart';
import 'package:costes/main.dart';
import 'package:costes/users/shoppingCart.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userinfo {
  static String id = ""; // 유저 아이디 값
  static String password = ""; // 유저 패드워드
  static String userName = ""; // 유저 닉네임
  static int userCoupon = 0; // 유저가 갖고있는 쿠폰 개수
  static String onesay; // 사장님의 한마디 라인
  static String userEmail = ""; // 유저 이메일
  static int userPermission = 0; // 유저 권한도!
  static var couponList;

  static var ordersuccess = ""; // 쿠폰 주문했을경우 임시로 저장해주는 변수

  static Future save() async {
    print("userinfo.save() 실행");
    final prefs = await SharedPreferences.getInstance();
    //userinfo.userCoupon = (prefs.getInt('counter') ?? 0) + 1;

    // 여기 저장하는 부분
    prefs.setString('id', userinfo.id);
    prefs.setString('password', userinfo.password);
    prefs.setString('email', userinfo.userEmail);
    prefs.setInt('userCoupon', userinfo.userCoupon);
    prefs.setString('userName', userinfo.userName);
    prefs.setStringList('couponList', couponList);
    prefs.setInt('userPermission', userPermission);
    print(prefs.getString('userName'));
    print("userinfo.save() 종료");
  }

  static Future read() async {
    print("userinfo.read() 실행");
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id");
    password = prefs.getString("password");
    userName = prefs.getString("userName");
    userCoupon = prefs.getInt("userCoupon");
    userEmail = prefs.getString("email");
    couponList = prefs.getStringList("couponList");
    userPermission = prefs.getInt("userPermission");

    // 유저가 로그인을 해두었다는 조건임
    if(userName != ""){
      HttpClient client = new HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
      String url ='https://cafecostes.com/flutter/getShopping';
      Map map = { "userName" : userName };
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(map)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      print(reply);
      try {
        final body = json.decode(reply);
        var hello = body['list'].toString();
        var hello2 = body['sum_cost'].toString();
        print(hello);
        ShoppingCart.list = hello.split(",");
        ShoppingCart.money = hello2.split(",");
        print(ShoppingCart.money);
        print(ShoppingCart.list.toString() + "${ShoppingCart.list.length}");
      } 
      catch (e) {
      }
      
      getCoupon();
      
    }
    

    print("userinfo.read() 종료");
    save();
  }

  static Future remove() async {
    print("userinfo.remove() 실행");
    final prefs = await SharedPreferences.getInstance();
    id = "";
    password = "";
    userName = "";
    userCoupon = 0;
    couponList = null;
    userPermission = 0;
    prefs.setInt('userCoupon', userCoupon);
    prefs.setString('id', id);
    prefs.setString('password', password);
    prefs.setString('userName', userName);
    prefs.setString('email', userEmail);
    prefs.setStringList("couponList", couponList);
    prefs.setInt('userPermission', userPermission);
    print("userinfo.remove() 종료");
    save();
  }

  static Future confirm() async {
    final prefs = await SharedPreferences.getInstance();
    print("confirm 진행");
    // 유저가 로그인 해두었으면
    print(prefs.getString('userName'));
    if (prefs.getString('userName') != "" && prefs.getString('userName') != null ){
      userName = prefs.getString("userName");
      userCoupon = prefs.getInt("userCoupon");
      id = prefs.getString("id");
      password = prefs.getString("password");
      userEmail = prefs.getString("email");
      userPermission = prefs.getInt("userPermission");
      print("쿠폰 개수 ${userCoupon}");
      // 기다렸다가 들어가기
      await getCoupon();
      runApp(Costesmainview());
    }
    else {
      runApp(MyApp());
    }
  }

  static void getCoupon() async {
    print("getCoupon 실행");
    final prefs = await SharedPreferences.getInstance();
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
    String url ='https://cafecostes.com/flutter/getCoupon';
    Map map = { "id" : userName };
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print("쿠폰 가져온 결과");
    if(reply == "" || reply == null || reply == "[]"){
      print("쿠폰 없음");
      userinfo.userCoupon = 0;
      prefs.setInt("userCoupon", 0);
      return ;
    }
    print(reply);
    reply = reply.replaceAll("[", "");
    reply = reply.replaceAll("]", "");
    reply = reply.replaceAll("\"", "");
    int i = 0;
    try {
      //var body = json.decode(reply);
      var dsf = reply.split(",");
      userCoupon = dsf.length;
      prefs.setInt("userCoupon", userCoupon);
      couponList = dsf;
      print(dsf.length);
      print(dsf);
      for(int c = 0 ; c < dsf.length; c++){
        print(couponList[c]);
      }
      

      
    } 
    catch (e) {
      print(e);
      print("에러");
    }
    print("getCoupon 종료");
  }
  
  
}