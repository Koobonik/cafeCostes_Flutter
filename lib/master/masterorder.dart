import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:costes/users/orderlist.dart';
import 'package:costes/users/shoppingCart.dart';
import 'package:costes/users/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toast/toast.dart';

class MasterGetMyPayment {
  static void getMyPayment() async {

    MasterOrderlist.itemname = List();
    MasterOrderlist.orderId = List();
  
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
    String url ='https://cafecostes.com/flutter/getOrderList';
    Map map = { "id" : "${userinfo.id}" , "password" : "${userinfo.password}" };
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    if ( reply == "" || reply == null ) {
      print("주문내역이 없음");
      
    }
    else {
      print("있음");
      // Timer.periodic(Duration(seconds: 5), (timer) {
      // print(DateTime.now());
      // });
      
    }
    // 그결과를 밑에서 다듬어줌
    var hepp = reply;
    var body = json.decode(hepp);
    var i = 0;
    // 
    while(true){
      try {
        if(body[i]['orderMesage'] != null){
          MasterOrderlist.itemname.add(body[i]['orderMesage']);
          MasterOrderlist.orderId.add(body[i]['id']);
        }
        // MasterOrderlist.itemname.add(body[i]['item_name']);
        // MasterOrderlist.date.add(body[i]['approved_at'].toString().substring(0, 10) + " " + body[i]['approved_at'].toString().substring(11, 13)+"시 " + body[i]['approved_at'].toString().substring(14, 16)+"분");
        // MasterOrderlist.money.add(body[i]['money']);
        // MasterOrderlist.name.add(body[i]['partner_user_id']);
  
        i++;
      } catch (e){
        print(e);

        break;
      }
    }
    // 오더리스트 관리하자
    

  }
  // static void d (BuildContext context) async {
  //   await MasterGetMyPayment.getMyPayment();
  //   Navigator.pop(context);
  //   Navigator.push(context,
  //     MaterialPageRoute<void>(builder: (BuildContext context) {
  //         return MasterOrderlist();
  //     })
  //   );
  // }
}

void main(){
  runApp(new MaterialApp(home: MasterOrderlist(),));
}

class MasterOrderlist extends StatefulWidget {
  static var orderId = List();
  static var itemname = List();
  @override
  MasterOrderlistViewState createState() => MasterOrderlistViewState();
}

class MasterOrderlistViewState extends State<MasterOrderlist> {

