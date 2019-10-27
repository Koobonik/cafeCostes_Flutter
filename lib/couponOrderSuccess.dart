import 'package:costes/ordermenu/detailmenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:costes/users/userinfo.dart';

class CouponOrderSuccess extends StatefulWidget {
  static var date = List();
  static var itemname = List();
  static var money = List();
  @override
  CouponOrderSuccessState createState() => CouponOrderSuccessState();
}

class CouponOrderSuccessState extends State<CouponOrderSuccess> {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "쿠폰 주문 성공",
      theme: ThemeData(
        //primaryColor: Colors.brown,
        primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(238, 232, 198, 1.0),
          title: const Text('쿠폰 주문 성공',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              print("쿠폰 주문 성공 뷰 나가기");
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[ 
          
            new IconButton(
              icon: const Icon(Icons.refresh),
              color: Colors.black,
              onPressed: () {
          }),
          // 장바구니에 닮겨있는것들 주문하기
        ],      
      ),
      // 바디
      body:
      Container(
        color: const Color.fromRGBO(238, 232, 198, 1.0),
        child: ListView(
            padding: const EdgeInsets.all(10),
            
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("\n쿠폰 주문이 성공적으로 완료 되었습니다!\n",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                  Text("${userinfo.ordersuccess}\n",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  //매장 상황에 따라 소요시간이 5~10분이\n더 소요될 수 있습니다.
                  Text("매장 상황에 따라 소요시간이 5~10분이\n더 소요될 수 있습니다.\n",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                  ),),
                  
                  
                  // Icon(Icons.arrow_downward,color: Colors.purple,),
                  Image(image: AssetImage("asset/무지.png"),
                  height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Icon(Icons.arrow_upward,color: Colors.purple,),
                    Icon(Icons.arrow_upward,color: Colors.purple,),
                    Icon(Icons.arrow_upward,color: Colors.purple,)
                  ],),
                  Text("쿠폰 사용 하여 기분 좋은 무지",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),),
                  Text("(돈다발 아님, 쿠폰임)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),),
                  
                ],
            ),
            ],
            // child: Column(
            //   children: List.generate(i, (index) => Text(
            //     " ${Orderlist.date[index]} ${Orderlist.itemname[index]} ${Orderlist.money[index]}원\n"
            //   ),
            //   ),
            // ),
          ),
      )
      //  Center(
      //     child: ListView(
      //       padding: const EdgeInsets.all(10),
            
      //       children: <Widget>[
      //         Column(
      //           children: <Widget>[
      //             Text("쿠폰 주문이 성공적으로 완료 되었습니다!\n",
      //             style: TextStyle(
      //               fontSize: 20
      //             ),),
      //             Text("${userinfo.ordersuccess}"),
      //             Image(image: AssetImage("asset/무지.png"),
      //             height: 300,
                  
      //             ),
                  
      //           ],
      //       ),
      //       ],
      //       // child: Column(
      //       //   children: List.generate(i, (index) => Text(
      //       //     " ${Orderlist.date[index]} ${Orderlist.itemname[index]} ${Orderlist.money[index]}원\n"
      //       //   ),
      //       //   ),
      //       // ),
      //     ),
      // ),
    ),
    );
  }
}