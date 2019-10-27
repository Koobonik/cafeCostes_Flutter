import 'dart:convert';
import 'dart:io';

import 'package:costes/ordermenu/detailmenu.dart';
import 'package:costes/ordermenu/kakaowebview.dart';
import 'package:costes/users/shoppingCart.dart';
import 'package:costes/users/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ShoppingCartConfirmOrder extends StatefulWidget {

  @override
  ShoppingCartConfirmOrderState createState() => ShoppingCartConfirmOrderState();
}

class ShoppingCartConfirmOrderState extends State<ShoppingCartConfirmOrder> {
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
  
  // Declare this variable
  int selectedRadioTile = -1;
  String takeoutORnot = "테이크아웃";
  var coupon2;
  var coupon3;
 


  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "장바구니 주문 확인",
      theme: ThemeData(
        //primaryColor: Colors.brown,
        primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(238, 232, 198, 1.0),
          title: const Text('장바구니 주문 확인',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () { 
              print("장바구니 주문 확인");
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[      // Add 3 lines from here... // 네비게이션바임 아이콘버튼 만들고 액션 넣을 수 있음
          
        ],      
      ),
      // 바디
      body: 
      Center(child: 
        ListView(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: <Widget>[
                
                Text("\n주문 내역을 확인해주세요\n",style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.black,
                ),),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                  //color: ,
                  
                  margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),

                  child: InkWell(
                    child: Container(
                      width: 320,
                      // height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // 여기 고쳐주면 됩니당
                          
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(ShoppingCart.list.length, (index) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                            ListTile(
                            title: Text("${ShoppingCart.list[index]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),),],)
                            )
                            ),

                          // 결제하기 버튼 누르면 쇼핑카트에 있는 목록들 주문하게 해줘야함

                          // Text("${DetailMenu.hotice} " + DetailMenu.title + " " + DetailMenu.string_size + " " + DetailMenu.string_shot + " ${DetailMenu.number}잔 ${DetailMenu.userwant}",style: TextStyle(
                          //   fontWeight: FontWeight.bold,
                          //   fontSize: 18,
                          //   color: Colors.black,
                          // ),),
                          Text('\n보유 쿠폰',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ListTile(
                            title: Text("사용 안함",
                            style: TextStyle(
                              //fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),),
                            leading: Radio(
                              groupValue: selectedRadioTile,
                              onChanged: (int i) => setState(() {
                                  selectedRadioTile = -1;
                                  print(i);
                                } 
                              ),
                              value: -1,
                            ),
                            
                          ),
                          Column(children: List.generate(userinfo.userCoupon, (index) => Column(children: <Widget>[
                            ListTile(
                            title: Text("${userinfo.couponList[index]}",
                            style: TextStyle(
                              //fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),),
                            leading: Radio(
                              groupValue: selectedRadioTile,
                              onChanged: (int i) => setState(() {
                                String coupon = userinfo.couponList[index];
                                coupon2 = coupon.split("쿠폰 번호 : ");
                                coupon3 = coupon2[1].toString().split("  쿠폰 이름");
                                selectedRadioTile = i;
                                //selectedRadioTile = int.parse(coupon3[0]);
                                print(i);
                              } 
                              ),
                              value: index,
                            ),
                            
                          ),
                          ],))),
                          Column(
                            children: <Widget>[
                              new Divider(),
                              ListTile(
                              title: Text("테이크아웃",
                              style: TextStyle(
                                //fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),),
                              leading: Radio(
                                groupValue: takeoutORnot,
                                onChanged: (String j) => setState(() {
                                  takeoutORnot = j;
                                  //selectedRadioTile = int.parse(coupon3[0]);
                                  print(j);
                                } 
                                ),
                                value: "테이크아웃",
                              ),
                            
                            ),
                            ListTile(
                              title: Text("매장 내 이용",
                              style: TextStyle(
                                //fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),),
                              leading: Radio(
                                groupValue: takeoutORnot,
                                onChanged: (String j) => setState(() {
                                  takeoutORnot = j;
                                  //selectedRadioTile = int.parse(coupon3[0]);
                                  print(j);
                                } 
                                ),
                                value: "매장 내 이용",
                              ),

                            ),
                            ],
                          )
                        ],),
                        

                    ),
                  ),
                ),
                new RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                    padding: const EdgeInsets.all(8.0),
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                    // 눌렀을때 액션
                    onPressed: () async {
                      // 이게 인덱스임
                      print(selectedRadioTile);
                      String orderAndCoupon = "";
                      
                      String title, string_size, string_shot,userwant, hotice;
                      title = DetailMenu.title;
                      hotice = DetailMenu.hotice;
                      string_size = DetailMenu.string_size;
                      string_shot = DetailMenu.string_shot;
                      userwant = DetailMenu.userwant;
                      int money, shotMoney, sizeMoney, number;
                      money = DetailMenu.money;
                      shotMoney = DetailMenu.shotMoney;
                      sizeMoney = DetailMenu.sizeMoney;
                      number = DetailMenu.number;
                      // 위에 변수들로 대입해줘서 주문 요청 다시 만들어 줘야해 본익아
                      orderAndCoupon = hotice + " " + title + " " + string_size + " " + string_shot + " ${number}잔 ${userwant} ${takeoutORnot}";
                      // 쿠폰 사용 안할 경우
                      if(selectedRadioTile == -1){
                        print("쿠폰은 사용 안함");

                      }
                      // 쿠폰 사용할 경우
                      else {
                        String hi = userinfo.couponList[selectedRadioTile];
                        var coupon2 = hi.split("쿠폰 이름 : ");
                        var coupon3 = coupon2;
                        print(coupon3[1]);
                        if(coupon3[1] == "무료 사이즈 업"){
                          print("무료 사이즈 업 들어옴");
                          print(string_size);
                          if(string_size == "S"){
                            string_size = "M";
                          }
                          else if (string_size == "M"){
                            string_size = "L";
                          }
                          else if(string_size == "L"){
                            showToast("이미 최대 사이즈라서 사용이 불가 합니다.", gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                            return ;
                          }
                        }
                        orderAndCoupon = hotice + " " + title + " " + string_size + " " + string_shot + " ${number}잔 ${userwant} " + hi + " ${takeoutORnot}";
                      }
                      if(selectedRadioTile != -1){
                        HttpClient client3 = new HttpClient();
                        client3.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
                        // 서버에서 쿠폰 자체를 막아뒀을 수 있어서 한번 검증하는 URL
                        String url3 ='https://cafecostes.com/flutter/couponStatus';
                        //Map map2 = null;
                        HttpClientRequest request3 = await client3.postUrl(Uri.parse(url3));
                        request3.headers.set('content-type', 'application/json');
                        //request2.add(utf8.encode(json.encode(map2)));
                        HttpClientResponse response3 = await request3.close();
                        String reply3 = await response3.transform(utf8.decoder).join();

                        if(reply3 == "true"){

                        }
                        else {
                          showToast(reply3, gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                          return ;
                        }
                      }
                      // 패킷 보내는 곳
                HttpClient client2 = new HttpClient();
                client2.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
                String url2 ='https://cafecostes.com/flutter/serverStatus';
                //Map map2 = null;
                HttpClientRequest request2 = await client2.postUrl(Uri.parse(url2));
                request2.headers.set('content-type', 'application/json');
                //request2.add(utf8.encode(json.encode(map2)));
                HttpClientResponse response2 = await request2.close();
                String reply2 = await response2.transform(utf8.decoder).join();

                if(reply2 == "true"){
                  HttpClient client = new HttpClient();
                  client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
                  //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
                  String url ='https://cafecostes.com/flutter/kakaoPay2';
                  // item_name 에는 음료에 대한 샷 추가 사이즈 업이나 요청사항등이 같이 실려갈 것임
                  int order_money = 0;
                  for (int i = 0; i < ShoppingCart.money.length -1; i++){
                    order_money += int.parse(ShoppingCart.money[i]);
                  }
                  String order_list = "";
                  for (int i= 0; i< ShoppingCart.list.length -1; i++){
                    // 뒤에 콤마 제거해 줌
                    if (i == ShoppingCart.list.length -2){
                      order_list += "${ShoppingCart.list[i]}";
                    }
                    else{
                      order_list += "${ShoppingCart.list[i]}, ";
                    }

                  }
                  // int number = 0;
                  // for (var i = 0; i < ShoppingCart.number.length; i++) {
                  //   number += int.parse(ShoppingCart.number[i]);
                  // }
                  if(order_list.length >= 100){
                    showToast("주문 목록이 너무 많습니다. 나눠서 주문 해주세요 ㅠㅠ ");
                    //order_list = ShoppingCart.list[0] + "그 외 ${number}잔";
                    return;
                  }
                  Map map = { "partner_user_id" : "${userinfo.userName}" , "item_name" : order_list , "total_amount" : order_money};
                  //String map2 = "{'id' : '${titleControler.text}', 'password' : '${bodyControler.text}'";
                  HttpClientRequest request = await client.postUrl(Uri.parse(url));
                  request.headers.set('content-type', 'application/json');
                  request.add(utf8.encode(json.encode(map)));
                  HttpClientResponse response = await request.close();
                  String reply = await response.transform(utf8.decoder).join();
                  print(reply);

                        // 패킷 가져옴

                  // 그결과를 밑에서 다듬어줌
                  var hepp = reply;
                  String jsoned = jsonEncode(hepp);
                  final body = json.decode(hepp);
                  if (Platform.isAndroid) {
                    // Android-specific code
                    Kakao.app_scheme = body['android_app_scheme'];
                  } else if (Platform.isIOS) {
                    // iOS-specific code
                    Kakao.app_scheme = body['ios_app_scheme'];
                  }
                  Kakao.redirect_url = body['next_redirect_pc_url'];
                  print("리다이렉트 : " + Kakao.redirect_url);
                  print(Kakao.app_scheme);
                  //_launchURL(Kakao.app_scheme);
                  if(Platform.isIOS){
                    Kakao.iOS_redirect_url = body['next_redirect_app_url'];
                    _launchURL(Kakao.iOS_redirect_url);
                  }
                  else if (Platform.isAndroid){
                    Kakao.android_redirect_url = body['next_redirect_mobile_url'];
                    _launchURL(Kakao.android_redirect_url);
                  }
                  // 다시 초기화
                  DetailMenu.number = 1;
                  DetailMenu.sizeMoney = 0;
                  DetailMenu.string_shot = '';
                }
                else {
                  showToast(reply2);
                  return ;
                }
                    },
                    child: Column(
                      children: <Widget>[
                      Icon(Icons.payment),
                      Text("결제하기"),
                      ],
                    ),
        ),
                
              ],),
            


          ],
          ),
      ),
      
          
    ),
    );
  }
}
void _launchURL(var url) async {
    if (await canLaunch(url)) {
      print("열린다");
      
      try {
        await launch(url);
      } catch (PlatformException) {
        print('sd');
        Kakao.redirect_url = '';
        Kakao.app_scheme = '';
        return;
      }
    } 
    else {
      try {
        throw closeWebView();
      } catch (PlatformException){
        return;
      }
    }
  }