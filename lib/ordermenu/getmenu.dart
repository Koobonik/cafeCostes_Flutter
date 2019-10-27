import 'dart:convert';
import 'dart:io';

import 'dart:math';

class Getmenu {
  static var category = Set(); // 카테고리만 담아줄 변수
  static String reply; // json 으로 응답받아 날라오는 결과 받아주는 변수
  static List menu; // 메뉴들 이제 json으로 디코드 해줌
  static int listMenu0 = 0;// 에스프레소
  static int listMenu1 = 0; // 에이드&스무디
  static int listMenu2 = 0; // 라떼
  static int listMenu3 = 0; // 과일&허브티
  static int listMenu4 = 0; // 쉐이크
  static int listMenu5 = 0; // 
  //static int listMenu6 = 0; // 여름시그니처
  static var menuName0 = List();
  static var menuName1 = List();
  static var menuName2 = List();
  static var menuName3 = List();
  static var menuName4 = List();
  static var menuName5 = List();
  //static var menuName6 = List();
  //static List<List<String>> hi;
  static void remove(){
    category = Set(); // 카테고리만 담아줄 변수 // 메뉴들 이제 json으로 디코드 해줌
    listMenu0 = 0;
    listMenu1 = 0; // 에스프레소
    listMenu2 = 0; // 에이드&스무디
    listMenu3 = 0; // 라떼
    listMenu4 = 0; // 과일&허브티
    listMenu5 = 0; // 쉐이크
    //listMenu6 = 0; // 여름시그니처
    menuName0 = List();
    menuName1 = List();
    menuName2 = List();
    menuName3 = List();
    menuName4 = List();
    menuName5 = List();
    //menuName6 = Set();
  }

// 각 카테고리에 담겨있는 메뉴의 길이 반환
  static getListMenuLength() async {
    // 여기다가 카테고리 받아줘야함
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='https://cafecostes.com/flutter/getListMenuLength';
    //Map map = { "id" : "nuasdll" , "password" : "nusdfll", "firebaseToken" : "hosf"};
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    List hi = reply.split(",");
    int i = 0;
    while(true){
      print("우하하");
      print(hi[i]);
      i++;
      if(i > 5){
        break;
      }
    }
    listMenu0 = int.parse(hi[0]);
    listMenu1 = int.parse(hi[1]);
    listMenu2 = int.parse(hi[2]);
    listMenu3 = int.parse(hi[3]);
    listMenu4 = int.parse(hi[4]);
    listMenu5 = int.parse(hi[5]);
  }

  // 에스프레소 받아오기 
  static getListEss() async {
    // 여기다가 카테고리 받아줘야함
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='https://cafecostes.com/flutter/getListEss';
    //Map map = { "id" : "nuasdll" , "password" : "nusdfll", "firebaseToken" : "hosf"};
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    List hi = reply.split(",");
    print("여기를 보자");
    print(hi);
    Getmenu.menuName0.addAll(hi);
  }

  static getListAde() async {
    // 여기다가 카테고리 받아줘야함
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='https://cafecostes.com/flutter/getListAde';
    //Map map = { "id" : "nuasdll" , "password" : "nusdfll", "firebaseToken" : "hosf"};
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    List hi = reply.split(",");
    Getmenu.menuName1.addAll(hi);
    print("에이드는 말이야 ${hi}");
  }

  static getListLatte() async {
    // 여기다가 카테고리 받아줘야함
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='https://cafecostes.com/flutter/getListLatte';
    //Map map = { "id" : "nuasdll" , "password" : "nusdfll", "firebaseToken" : "hosf"};
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    List hi = reply.split(",");
    Getmenu.menuName2.addAll(hi);
    print("라떼는 말이야${hi}");
  }

  static getListHub() async {
    // 여기다가 카테고리 받아줘야함
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='https://cafecostes.com/flutter/getListHub';
    //Map map = { "id" : "nuasdll" , "password" : "nusdfll", "firebaseToken" : "hosf"};
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    List hi = reply.split(",");
    Getmenu.menuName3.addAll(hi);
    print("허브는 말이야 ${hi}");
  }

  static getListShake() async {
    // 여기다가 카테고리 받아줘야함
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='https://cafecostes.com/flutter/getListShake';
    //Map map = { "id" : "nuasdll" , "password" : "nusdfll", "firebaseToken" : "hosf"};
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    List hi = reply.split(",");
    Getmenu.menuName4.addAll(hi);
    print("쉐이크는 말이야 ${hi}");
  }

  static getListSummer() async {
    // 여기다가 카테고리 받아줘야함
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='https://cafecostes.com/flutter/getListSummer';
    //Map map = { "id" : "nuasdll" , "password" : "nusdfll", "firebaseToken" : "hosf"};
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    List hi = reply.split(",");
    Getmenu.menuName5.addAll(hi);
    print("섬머는 말이야 ${hi}");
  }

  static getMenu() async {
    // 여기다가 카테고리 받아줘야함
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url ='https://cafecostes.com/request/getAllMenu';
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    HttpClientResponse response = await request.close();
    Getmenu.reply = await response.transform(utf8.decoder).join();
    Getmenu.menu = json.decode(reply);
    print(Getmenu.menu[0]['menuName']);
    print(Getmenu.menu.length);
    
    for (int i = 0; i < menu.length; i++){
      // 중복 카테고리 없음
      Getmenu.category.add(menu[i]['category']);
    }
    //Getmenu.menuName6.addAll(menu);
    //print("asdasd ${Getmenu.menuName6}");
    //Getmenu.listMenu0++;
    // for (int i = 0; i< menu.length; i++){
    //   // 첫번째 요소 같다면 +
    //   if(Getmenu.menu[i]['category'] == Getmenu.category.elementAt(0)){
    //     //Getmenu.listMenu0++;
    //     //print(Getmenu.menu[i]['menuName']);
    //     print("들어오긴하지만 아무것도 안함");
    //     //Getmenu.menuName0.add(Getmenu.menu[i]['menuName']);
    //   }
    //   else if(Getmenu.menu[i]['category'] == Getmenu.category.elementAt(1)){
    //     //Getmenu.listMenu1++;
    //     Getmenu.menuName1.add(Getmenu.menu[i]['menuName']);
    //   }
    //   else if(Getmenu.menu[i]['category'] == Getmenu.category.elementAt(2)){
    //     //Getmenu.listMenu2++;
    //     Getmenu.menuName2.add(Getmenu.menu[i]['menuName']);
    //   }
    //   else if(Getmenu.menu[i]['category'] == Getmenu.category.elementAt(3)){
    //     //Getmenu.listMenu3++;
    //     Getmenu.menuName3.add(Getmenu.menu[i]['menuName']);
    //   }
    //   else if(Getmenu.menu[i]['category'] == Getmenu.category.elementAt(4)){
    //     //Getmenu.listMenu4++;
    //     Getmenu.menuName4.add(Getmenu.menu[i]['menuName']);
    //   }
    //   else if(Getmenu.menu[i]['category'] == Getmenu.category.elementAt(5)){
    //     print("여기 들어오나 잘");
    //     //Getmenu.listMenu5++;
    //     Getmenu.menuName5.add(Getmenu.menu[i]['menuName']);
    //   }

      // 여기 밑에는 안들어옴
      // else if(Getmenu.menu[i]['category'] == Getmenu.category.elementAt(6)){
      //   print("여기 들어오나"+ Getmenu.menu[i]['category']);
      //   //Getmenu.listMenu6++;
      //   Getmenu.menuName6.add(Getmenu.menu[i]['menuName']);
      // }
      
      
    //}
  }
}