import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Developers extends StatefulWidget{
  @override
  _AboutPageStates createState() => new _AboutPageStates();
}
 
class _AboutPageStates extends State<Developers>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'asd',
      theme: new ThemeData(          // Add the 3 lines from here... 
         primaryColor: const Color.fromRGBO(238, 232, 198, 1.0),
       ),
       home: Scaffold(
        appBar: AppBar(
          title: Text('개발자소개'),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ), 
        ),
        body: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("구본익"),
                accountEmail: new Text("kbi960130@bible.ac.kr"),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage('https://avatars2.githubusercontent.com/u/15663052?s=460&v=4'),
                ),
              ),
              new UserAccountsDrawerHeader(
                accountName: new Text("신민철"),
                accountEmail: new Text("????@bible.ac.kr"),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage('https://avatars2.githubusercontent.com/u/15663052?s=460&v=4'),
                ),
              ),
            ],
          ),
      ),
    );
  }

}