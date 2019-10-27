import 'dart:convert';
import 'dart:io';
import 'package:costes/users/userinfo.dart';
import 'package:flutter/material.dart';
class GetMyPayment {
  static void getMyPayment() async {

  Orderlist.date = List();
  Orderlist.itemname = List();
  Orderlist.money = List();

  HttpClient client = new HttpClient();
  client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
  //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
  String url ='https://cafecostes.com/flutter/getMyPayment';
  Map map = { "id" : "${userinfo.id}" , "password" : "${userinfo.password}" };
  HttpClientRequest request = await client.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(map)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  print(reply);
  if ( reply == "" || reply == null ) {
    return;
  }
  // 그결과를 밑에서 다듬어줌
  var hepp = reply;
  String jsoned = jsonEncode(hepp);
  var body = json.decode(hepp);
  var i = 0;
  // 
  while(true){
    try {
      Orderlist.itemname.add(body[i]['item_name']);
      Orderlist.date.add(body[i]['approved_at'].toString().substring(0, 10) + " " + body[i]['approved_at'].toString().substring(11, 13)+"시 " + body[i]['approved_at'].toString().substring(14, 16)+"분");
      Orderlist.money.add(body[i]['money']);
      i++;
    } catch (e){
      print(e);
      break;
    }
  }
}
}

class Orderlist extends StatefulWidget {
  static var date = List();
  static var itemname = List();
  static var money = List();
  @override
  OrderlistViewState createState() => OrderlistViewState();
}

class OrderlistViewState extends State<Orderlist> {
  int i = Orderlist.date.length;
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "나의 주문 내역",
      theme: ThemeData(
        //primaryColor: Colors.brown,
        primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(238, 232, 198, 1.0),
          title: const Text('나의 주문 내역',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () { 
              GetMyPayment.getMyPayment();
              print("주문내역 뷰 나가기");
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[      // Add 3 lines from here... // 네비게이션바임 아이콘버튼 만들고 액션 넣을 수 있음
          
            new IconButton(
              icon: const Icon(Icons.refresh),
              color: Colors.black,
              onPressed: () {
                // setState(() async {
                //   getData(context);
                // });
                getData(context);
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
              children: List.generate(i, (index) => Column(children: <Widget>[
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                  
                //   Text("${Orderlist.date[index]}"),
                //   Text("${Orderlist.itemname[index]}"
                //   ,
                //   style: TextStyle(
                //     fontSize: 25,
                //     fontWeight: FontWeight.bold
                //   ),),
                //   Text("${Orderlist.money[index]}원"),

                // ],),
                Text("${Orderlist.date[index]}",
                style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
              ),
              Text("${Orderlist.itemname[index]}",
                style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
              ),
              Text("${Orderlist.money[index]}원",
                style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
              ),
              new Divider(),
              ],) 
              ),
            ),
            ],
            // child: Column(
            //   children: List.generate(i, (index) => Text(
            //     " ${Orderlist.date[index]} ${Orderlist.itemname[index]} ${Orderlist.money[index]}원\n"
            //   ),
            //   ),
            // ),
          ),
      ),
    ),
    );
  }
}
Future<String> getData(BuildContext context) async {
  await GetMyPayment.getMyPayment();
  // await Future.delayed(Duration(seconds: 1)); // 5초간 대기
  print("Fetched Data");
  Navigator.pop(context);
    Navigator.push(context,
      MaterialPageRoute<void>(builder: (BuildContext context) {
          return Orderlist();
      })
    );
  return "10초 기다렸다가 온 데이터입니다";
}