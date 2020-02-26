import 'package:flutter/material.dart';
import 'HomePage.dart';


class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff443737),
      appBar: AppBar(
        title: Text("Urnik"),
      ),
      body: Center(
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children:<Widget> [
              Padding(padding: EdgeInsets.all(7)),
              Text("Urnik med izbranima postajama: ", 
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),),
              Padding(padding: EdgeInsets.all(7)),
              getTextWidgets(departures, arrivals),
              RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Nazaj'),
                ),
            ]
            ),
    ),
      ),
    );
  }
}

Widget getTextWidgets(List<String> departure, List<String> arrival)
  {
    List<Widget> list = new List<Widget>();
    if(list.isNotEmpty)
    {
      list.clear();
    }
    //Color barva = Colors.purple;
    for(var i = 0; i < departures.length; i++){
     Color barva = Colors.blueGrey;
      if(i % 2 == 1){
        barva = Colors.blue;
      }    
        list.add(new Container(          
          height: 60,
          width: width,
          decoration: (BoxDecoration(
            color: barva,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.black,
              width: 1,
              ),
            )
            ),            
            child:  Text((i+1).toString()+".  Odhod: " + 
              departure[i] + "  -  Prihod: " + arrival[i] + " ", style: TextStyle(
                color: Colors.white,),
              ),
            ), 
          );
    }

    return new Wrap(children: list);
  }