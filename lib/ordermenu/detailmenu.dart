// Flutter code sample for material.DropdownButton.1

// This sample shows a `DropdownButton` whose value is one of
// "One", "Two", "Free", or "Four".

import 'dart:convert';
import 'dart:io';
import 'package:costes/ordermenu/confirmOrder.dart';
import 'package:costes/users/shoppingCart.dart';
import 'package:costes/users/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'kakaowebview.dart';

void main() => runApp(DetailMenu());

/// This Widget is the main application widget.
class DetailMenu extends StatelessWidget {
  static String title = 'Flutter Code Sample';
  // 차가운거 따듯한거?
  static String hotice ='';

  // 가격에 관한 변수들
  static int money;
  static int sizeMoney = 0;
  static int shotMoney = 0;
  static String shot = ''; // 몇 샷 인지 추가 되면 가격 +500원씩
  static String size = ''; // 사이즈도 추가


  // 메뉴 이름에 딸려들어갈 것들에 관한 변수들
  static String string_shot = '';
  static String string_size = '';

  // 유저가 원하는거
  static String userwant ='';

  // 사진
  static String url = '';

  // 수량
  static int number = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(          // Add the 3 lines from here... 
         primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
       ),
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () { 
              Navigator.of(context).pop();
              userinfo.getCoupon();
              DetailMenu.number = 1;
              DetailMenu.sizeMoney = 0;
              DetailMenu.string_shot = '';
            },
          ),
        ),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}
// 핫 아이스
enum HotIce { ice, hot }
HotIce hotORice = HotIce.ice;

// 샷추가
enum Shot { defalut, oneshot, twoshot }
Shot shot = Shot.defalut;

