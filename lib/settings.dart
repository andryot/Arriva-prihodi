import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
class SettingsPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<SettingsPage>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff000000)),
      drawer: Drawer(child: Container(
          color: Color(0xff171B1B),
          child: ListView(
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(30),
              child: 
              Text('Arriva prihodi', style: TextStyle(color: Colors.white, fontSize: 25,),),
              decoration: BoxDecoration(border: Border.all(width: 2.0, color: Colors.white)),
            ),
            ListTile(
              title: Text('Iskalnik voznih redov', style: TextStyle(color: Colors.white),),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
              },
            ),
            ListTile(
              title: Text('Nastavitve', style: TextStyle(color: Colors.white),),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
                
              },
            ),
            
          ],),
          ),),
      backgroundColor: Colors.black26,
      body: Center(child: Text("12355666", style: TextStyle(color: Colors.white),),
    ));
  }
}