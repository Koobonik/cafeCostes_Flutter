import 'dart:io';
import 'dart:math';

import 'package:costes/agree.dart';
import 'package:costes/couponOrderSuccess.dart';
import 'package:costes/developers.dart';
import 'package:costes/find_OR_change.dart';
import 'package:costes/firebaseController.dart';
import 'package:costes/hi.dart';
import 'package:costes/main.dart';
import 'package:costes/master/masterorder.dart';
import 'package:costes/users/coupon.dart';
import 'package:costes/users/shoppingCart.dart';
import 'package:costes/users/userinfo.dart';
import 'package:costes/ordermenu/listmenuview.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:costes/users/orderlist.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toast/toast.dart';
import 'package:costes/firebaseController.dart';
import 'ordermenu/menuview.dart';

// 코스테스 쿠폰북

void main() async {
    // debugPaintSizeEnabled = true;
  print("메인 실행");
  runApp(Costesmainview());
}
void loginview(){
  userinfo.remove();
  runApp(MyApp());
}

class Costesmainview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (userinfo.userName == "master" || userinfo.userPermission >= 6){
      print("master 이므로 MasterGetMyPayment 실행");
      MasterGetMyPayment.getMyPayment();
    }
    else {
      GetMyPayment.getMyPayment();
      userinfo.getCoupon();
    }
    
    return new MaterialApp(
      home: HomeScreen()
    );
  }
    
    
}
class HomeScreen extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {   
    void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  } 
  final Size size = MediaQuery.of(context).size;
    Widget titleSection = Container(
      
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Icon(Icons.music_note),
                    Text(
                    // 사장님의 한마디 라인
                    '  ${userinfo.onesay}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ],), 
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Text(
                  //     '${userinfo.userName} 님!',
                  //     style: TextStyle(
                  //       fontSize: 40,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                    // Text(
                    //   '님!',
                    //   style: TextStyle(
                    //     fontSize: 30,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // 여기 지워야함
                children: <Widget>[
                  // Text(
                  //     '보유 쿠폰 개수',
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // Text(
                  //     '${userinfo.userCoupon}개',
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                ],
                    ),
                    
                ],
                ),
              //   new Divider(
              //   color: Colors.black,
              //   height: 5.0,
              // ),
              ],
            ),
          ),
        ],
      ),
    );
    Widget buttonSection = Container( // 첫째줄
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
            // padding: const EdgeInsets.all(60.0),
            padding: const EdgeInsets.only(left: 60, right: 60, bottom: 80, top: 80),
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.local_cafe),
                        Text("Order"),
                      ],
                    ),
                    onPressed: (){
                      Navigator.push(context,
                            MaterialPageRoute<void>(builder: (BuildContext context) {
                              print("주문하기 버튼 클릭");
                                return MyHomePage3();
                            })
                        );
                    },
          ),
          
          new RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
            padding: const EdgeInsets.only(left: 60, right: 60, bottom: 80, top: 80),
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                    onPressed: (){
                      showToast("준비중입니다.");
                    },
                    child: Column(
                      children: <Widget>[
                      Icon(Icons.calendar_today),
                      Text("Calendar"),
                      ],
                    ),
          ),
        ],
      ),
    );

    Widget buttonSection2 = Container(
      //padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 25, top: 25),
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                    onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context){
                        return ShoppingView();
                        })
                      );
                    },
                    child: Column(
                      children: <Widget>[
                      Icon(Icons.shopping_cart),
                      Text("Cart"),
                      ],
                    ),
          ),
          
          new RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 25, top: 25),
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                    onPressed: () {
                      if (userinfo.userName == "master" || userinfo.userPermission >= 6 ){
                        Navigator.push(context,
                            MaterialPageRoute<void>(builder: (BuildContext context) {
                              print("master 주문 내역 클릭");
                                return MasterOrderlist();
                            })
                        );
                      }
                      else{
                        Navigator.push(context,
                            MaterialPageRoute<void>(builder: (BuildContext context) {
                              print("주문 내역 클릭");
                              //GetMyPayment.getMyPayment();
                              return Orderlist();
                            })
                        );
                      }
                    },
                    child: Column(
                      children: <Widget>[
                      Icon(Icons.format_list_numbered),
                      Text("Payment"),
                      ],
                    ),
          ),

          new RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 25, top: 25),
                    // textColor: Colors.white,
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                    onPressed: (){
                      showToast("준비중입니다.");

                      // Navigator.push(context,
                      //   MaterialPageRoute<void>(builder: (BuildContext context) {
                      //     userinfo.ordersuccess = userinfo.couponList[0];
                      //     print("쿠폰 주문 성공");
                      //     return CouponOrderSuccess();
                      //   }),
                      // );

                    },
                    child: Column(
                      children: <Widget>[
                      Icon(Icons.cloud),
                      Text("Bread"),
                      ],
                    ),
          ),
        ],
      ),
    );
    Widget couponSection = Card(
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
      //color: ,
      margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () async {
          print('Card tapped.');
          await userinfo.getCoupon();
          Navigator.push(context,
            MaterialPageRoute<void>(builder: (BuildContext context) {
                return CouponView();
            })
          );
        },
        child: Container(
          // 카드 사이즈 늘리고싶으면 여기로
          width: 300,
          height: 150,
          child: Column(
            
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                
                children: <Widget>[
                  Text(' ${userinfo.userName} 님!',
                    style: TextStyle(
                      fontSize: 40,
                        fontWeight: FontWeight.bold,
                        
                        color: Colors.black,
                    ),),
                ],
              ),
              ),
              
              
                    Divider(),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('   coupon',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
                  ],
                )
              ),
               //List.generate(i, (index) => RaisedButton(
              Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(userinfo.userCoupon, (index) => RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                    padding: const EdgeInsets.all(8),
                    child: Icon(Icons.card_giftcard),
                    color: const Color.fromRGBO(238, 232, 198, 1.0),
                    onPressed: () async {
                      print("Coupon tapped. $index");
                      await userinfo.getCoupon();
                      Navigator.push(context,
                        MaterialPageRoute<void>(builder: (BuildContext context) {
                            return CouponView();
                        })
                      );
                      //print(userinfo.couponList.elementAt(index));
                    },
                  )
                  ),
                  ),
                  ),
                  //Icon(Icons.calendar_today),
            ],
          )
        ),
      ),
    );
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        """코스테스 카페에 오신 여러분을 진심으로 환영합니다!""",
        softWrap: true,
      ),
    );

    Widget cafeNumber = Container(
      padding: const EdgeInsets.all(16),
      color: const Color.fromRGBO(238, 232, 198, 1.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              """카페코스테스
대표자 : 이은혜   사업자 등록번호 : 448-50-00361  대표 번호 : 02) 950-5532
01757 서울특별시 노원구 동일로 214길 32 (상계동 205) 밀알관 1층 카페코스테스
E-mail : cafecostes2018@gmail.com  Copyright ⓒ 2019 dev_koo""",
            softWrap: true,
            style: TextStyle(fontSize: 9),
            ),

            // RaisedButton(
            //   padding: const EdgeInsets.all(8.0),
            //   color: Colors.grey,
            //   onPressed: (){
            //     print("환불 규정 클릭");
            //     showToast("규정 준비중입니다");
            //   },
            //   child: Column(
            //     children: <Widget>[
            //     Text("환뷸 규정"),
            //     ],
            //   ),
            // ),
      
          ],),
        
      ),
       
    );

    return MaterialApp(
      initialRoute: "costesMainView",
      title: '카페코스테스',
      theme: new ThemeData(          // Add the 3 lines from here... 
         primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
       ),
      home: Scaffold(
        // 플로팅버튼
        // floatingActionButton : FloatingActionButton(
        // onPressed: (){
        //   //ShoppingView();
        //   Navigator.push(context,
        //   MaterialPageRoute<void>(builder: (BuildContext context){
        //     return ShoppingView();
        //     })
        //   );
        // },
        // child: Icon(Icons.shopping_cart),
        // ),
        appBar: AppBar(
          title: Text('cafe\'  C O S T E S'),
          //Column(children: <Widget>[
            //Text('cafe\'  C O S T E S'),
            // Text('C O S T E S',
            // style: TextStyle(
            //   fontSize: 12,
            //   fontWeight: FontWeight.w400,
            //   //color: color,
            // ),),
          //],),
          centerTitle: true,
        //   actions: <Widget>[      // Add 3 lines from here... // 네비게이션바임 아이콘버튼 만들고 액션 넣을 수 있음
        //   new IconButton(icon: const Icon(Icons.exit_to_app), onPressed: loginview),
        // ],      

        ),
        // 메뉴바
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("카페코스테스"),
                accountEmail: new Text("학우, 원우, 교직원, 교수 모두의 쉼터"),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage('https://i.imgur.com/WmM27UN.png'),
                ),
              ),
              // new ListTile(
              //   title: new Text('개발자 소개'),
              //   onTap: (){
              //     Navigator.push(context,
              //               MaterialPageRoute<void>(builder: (BuildContext context) {
              //                   return Developers();
              //               })
              //           );
              //   },
              // ),
              // new Divider(
              //   color: Colors.black,
              //   height: 5.0,
              // ),
              new ListTile(
                title: new Text('카페 소개'),
                onTap: (){
                  showToast("준비중입니다.");
                  // Navigator.push(context,
                  //           MaterialPageRoute<void>(builder: (BuildContext context) {
                  //               return Developers();
                  //           })
                  //       );
                },
              ),
              new Divider(
                color: Colors.black,
                height: 5.0,
              ),
              new ListTile(
                title: new Text('비밀번호 변경'),
                onTap: (){
                  
                  Navigator.push(context,
                            MaterialPageRoute<void>(builder: (BuildContext context) {
                                return ChangePassword();
                            })
                        );
                },
              ),

              new Divider(
                color: Colors.black,
                height: 5.0,
              ),

              new ListTile(
                title: new Text('이용 약관'),
                onTap: (){
                  
                  Navigator.push(context,
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                        return Agree2();
                    })
                  );
                },
              ),
              new Divider(
                color: Colors.black,
                height: 5.0,
              ),
              
              new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                        color: Colors.black12,
                        onPressed: (){
                          //Getmenu.remove();
                          userinfo.remove();
                          loginview();
                        },
                        child: Column(
                          children: <Widget>[
                          Icon(Icons.delete_outline),
                          Text("로그아웃"),
                          ],
                        ),
          ),
            ],
          ),
        ),
        body: ListView(
          // 뷰들 에드시켜서 올리는 곳
          children: [
            
            titleSection,
            couponSection,
            buttonSection,
            buttonSection2,
            Divider(
              height: 50,
            ),
            //textSection,
            cafeNumber,
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
class Second extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text('두 번째')),
            body: Center(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                    child: Text('처음 화면으로 돌아가기', style: TextStyle(fontSize: 21)),
                    color: Colors.green,
                    onPressed: () {
                        Navigator.pop(context);
                        
                        // 위와 같은 코드
                        // Navigator.of(context).pop();
                    },
                ),
            ),
        );
    }
}
