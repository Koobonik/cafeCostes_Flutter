import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class KakaoWebview extends StatefulWidget {
  // 유저가 선택하면 그 선택에 맞게 뷰를 보여줄 것임
  static String userChoice = null;
  static int int_userChoice = 0;
  
  @override
  Kakao createState() => new Kakao();
  
}

class Kakao extends State<KakaoWebview> {
  
  static String title = 'web Code Sample';
  static String app_scheme = '';
  static String redirect_url = '';
  static String iOS_redirect_url = '';
  static String android_redirect_url = '';
  @override
  Widget build(BuildContext context) {
    print("웹ㅂ들엉");
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
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),  
        body: WebView(
          initialUrl: redirect_url,
        )
      ),
    );
  }
}
class WikipediaExplorer extends StatefulWidget {
  @override
  _WikipediaExplorerState createState() => _WikipediaExplorerState();
}

class _WikipediaExplorerState extends State<WikipediaExplorer> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<String> _favorites = Set<String>();

  @override
  Widget build(BuildContext context) {
    print("들어옴");
    //getDevice();
    //_launchURL(Kakao.android_redirect_url);
    Completer<WebViewController> _controller = Completer<WebViewController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('카카오페이'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          //NavigationControls(_controller.future),
          //Menu(_controller.future, () => _favorites),
        ],
      ),
      //body: Container(child: Text('asd'),),
      body: WebView(
        initialUrl: 'https://en.wikipedia.org/wiki/Kraken',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController c) {
          _controller.complete(c);
        },
      ),
      floatingActionButton: _bookmarkButton(),
    );
  }

  _bookmarkButton() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            onPressed: () async {
              var url = await controller.data.currentUrl();
              _favorites.add(url);
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
  void getDevice() async{
    
    //DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"

    //IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //print('Running on ${iosInfo.utsname.machine}');
  }
}