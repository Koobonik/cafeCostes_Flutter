import 'dart:convert';
import 'dart:io';
import 'package:costes/ordermenu/detailmenu.dart';
import 'package:costes/ordermenu/kakaowebview.dart';
import 'package:costes/users/shoppingCartConfirmOrder.dart';
import 'package:costes/users/userinfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';
class ShoppingCart {
  static List<String> list;
  static List<String> money;
  static List<String> number;
  // DB에 있는 장바구니 가져옴
  static void getShoppingCart(String name) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
    String url ='https://cafecostes.com/flutter/getShopping';
    Map map = { "userName" : name };
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    final body = json.decode(reply);
    var hello = body['list'].toString();
    var hello2 = body['sum_cost'];
    print(hello);
    list = hello.split(",");
    money = body['sum_cost'].toString().split(",");
    number = body['num'].toString().split(",");
    print(money);
    print(list.toString() + "${list.length}");
    
  }

  // DB에 메뉴 추가
  static void setShoppingCart(String name, String order, int money, int num) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
    String url ='https://cafecostes.com/flutter/setShopping';
    Map map = { "userName" : name , "list" : order, "sum_cost" : money, "num" : num};
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    final body = json.decode(reply);
    var hello = body['list'].toString();
    var hello2 = body['sum_cost'];
    print(hello);
    ShoppingCart.list = hello.split(",");
    ShoppingCart.money = body['sum_cost'].toString().split(",");
    number = body['num'].toString().split(",");
    print(money);
    print(list.toString() + "${list.length}");
  }

  // 장바구니 초기화
  static void resetShoppingCart(String name) async {
    print(name);
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
    String url ='https://cafecostes.com/flutter/removeShopping';
    Map map = { "userName" : name };
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    final body = json.decode(reply);
    var hello = body['list'].toString();
    print(hello);
    ShoppingCart.list = hello.split(",");
    ShoppingCart.money = body['sum_cost'].toString().split(",");
    ShoppingCart.number = body['num'].toString().split(",");
    print(money);
    print(list.toString() + "${list.length}");
  }

  // 장바구니를 단순 저장하는 메소드
  static void saveShoppingCart(String name, String order, String money, String nums) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
    String url ='https://cafecostes.com/flutter/saveShopping';
    Map map = { "userName" : name , "list" : order, "sum_cost" : money, "num" : nums};
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    final body = json.decode(reply);
    var hello = body['list'].toString();
    print(hello);
    ShoppingCart.list = hello.split(",");
    ShoppingCart.money = body['sum_cost'].toString().split(",");
    ShoppingCart.number = body['num'].toString().split(",");
    print(money);
    print(list.toString() + "${list.length}");
    
  }
}


class ShoppingView extends StatefulWidget {
  @override
  ShoppingViewState createState() => ShoppingViewState();
}

class ShoppingViewState extends State<ShoppingView> {
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
  var items = List<String>.generate(ShoppingCart.list.length -1 , (i) => "${ShoppingCart.list[i]}");
  @override
  Widget build(BuildContext context) {
    ShoppingCart.getShoppingCart(userinfo.userName);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(238, 232, 198, 1.0),
        title: const Text('장바구니',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[      // Add 3 lines from here... // 네비게이션바임 아이콘버튼 만들고 액션 넣을 수 있음
            new IconButton(
              icon: const Icon(Icons.restore_from_trash),
              color: Colors.black,
              onPressed: (){
                ShoppingCart.resetShoppingCart(userinfo.userName);
                
          }),
          // 장바구니에 닮겨있는것들 주문하기
            new IconButton(
              icon: const Icon(Icons.payment),
              color: Colors.black,
              onPressed: () async {
                
                // 여기를 주석처리 해주던가
                // Navigator.push(context,
                //   MaterialPageRoute<void>(builder: (BuildContext context){
                //     return ShoppingCartConfirmOrder();
                //     }
                //   )
                // );

                // 여기를 주석처리 해줘야 함.

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

                
          }
          ),
        ],      
      ),
      //body: Container(child: Text('asd'),),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];

            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  items.removeAt(index);
                  ShoppingCart.list.removeAt(index);
                  ShoppingCart.money.removeAt(index);
                  ShoppingCart.number.removeAt(index);
                  ShoppingCart.saveShoppingCart(userinfo.userName, ShoppingCart.list.toString(), ShoppingCart.money.toString(), ShoppingCart.number.toString());
                });

                // Then show a snackbar.

                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("$item 제거됨.")));
              },
              // Show a red background as the item is swiped away.
              background: Container(
                child: Icon(
                  Icons.restore_from_trash,
                  color: Colors.blue
                  ),
                color: Colors.red,
                // child: Text(
                //     '밀어서 지워버리기~',
                //     textAlign: TextAlign.end,
                //     ),
                ),
              
              child: ListTile(title: Text('$item ${ShoppingCart.money[index]}원')),
            );
          },
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
  