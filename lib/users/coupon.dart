
import 'dart:convert';
import 'dart:io';

import 'package:costes/couponOrderSuccess.dart';
import 'package:costes/users/orderlist.dart';
import 'package:flutter/material.dart';
import 'package:costes/users/userinfo.dart';
import 'package:toast/toast.dart';
class CouponView extends StatefulWidget {
  static var date = List();
  static var itemname = List();
  static var money = List();
  @override
  CouponViewState createState() => CouponViewState();
}

class CouponViewState extends State<CouponView> {
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "쿠폰",
      theme: ThemeData(
        //primaryColor: Colors.brown,
        primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(238, 232, 198, 1.0),
          title: const Text('쿠폰',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () { 
              print("쿠폰 나가기");
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[      // Add 3 lines from here... // 네비게이션바임 아이콘버튼 만들고 액션 넣을 수 있음
          
            new IconButton(
              icon: const Icon(Icons.refresh),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  print("셋스테이터스");
                  userinfo.getCoupon();
                });
          }),
          // 장바구니에 닮겨있는것들 주문하기
        ],      
      ),
      // 바디
      body: Center(
        child: ListView(
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              Column(
              children: List.generate(userinfo.userCoupon, (index) => Column(children: <Widget>[
                Text(
                "${userinfo.couponList[index]}\n",
                style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
              ),
              new RaisedButton(
                child: Text("사용하기"),
                color: const Color.fromRGBO(238, 232, 198, 1.0),
                // 이 버튼 누르면 쿠폰 이름 보여주면서 "정말로 이 쿠폰을 사용하시겠습니까? 사용하기 버튼을 누르시면 바로 제작에 들어가기에 취소할 수 없습니다." 라고 문구 보여주기
                onPressed: (){

                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      // 쿠폰 이름으로 스플릿... 귀찮아...
                      var couname = userinfo.couponList[index].toString().split("쿠폰 이름 : ");
                      return AlertDialog(
                        title: Text(couname[1]),
                        content: const Text('정말로 이 쿠폰을 사용하시겠습니까?\n사용하기 버튼을 누르시면 바로 제조를 시작하기에 취소할 수 없습니다.'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('취소하기'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),

                          FlatButton(
                            child: Text('주문하기'),
                            onPressed: () async {
                              setState(() async {
                                String hi = await usingCoupon(userinfo.couponList[index]);
                              print(hi);
                              if(hi == "true"){
                                // 얼럿창 제거해줘야함
                                Navigator.of(context).pop();

                                
                                // Navigator.popAndPushNamed(context, "costesMainView");
                                Navigator.push(context,
                                  MaterialPageRoute<void>(builder: (BuildContext context) {
                                    userinfo.ordersuccess = userinfo.couponList[index];
                                    print("쿠폰 주문 성공");
                                    return CouponOrderSuccess();
                                  }),
                                );
                              }
                              else {
                                setState(() {
                                  GetMyPayment.getMyPayment();
                                  userinfo.getCoupon(); 
                                });
                                showToast(hi, gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                              }
                              });
                              
                              
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              new Divider(),
              ],) 
              ),
            ),
            ],
        ),
      ),
      ),
    );
  }
}
Future<String> usingCoupon(String coupon) async {

  // 
  HttpClient client2 = new HttpClient();
  client2.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
  // 서버에서 쿠폰 자체를 막아뒀을 수 있어서 한번 검증하는 URL
  String url2 ='https://cafecostes.com/flutter/couponStatus';
  //Map map2 = null;
  HttpClientRequest request2 = await client2.postUrl(Uri.parse(url2));
  request2.headers.set('content-type', 'application/json');
  //request2.add(utf8.encode(json.encode(map2)));
  HttpClientResponse response2 = await request2.close();
  String reply2 = await response2.transform(utf8.decoder).join();

  if(reply2 == "true"){
    var coupon2 = coupon.split("쿠폰 번호 : ");
    var coupon3 = coupon2[1].toString().split("  쿠폰 이름");
    print(coupon2);
    print(coupon3[0]);
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
    String url ='https://cafecostes.com/flutter/usingCoupon';
    // 여기서는 파이어베이스 토큰값이 쿠폰 고유 번호임
    Map map = { "id" : "${userinfo.id}" , "password" : "${userinfo.password}", "firebaseToken" : coupon3[0]};
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String hi = await response.transform(utf8.decoder).join();
    if(hi == "true"){
      GetMyPayment.getMyPayment();
      userinfo.getCoupon();
      return "true";
    }
    // 쿠폰 사용 불가할 때
    else {
      GetMyPayment.getMyPayment();
      userinfo.getCoupon();
      return hi;
    }
  }
  // 서버 자체에서 쿠폰을 막았을 경우
  else {
    //GetMyPayment.getMyPayment();
    //userinfo.getCoupon();
    return reply2;
  }

  
  
}
