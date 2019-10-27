import 'package:costes/ordermenu/detailmenu.dart';
import 'package:costes/ordermenu/getmenu.dart';
import 'package:costes/users/orderlist.dart';
import 'package:costes/users/userinfo.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp3());

class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '메뉴',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage3(),
    );
  }
}

class MyHomePage3 extends StatefulWidget {

  @override
  State createState() {
    return MyHomePageState3();
  }
}

class MyHomePageState3 extends State<MyHomePage3> {

  @override
  Widget build(BuildContext context) {

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
              setState(() {
                userinfo.getCoupon(); 
              });
              
            },
          ), 
        ),
      body: ListView(
        children: <Widget>[
          CardEss(),
          CardAde(),
          CardLatte(),
          CardHub(),
          CardShake(),
          CardSummer()
        ],
      ),
    ));
  }
}

const loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class CardEss extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    int i = Getmenu.listMenu0;
    var menuName = Set();
    menuName.addAll(Getmenu.menuName0);
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: false,
        scrollOnCollapse: true,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                  SizedBox(
                  
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    tapHeaderToExpand: true,
                    tapBodyToCollapse: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("${Getmenu.category.elementAt(0)}",
                        style: Theme.of(context).textTheme.body2,
                      )
                    ),
                    //collapsed: Text("", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(i, (index) => ButtonTheme(
                      minWidth: 200.0,
                      height: 20.0,
                      child:RaisedButton(
                        
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
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
        ),)
        ),
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          crossFadePoint: 0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

class CardAde extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    int i = Getmenu.listMenu1;
    var menuName = Set();
    menuName.addAll(Getmenu.menuName1);
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: false,
        scrollOnCollapse: true,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                  SizedBox(
                  
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    tapHeaderToExpand: true,
                    tapBodyToCollapse: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("${Getmenu.category.elementAt(1)}",
                        style: Theme.of(context).textTheme.body2,
                      )
                    ),
                    //collapsed: Text("", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(i, (index) => ButtonTheme(
                      minWidth: 200.0,
                      height: 20.0,
                      child:RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
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
        ),)
        ),
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          crossFadePoint: 0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}


class CardLatte extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    int i = Getmenu.listMenu2;
    var menuName = Set();
    menuName.addAll(Getmenu.menuName2);
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: false,
        scrollOnCollapse: true,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                  SizedBox(
                  
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    tapHeaderToExpand: true,
                    tapBodyToCollapse: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("${Getmenu.category.elementAt(2)}",
                        style: Theme.of(context).textTheme.body2,
                      )
                    ),
                    //collapsed: Text("", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(i, (index) => ButtonTheme(
                      minWidth: 200.0,
                      height: 20.0,
                      child:RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
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
        ),)
        
        ),
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          crossFadePoint: 0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

class CardHub extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    int i = Getmenu.listMenu3;
    var menuName = Set();
    menuName.addAll(Getmenu.menuName3);
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: false,
        scrollOnCollapse: true,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                  SizedBox(
                  
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    tapHeaderToExpand: true,
                    tapBodyToCollapse: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("${Getmenu.category.elementAt(3)}",
                        style: Theme.of(context).textTheme.body2,
                      )
                    ),
                    //collapsed: Text("", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(i, (index) => ButtonTheme(
                      minWidth: 200.0,
                      height: 20.0,
                      child:RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
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
        ),)
        
        ),
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          crossFadePoint: 0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

class CardShake extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    int i = Getmenu.listMenu4;
    var menuName = Set();
    menuName.addAll(Getmenu.menuName4);
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: false,
        scrollOnCollapse: true,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                  SizedBox(
                  
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    tapHeaderToExpand: true,
                    tapBodyToCollapse: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("${Getmenu.category.elementAt(4)}",
                        style: Theme.of(context).textTheme.body2,
                      )
                    ),
                    //collapsed: Text("", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(i, (index) => ButtonTheme(
                      minWidth: 200.0,
                      height: 20.0,
                      child:RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
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
        ),)
        
        ),
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          crossFadePoint: 0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

class CardSummer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    int i = Getmenu.listMenu5;
    var menuName = Set();
    menuName.addAll(Getmenu.menuName5);
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: false,
        scrollOnCollapse: true,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                  SizedBox(
                  
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    tapHeaderToExpand: true,
                    tapBodyToCollapse: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("${Getmenu.category.elementAt(5)}",
                        style: Theme.of(context).textTheme.body2,
                      )
                    ),
                    //collapsed: Text("", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(i, (index) => ButtonTheme(
                      minWidth: 200.0,
                      height: 20.0,
                      child:RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
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
        ),)
        
        ),
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          crossFadePoint: 0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}


class Card2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    buildImg(Color color, double height) {
      return SizedBox(
        height: height,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
        )
      );
    }

    buildCollapsed1() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Expandable",
                  style: Theme.of(context).textTheme.body1,
                ),
              ],
            ),
          ),
        ]
      );
    }

    buildCollapsed2() {
      return buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Expandable",
                  style: Theme.of(context).textTheme.body1,
                ),
                Text("3 Expandable widgets",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ]
      );
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: buildImg(Colors.lightGreenAccent, 100)
              ),
              Expanded(
                child: buildImg(Colors.orange, 100)
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: buildImg(Colors.lightBlue, 100)
              ),
              Expanded(
                child: buildImg(Colors.cyan, 100)
              ),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(loremIpsum, softWrap: true,),
          ],
        ),
      );
    }


    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expandable(
                  collapsed: buildCollapsed1(),
                  expanded: buildExpanded1(),
                ),
                Expandable(
                  collapsed: buildCollapsed2(),
                  expanded: buildExpanded2(),
                ),
                Expandable(
                  collapsed: buildCollapsed3(),
                  expanded: buildExpanded3(),
                ),
                Divider(height: 1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        var controller = ExpandableController.of(context);
                        return FlatButton(
                          child: Text(controller.expanded ? "COLLAPSE": "EXPAND",
                            style: Theme.of(context).textTheme.button.copyWith(
                              color: Colors.deepPurple
                            ),
                          ),
                          onPressed: () {
                            controller.toggle();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}