// 사이즈 선택
enum SizeChoice { defalut, onesize, twosize}
SizeChoice sizeChoice = SizeChoice.defalut;

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget top = new Container(
      //width: 250.0,
      height: 250.0,
      // child: CircleAvatar(
      //     backgroundImage: NetworkImage('${DetailMenu.url}'),
      //     minRadius: 100,
      //     maxRadius: 200,
      //   ),
      child : FadeInImage.assetNetwork(placeholder: "asset/loading.gif", image: DetailMenu.url ),
    );

    Widget hotice = Center(
      child: Column(
        children: <Widget>[
          Text('HOT & ICE',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          ListTile(
            title: const Text('ice',
            style: TextStyle(
              //fontSize: 30,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),),
            leading: Radio(
              value: HotIce.ice,
              groupValue: hotORice,
              onChanged: (HotIce value) {
                setState(() {
                  hotORice = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('hot',
            style: TextStyle(
              //fontSize: 30,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),),
            leading: Radio(
              value: HotIce.hot,
              groupValue: hotORice,
              onChanged: (HotIce value) {
                setState(() {
                  hotORice = value;
                });
              },
            ),
          ),

        ],
      ),
    );
    Widget line = new Divider(
                color: Colors.black,
                height: 15.0,
              );
int getMoney(){
      setState(() {
        if (hotORice.toString() == "HotIce.hot"){
          DetailMenu.hotice = '핫';
        }
        else if (hotORice.toString() == "HotIce.ice") {
          DetailMenu.hotice = '아이스';
        }
        // M 사이즈라면
        if (sizeChoice.toString() == "SizeChoice.onesize"){
          DetailMenu.sizeMoney = 500;
          DetailMenu.string_size = 'M';
        }
        // L 사이즈라면
        else if (sizeChoice.toString() == "SizeChoice.twosize"){
          DetailMenu.sizeMoney = 1000;
          DetailMenu.string_size = 'L';
        }
        else {
          DetailMenu.sizeMoney = 0;
          DetailMenu.string_size = 'S';
        }
        // 원샷
        if(shot.toString() == 'Shot.oneshot'){
          DetailMenu.shotMoney = 500;
          DetailMenu.string_shot = '샷 1개 추가';
        }
        else if(shot.toString() == 'Shot.twoshot'){
          DetailMenu.shotMoney = 1000;
          DetailMenu.string_shot = '샷 2개 추가';
        }
        else {
          DetailMenu.shotMoney = 0;
          DetailMenu.string_shot = '';
        }
        
        });
        int hi = (DetailMenu.money + DetailMenu.shotMoney + DetailMenu.sizeMoney) * DetailMenu.number;
        return hi;
    }
    // 샷 위젯  
    Widget shotwg = Center(
      child: Column(
        children: <Widget>[
          Text('SHOT',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),),
          
          ListTile(
            title: const Text('기본 샷'),
            leading: Radio(
              value: Shot.defalut,
              groupValue: shot,
              onChanged: (Shot value) {
                setState(() {
                  shot = value;
                });
                getMoney();
              },
            ),
          ),
          ListTile(
            title: const Text('샷 추가'),
            leading: Radio(
              value: Shot.oneshot,
              groupValue: shot,
              onChanged: (Shot value) {
                setState(() {
                  shot = value;
                });
                getMoney();
              },
            ),
          ),
          ListTile(
            title: const Text('투샷 추가'),
            leading: Radio(
              value: Shot.twoshot,
              groupValue: shot,
              onChanged: (Shot value) {
                setState(() {
                  shot = value;
                });
                getMoney();
              },
            ),
          ),
        ],
      ),
    );
    // 사이즈 위젯
    Widget sizewg = Center(
      child: Column(
        children: <Widget>[
          Text('SIZE',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),),
          
          ListTile(
            title: const Text('기본(S) 사이즈'),
            leading: Radio(
              value: SizeChoice.defalut,
              groupValue: sizeChoice,
              onChanged: (SizeChoice value) {
                setState(() {
                  sizeChoice = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('미디움(M) 사이즈'),
            leading: Radio(
              value: SizeChoice.onesize,
              groupValue: sizeChoice,
              onChanged: (SizeChoice value) {
                setState(() {
                  sizeChoice = value;
                  getMoney();
                });
              },
            ),
          ),
          ListTile(
            title: const Text('라지(L) 사이즈'),
            leading: Radio(
              value: SizeChoice.twosize,
              groupValue: sizeChoice,
              onChanged: (SizeChoice value) {
                setState(() {
                  sizeChoice = value;
                  getMoney();
                });
              },
            ),
          ),
        ],
      ),
    );
    void add() {
      setState(() {
        DetailMenu.number++;
        getMoney();
      });
    }
    void minus() {
      setState(() {
        if (DetailMenu.number != 1) 
          DetailMenu.number--;
          getMoney();
        });
    }
    
    Widget number = Container(
      child: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new FloatingActionButton(
              onPressed: minus,
              heroTag: 'minus',
              child: 
              new Icon(Icons.exposure_neg_1, color: Colors.black),
              backgroundColor: Colors.white),


            new Text('${DetailMenu.number}',
                style: new TextStyle(fontSize: 40.0)),

            
            new FloatingActionButton(
              heroTag: 'plus',
              onPressed: add,
              child: new Icon(
                Icons.exposure_plus_1, color: Colors.black,),
                backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
    Widget price = Container(
      child: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text('${getMoney()}',
                style: new TextStyle(fontSize: 40.0)),
          ],
        ),
      ),
    );

    TextEditingController usercontoroller = new TextEditingController();
    Widget usersay = Container(
      
      child: new TextField(
        cursorColor: Colors.black,
        controller: usercontoroller,
        decoration: InputDecoration(
        fillColor: Colors.black,
        /*hintText: "id",*/
        labelText: '요청사항을 말씀해주세요'),
      ),
    );
    void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
    Widget orderORplus = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // 장바구니 담는 버튼
        new RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
          child: Column(
                      children: <Widget>[
                      Icon(Icons.add_shopping_cart),
                      Text("장바구니 담기"),
                      ],
                    ),
            padding: const EdgeInsets.all(8.0),
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                    // 버튼 눌렀을 때 액션
                    onPressed: () async {
                      // 돈 측정
                      //print(Shot.)
                      // 사이즈 부터
                      if (hotORice.toString() == "HotIce.hot"){
                        DetailMenu.hotice = '핫';
                      }
                      else if (hotORice.toString() == "HotIce.ice") {
                        DetailMenu.hotice = '아이스';
                      }
                      // M 사이즈라면
                      if (sizeChoice.toString() == "SizeChoice.onesize"){
                        DetailMenu.sizeMoney = 500;
                        DetailMenu.string_size = 'M';
                      }
                      // L 사지으라면
                      else if (sizeChoice.toString() == "SizeChoice.twosize"){
                        DetailMenu.sizeMoney = 1000;
                        DetailMenu.string_size = 'L';
                      }
                      else {
                        DetailMenu.sizeMoney = 0;
                        DetailMenu.string_size = 'S';
                      }
                      // 원샷
                      print(shot.toString() == 'Shot.defalut');
                      if(shot.toString() == 'Shot.oneshot'){
                        DetailMenu.shotMoney = 500;
                        DetailMenu.string_shot = '샷 1개 추가';
                      }
                      else if(shot.toString() == 'Shot.twoshot'){
                        DetailMenu.shotMoney = 1000;
                        DetailMenu.string_shot = '샷 2개 추가';
                      }
                      else {
                        DetailMenu.shotMoney = 0;
                        DetailMenu.string_shot = '';
                      }
                      DetailMenu.userwant = usercontoroller.text;
                      
                      // 디테일 메뉴로 메뉴 이름과 + 
                      // "(${DetailMenu.hotice})" + " " + DetailMenu.string_size + " " + DetailMenu.string_shot + " ${usercontoroller.text}"
                      String order =  "${DetailMenu.hotice} " + DetailMenu.title + " " + DetailMenu.string_size + " " + DetailMenu.string_shot + " ${DetailMenu.number}잔 ${usercontoroller.text}";
                      ShoppingCart.setShoppingCart(userinfo.userName, order, (DetailMenu.money + DetailMenu.shotMoney + DetailMenu.sizeMoney) * DetailMenu.number, DetailMenu.number);
                      print("디테일 뷰 ");
                      // 다시 초기화
                      DetailMenu.number = 1;
                      DetailMenu.sizeMoney = 0;
                      DetailMenu.string_shot = '';
                      showToast('장바구니에 담겼습니다.');
                      //runApp(Menuview());
                      
                    },
                    
          ),
          // 주문하기 버튼
        new RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
            padding: const EdgeInsets.all(8.0),
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                    // 눌렀을때 액션
                    onPressed: () async {

                      // 돈 측정
                      //print(Shot.)
                      // 사이즈 부터
                      if (hotORice.toString() == "HotIce.hot"){
                        DetailMenu.hotice = '핫';
                      }
                      else if (hotORice.toString() == "HotIce.ice") {
                        DetailMenu.hotice = '아이스';
                      }
                      // M 사이즈라면
                      if (sizeChoice.toString() == "SizeChoice.onesize"){
                        DetailMenu.sizeMoney = 500;
                        DetailMenu.string_size = 'M';
                      }
                      // L 사이즈라면
                      else if (sizeChoice.toString() == "SizeChoice.twosize"){
                        DetailMenu.sizeMoney = 1000;
                        DetailMenu.string_size = 'L';
                      }
                      else {
                        DetailMenu.sizeMoney = 0;
                        DetailMenu.string_size = 'S';
                      }
                      // 원샷
                      print(shot.toString() == 'Shot.defalut');
                      if(shot.toString() == 'Shot.oneshot'){
                        DetailMenu.shotMoney = 500;
                        DetailMenu.string_shot = '샷 1개 추가';
                      }
                      else if(shot.toString() == 'Shot.twoshot'){
                        DetailMenu.shotMoney = 1000;
                        DetailMenu.string_shot = '샷 2개 추가';
                      }
                      else {
                        DetailMenu.shotMoney = 0;
                        DetailMenu.string_shot = '';
                      }
                      DetailMenu.userwant = usercontoroller.text;
                      print(sizeChoice.toString());
                      // 돈 측정

                      Navigator.push(context,
                          MaterialPageRoute<void>(builder: (BuildContext context) {
                              return ConfirmOrder();
                          })
                      );

                      // // 패킷 보내는 곳
                      // HttpClient client2 = new HttpClient();
                      // client2.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
                      // String url2 ='https://cafecostes.com/flutter/serverStatus';
                      // //Map map2 = null;
                      // HttpClientRequest request2 = await client2.postUrl(Uri.parse(url2));
                      // request2.headers.set('content-type', 'application/json');
                      // //request2.add(utf8.encode(json.encode(map2)));
                      // HttpClientResponse response2 = await request2.close();
                      // String reply2 = await response2.transform(utf8.decoder).join();

                      // if(reply2 == "true"){
                      //   HttpClient client = new HttpClient();
                      //   client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
                      //   //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
                      //   String url ='https://cafecostes.com/flutter/kakaoPay2';
                      //   // item_name 에는 음료에 대한 샷 추가 사이즈 업이나 요청사항등이 같이 실려갈 것임
                      //   Map map = { "partner_user_id" : "${userinfo.userName}" , "item_name" : DetailMenu.title + "(${DetailMenu.hotice})" + " " + DetailMenu.string_size + " " + DetailMenu.string_shot + " ${DetailMenu.number}잔 ${usercontoroller.text}", "total_amount" : (DetailMenu.money + DetailMenu.shotMoney + DetailMenu.sizeMoney) * DetailMenu.number};
                      //   //String map2 = "{'id' : '${titleControler.text}', 'password' : '${bodyControler.text}'";
                      //   HttpClientRequest request = await client.postUrl(Uri.parse(url));
                      //   request.headers.set('content-type', 'application/json');
                      //   request.add(utf8.encode(json.encode(map)));
                      //   HttpClientResponse response = await request.close();
                      //   String reply = await response.transform(utf8.decoder).join();
                      //   print(reply);

                      //   // 패킷 가져옴

                      //   // 그결과를 밑에서 다듬어줌
                      //   var hepp = reply;
                      //   String jsoned = jsonEncode(hepp);
                      //   final body = json.decode(hepp);
                      //   if (Platform.isAndroid) {
                      //     // Android-specific code
                      //     Kakao.app_scheme = body['android_app_scheme'];
                      //   } else if (Platform.isIOS) {
                      //     // iOS-specific code
                      //     Kakao.app_scheme = body['ios_app_scheme'];
                      //   }
                      //   Kakao.redirect_url = body['next_redirect_pc_url'];
                      //   print("리다이렉트 : " + Kakao.redirect_url);
                      //   print(Kakao.app_scheme);
                      //   //_launchURL(Kakao.app_scheme);
                      //   if(Platform.isIOS){
                      //     Kakao.iOS_redirect_url = body['next_redirect_app_url'];
                      //     _launchURL(Kakao.iOS_redirect_url);
                      //   }
                      //   else if (Platform.isAndroid){
                      //     Kakao.android_redirect_url = body['next_redirect_mobile_url'];
                      //     _launchURL(Kakao.android_redirect_url);
                      //     //Navigator.pop(context);
                      //     // Navigator.push(context,
                      //     //     MaterialPageRoute<void>(builder: (BuildContext context) {
                      //     //         return WikipediaExplorer();
                      //     //     })
                      //     // );
                      //   }
                      //   // 다시 초기화
                      //   DetailMenu.number = 1;
                      //   DetailMenu.sizeMoney = 0;
                      //   DetailMenu.string_shot = '';
                      //   //Navigator.pop(context);
                      //   // Navigator.push(context,
                      //   //       MaterialPageRoute<void>(builder: (BuildContext context) {
                      //   //           return WikipediaExplorer();
                      //   //       })
                      //   //   );
                      // }
                      // else {
                      //   showToast(reply2);
                      //   return ;
                      // } 
                    },
                    child: Column(
                      children: <Widget>[
                      Icon(Icons.payment),
                      Text("주문하기"),
                      ],
                    ),
        ),
      ],
      );
      
    // 샷추가 및 사이즈도 선택해야함 그리고 선택함에따라 가격도반영되어야 함
    return Scaffold(
      // floatingActionButton : FloatingActionButton(
      //   onPressed: (){
      //     print('objescts');
      //     //ShoppingView();
      //      Navigator.push(context,
      //                       MaterialPageRoute<void>(builder: (BuildContext context) {
      //                           return ShoppingView();
      //                       })
      //                   );
      //   },
      //   child: Icon(Icons.shopping_cart),
      //   ),
      body: ListView(
          children: <Widget>[
            top,
            line,
            hotice,
            line,
            shotwg,
            line,
            sizewg,
            line,
            number,
            line,
            usersay,
            line,
            price,
            line,
            orderORplus,
            Container(height: 15,),
          ],
      ),
    );
  }
}
_bookmarkButton() {
    return FutureBuilder<WebViewController>(
      //future: _controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            onPressed: () async {
              var url = await controller.data.currentUrl();
              //_favorites.add(url);
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Saved $url for later reading.')),
              );
            },
            child: Icon(Icons.favorite),
          );
        }
        return Container();
      },
    );
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