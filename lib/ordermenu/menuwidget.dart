import 'package:costes/ordermenu/detailmenu.dart';
import 'package:costes/ordermenu/getmenu.dart';
import 'package:costes/users/orderlist.dart';
import 'package:flutter/material.dart';

class Menuwidget extends StatefulWidget {
  // 유저가 선택하면 그 선택에 맞게 뷰를 보여줄 것임
  static String userChoice = null;
  static int int_userChoice = 0;

  @override
  Menuoutout createState() => new Menuoutout();
  
}
class Menuoutout extends State<Menuwidget>{
  
  @override
  Widget build(BuildContext context) { 

    Widget menubar;
    if (Menuwidget.userChoice == null){
      GetMyPayment.getMyPayment();
        print("처음임");
        print('${Getmenu.category.length}');
        int i = Getmenu.listMenu0;
        var menuName = Set();
        menuName.addAll(Getmenu.menuName0);
        menubar = Center(
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: List.generate(i, (index) => RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                padding: const EdgeInsets.only(left: 50, right: 50, bottom: 10, top: 10),
                textColor: Colors.white,
                child: Text("${menuName.elementAt(index)}"),
                color: Colors.brown,
                onPressed: () {
                  print(menuName.elementAt(index));
                  DetailMenu.title = menuName.elementAt(index);
                  // 메뉴의 타이틀이 정해지면 그 타이틀에 맞는 가격 반환
                  for(int i = 0; 0 < Getmenu.menu.length; i++){
                    print('포문 들어오나');
                    //print(Getmenu.menu[i]['menuName']);
                    //print(DetailMenu.title);
                    if(Getmenu.menu[i]['menuName'] == DetailMenu.title){
                      DetailMenu.money = Getmenu.menu[i]['menuCost'];
                      DetailMenu.url = Getmenu.menu[i]['url'];
                      if (Getmenu.menu[i]['url'] == null){
                        print("이미지 없음");
                        DetailMenu.url = 'https://i.imgur.com/wlWHYN6.jpg';
                      }
                      print("메뉴 가격 : ${DetailMenu.money}");
                      break;
                    }
                  }
                  Navigator.push(context,
                            MaterialPageRoute<void>(builder: (BuildContext context) {
                                return DetailMenu();
                            })
                        );
                },
        )
        
        ),
            ),
            ),
        );
        return menubar;
      }
      else if (Menuwidget.userChoice == Getmenu.category.lookup(Menuwidget.userChoice)) {
        GetMyPayment.getMyPayment();
        print("있다!");
        print('${Getmenu.category.length}');
        int i = 0;
        var menuName = Set();
        
        // 카테고리별 메뉴 개수 구함
        if (Menuwidget.int_userChoice == 0){
          i = Getmenu.listMenu0;
          menuName.addAll(Getmenu.menuName0);
        }
        else if (Menuwidget.int_userChoice == 1){
          i = Getmenu.listMenu1;
          menuName.addAll(Getmenu.menuName1);
        }
        else if (Menuwidget.int_userChoice == 2){
          i = Getmenu.listMenu2;
          menuName.addAll(Getmenu.menuName2);
        }
        else if (Menuwidget.int_userChoice == 3){
          i = Getmenu.listMenu3;
          menuName.addAll(Getmenu.menuName3);
        }
        else if (Menuwidget.int_userChoice == 4){
          i = Getmenu.listMenu4;
          menuName.addAll(Getmenu.menuName4);
        }
        else if (Menuwidget.int_userChoice == 5){
          i = Getmenu.listMenu5;
          menuName.addAll(Getmenu.menuName5);
        }
        // else if (Menuwidget.int_userChoice == 6){
        //   i = Getmenu.listMenu6;
        //   menuName.addAll(Getmenu.menuName6);
        // }
        //List<String> j = Getmenu.category.lookup(Getmenu.category.elementAt(Menuwidget.int_userChoice));
        menubar = Center(
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: List.generate(i, (index) => RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                padding: const EdgeInsets.only(left: 50, right: 50, bottom: 10, top: 10),
                textColor: Colors.white,
                child: Text("${menuName.elementAt(index)}"),
                color: Colors.brown,
                onPressed: () {
                  DetailMenu.title = menuName.elementAt(index);
                  // 메뉴의 타이틀이 정해지면 그 타이틀에 맞는 가격 반환
                  for(int i = 0; 0 < Getmenu.menu.length; i++){
                    print('포문 들어오나');
                    print(Getmenu.menu[i]['menuName']);
                    print(DetailMenu.title);
                    if(Getmenu.menu[i]['menuName'] == DetailMenu.title){
                      DetailMenu.money = Getmenu.menu[i]['menuCost'];
                      DetailMenu.url = Getmenu.menu[i]['url'];
                      print("메뉴 가격 : ${DetailMenu.money}");
                      break;
                    }
                  }
                  Navigator.push(context,
                            MaterialPageRoute<void>(builder: (BuildContext context) {
                               return DetailMenu();
                            })
                        );
                },
        )
        
        ),
            ),
            ),
        );
        return menubar;


    
      }
    
    
    
  }
}

class EssWidget extends StatefulWidget {
  @override
  Essoutout createState() => new Essoutout();
  
}
class Essoutout extends State<EssWidget>{
  
  @override
  Widget build(BuildContext context) {  
    Widget menubar;
    if (true) {
      menubar = Container(
        child: Text('asasdasdd'),
      );
    }
    return menubar;
  }
}