    // Method 1
  Future _showNotificationWithSound() async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      sound: 'slow_spring_board',
      importance: Importance.Max,
      priority: Priority.High);
  var iOSPlatformChannelSpecifics =
      new IOSNotificationDetails(sound: "slow_spring_board.aiff");
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    '새로운 주문이 들어왔습니다.',
    '확인해주세요.',
    platformChannelSpecifics,
    payload: 'Custom_Sound',
  );
}
// Method 2
Future _showNotificationWithDefaultSound() async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'New Post',
    'How to Show Notification in Flutter',
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}
// Method 3
Future _showNotificationWithoutSound() async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      playSound: false, importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics =
      new IOSNotificationDetails(presentSound: false);
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'New Post',
    'How to Show Notification in Flutter',
    platformChannelSpecifics,
    payload: 'No_Sound',
  );
}

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project   
     // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon'); 
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onSelectNotification: onSelectNotification);
  }
  
  Future onSelectNotification(String payload) async {
    Navigator.pop(context);
    Navigator.push(context,
      MaterialPageRoute<void>(builder: (BuildContext context) {
          return MasterOrderlist();
      })
    );
    // showDialog(
    //   context: context,
    //   builder: (_) {
    //     return new AlertDialog(
    //       title: Text("PayLoad"),
    //       content: Text("Payload : $payload"),
    //     );
    //   },
    // );
  }

  int i = MasterOrderlist.itemname.length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(238, 232, 198, 1.0),
        title: const Text('코스테스 주문 내역',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[   
               // Add 3 lines from here... // 네비게이션바임 아이콘버튼 만들고 액션 넣을 수 있음
               new IconButton(
              icon: const Icon(Icons.refresh),
              color: Colors.black,
              onPressed: () {
                //Timer timer = new Timer(Duration(seconds: 20), null);
                Timer.periodic(Duration(seconds: 20), (timer) {
                print("계속반복중");
                print("널이 아니므로 로컬푸시");
                String asd = "";
                try {
                  asd = MasterOrderlist.itemname[0];
                } catch (e) {
                
                }
                
                print(asd );
                MasterGetMyPayment.getMyPayment();
                
                if(asd != null && asd != ""){
                  print(asd);
                  print("들엉ㅁ");
                  _showNotificationWithSound();
                  
                }
          
                });
                getData(context);
                
                 
              }
              
            ),
            new IconButton(
              icon: const Icon(Icons.payment),
              color: Colors.black,
              onPressed: (){
                //showToast("사장님 이기능은 아직입니다~");
                Navigator.push(context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
                return Orderlist();
      })
    );
                //ShoppingCart.resetShoppingCart(userinfo.userName);
              }
            ),
             
          // 장바구니에 닮겨있는것들 주문하기
          ],
      ),
      // 바디
      body: 
      ListView.builder(
          itemCount: MasterOrderlist.itemname.length,
          itemBuilder: (context, index) {
            var item = MasterOrderlist.itemname[index];
            print(item);
            List<String> hi = item.toString().split(" - ");
            String date = hi[0];
            String list = hi[1];
            String money = hi[2];
            String name = hi[3];

            List<String> list2 = list.toString().split(" , ");
            if(list2.length > 1){
              list = "";
              print("길이가 1이 넘네");
              print(list2.length);
              for(int i = 0; i< list2.length; i++){
                if(i == list2.length -1){
                  list += "${list2[i]}";
                }
                else {
                  list += "${list2[i]}\n";
                }
              }
            }
            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.

              // 삭제하는 부분
              onDismissed: (direction) async {
                // Remove the item from the data source.
                HttpClient client = new HttpClient();
                client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
                //String url ='https://cafecostes.com/flutter/login?id=' + titleControler.text + "&password=" + bodyControler.text;
                String url ='https://cafecostes.com/flutter/deleteOrderList';
                Map map = { "id" : "${userinfo.id}" , "password" : "${userinfo.password}", "firebaseToken" : "${MasterOrderlist.orderId.elementAt(index)}" };
                HttpClientRequest request = await client.postUrl(Uri.parse(url));
                request.headers.set('content-type', 'application/json');
                request.add(utf8.encode(json.encode(map)));
                HttpClientResponse response = await request.close();
                String reply = await response.transform(utf8.decoder).join();
                print(reply);
                //
                MasterGetMyPayment.getMyPayment();
                setState(() {
                  
                  MasterOrderlist.itemname.removeAt(index);
                  MasterOrderlist.orderId.removeAt(index);

                  
                });

                // Then show a snackbar.

                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("$item 제거됨.")));
              },
              // Show a red background as the item is swiped away.
              background: Container(
                alignment: Alignment.center,
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
              

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // ListTile(title: Text('$date',
                  //   style: TextStyle(
                  //   fontWeight: FontWeight.bold,
                  //   fontSize: 15,
                  //   color: Colors.black,
                  //   ),
                  // ),),
                  
                  Text('$date',
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                    ),
                  ),
                  Text('$list',
                     style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  Text('금액 : $money',
                     style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  Text('주문자 : $name\n',
                     style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  new Divider(),
              ],
              ),
              
            //   child: ListTile(
            //     title: Text('$item',
            //    style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 25,
            //     color: Colors.black,
            //   ),
            // ),
            // ),
              // child : Column(children: <Widget>[
                
              // ],)
            );
          },
        ),
      
    );
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
  
}
Future<String> getData(BuildContext context) async {
  MasterGetMyPayment.getMyPayment();
  await Future.delayed(Duration(seconds: 1)); // 5초간 대기
  print("Fetched Data");
  Navigator.pop(context);
    Navigator.push(context,
      MaterialPageRoute<void>(builder: (BuildContext context) {
          return MasterOrderlist();
      })
    );
  return "10초 기다렸다가 온 데이터입니다";
}

Future<String> getDataAndWait() async {
  MasterGetMyPayment.getMyPayment();
  await Future.delayed(Duration(seconds: 1)); // 1초간 대기
  return "good";
}
void noti() {
    
  
  
  // print("noti() 실행됨");
  // Future.delayed(const Duration(seconds: 3), () {
  //   if(MasterOrderlist.itemname == null){
  //     print("noti() 중지됨");
      
  //     return;
  //   }
  //   sleep(Duration(seconds: 5));
  //   print("noti() 실행중에있음");

  //   MasterGetMyPayment.getMyPayment();
  // });


  
}