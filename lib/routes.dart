
import 'package:auto_size_text/auto_size_text.dart';
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
        
        title: AutoSizeText("Urnik med: " + departure + " in " + destination,maxLines: 1, style: TextStyle(color: Colors.white, fontSize: 25),),
      ),
      body: Center(
      child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children:<Widget> [
              Padding(padding: EdgeInsets.all(5)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text("Odhod", style: TextStyle(color: Colors.white),), Text("Prihod", style: TextStyle(color: Colors.white),)],),
              getTextWidgets(departures, arrivals, context),
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
Color barva = Color(0xff404040);
Widget getTextWidgets(List<String> departure, List<String> arrival, BuildContext context)
  {
    List<Widget> list = new List<Widget>();
    if(list.isNotEmpty)
    {
      list.clear();
    }
    if (departures.length == 0){
      list.add(Padding(padding: EdgeInsets.all(10)));
      list.add(Center(child: Text("Med izbranima postajama ni povezav", style: TextStyle(color: Colors.red, fontSize: 35,), textAlign: TextAlign.center,),),);
      return new Wrap(children: list);
    }
    else {
    for(var i = 0; i < departures.length; i++){

           /*if(i % 2 == 1){
        barva = Color(0xff171B1B);
      }    „
      */
        list.add(Center(child: Container(    
          height: 60,
          width: width - width/100 * 9,
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
             //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[ 
                Container(width: (width - width/100 * 15) - (width - width/100 * 13) * 0.30,
                  child: AutoSizeText(
             (i+1).toString()+".   " + (i < 9 ? "  ": "")+
              departure[i] + "  -->  " + arrival[i], maxLines: 1, minFontSize: 23,style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                ),
              ),),
                
               IconButton(
                padding: EdgeInsets.only(left:0),
                icon: Icon(Icons.info),
                
                onPressed: () { showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    backgroundColor: barva,
                    content: Container(
                      width: width - width*0.25,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,  
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text("Odhod: " + departure[i], style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text("Prihod: " + arrival[i], style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text("Čas: " + travelTime[i], style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text("Razdalja: " + kilometers[i], style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text("Cena: " + price[i], style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text("Prevoznik: " + busCompany[i], style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text("Peron: " + lane[i], style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
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
