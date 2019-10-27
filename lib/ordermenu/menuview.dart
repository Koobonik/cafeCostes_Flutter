import 'package:costes/ordermenu/menuwidget.dart';
import 'package:costes/users/orderlist.dart';
import 'package:costes/users/shoppingCart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'getmenu.dart';
class Menuview extends StatefulWidget{
  @override
  _HomeScreen createState() => new _HomeScreen();
}

class _HomeScreen extends State<Menuview>{
  
  @override
  Widget build(BuildContext context) {  
    Widget menubar = Container(
          color: Colors.black54,
          //margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            // 카테고리 길이만큼 생성
            children: List.generate(Getmenu.category.length, (index) => GestureDetector(
              onTap: (){
                  print(Getmenu.category.elementAt(index) + "클릭");
                  Menuwidget.userChoice = Getmenu.category.elementAt(index);
                  Menuwidget.int_userChoice = index;
                  Navigator.pop(context);
                  Navigator.push(context,
                            MaterialPageRoute<void>(builder: (BuildContext context) {
                                return Menuview();
                            })
                        );
                },
                  child: new Container(
                  width: 160.0,
                  color: const Color.fromRGBO(238, 232, 198, 1.0),
                  child: Center(
                    // 카테고리명 들어가는 부분
                    child: Text(Getmenu.category.elementAt(index),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        
    return MaterialApp(
      title: '메뉴',
      theme: new ThemeData(          // Add the 3 lines from here... 
         primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
       ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('메뉴'),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () { 
              GetMyPayment.getMyPayment();
              Navigator.of(context).pop();
            },
          ), 
        ),
        body: ListView(
          children: <Widget>[
            menubar,
            Menuwidget()
          ],
        ),
      ),
    );
  }
  
  }