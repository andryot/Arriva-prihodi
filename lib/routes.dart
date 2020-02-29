import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'HomePage.dart';


class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var willPopScope = WillPopScope(
    onWillPop: () async => true,
    child: Scaffold(
      backgroundColor: Color(0xff000000),
      appBar: AppBar( 
        backgroundColor: Color(0xff000000),
        title: Text("Urnik med: " + departure + " in " + destination),
      ),
      body: Center(
      child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children:<Widget> [
              Padding(padding: EdgeInsets.all(5)),
              getTextWidgets(departures, arrivals, context),
              RaisedButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/home"));
                  },
                  child: Text('Nazaj'),
                ),
            ]
            ),
    ),
      ),
    )
    );
    return willPopScope;
  }
}

/*
Future<void> pejt_domov(BuildContext context){

  Navigator.popUntil(context, ModalRoute.withName("/home"));
}
*/
Color barva = Color(0xff171B1B);
Widget getTextWidgets(List<String> departure, List<String> arrival, BuildContext context)
  {
    List<Widget> list = new List<Widget>();
    if(list.isNotEmpty)
    {
      list.clear();
    }
    
    for(var i = 0; i < departures.length; i++){

           /*if(i % 2 == 1){
        barva = Color(0xff171B1B);
      }    
      */
        list.add(Center(child: Container(    
          height: 60,
          width: width - width/100 * 13,
          padding: EdgeInsets.all(17),
          decoration: (BoxDecoration(
            color: barva,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.black,
              width: 1  ,
              ),
            )
            ),            
            child:Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[ 
            Text(
              (i+1).toString()+".  Odhod: " + 
              departure[i] + "  -  Prihod: " + arrival[i] + " ", style: TextStyle(
                fontSize: 19,
                color: Colors.white,
                ),
              ),
              new IconButton(
                padding: EdgeInsets.only(left: 0),
                icon: Icon(Icons.info),
                onPressed: () { showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,  
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
                tooltip: "Več informacij",
                alignment: Alignment.center,
                iconSize: 30,
                color: Colors.white,
                ),
                //child: Image(image: AssetImage("assets/logo.png",), 
              ],
              ) 
            ),
             
          )
        );
          list.add(new Container(
            height: 10,
          ));
    }
    return new Wrap(children: list);
  }


class AniRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [      
                const SpinKitCircle(color: Colors.white, size: 80,),
                Padding(padding: EdgeInsets.all(5)),
                Text("Pridobivanje podatkov...", style: TextStyle(color: Colors.white, fontSize: 25),),  
          ],
        ),
      ),
    );
  }
}

class PopupContent extends StatefulWidget {
      final Widget content;
      PopupContent({
        Key key,
        this.content,
      }) : super(key: key);
      _PopupContentState createState() => _PopupContentState();
    }

      class _PopupContentState extends State<PopupContent> {
      @override
      void initState() {
        super.initState();
      }
      @override
      Widget build(BuildContext context) {
        return Container(
          child: Text("123455242"),
        );
      }
        }