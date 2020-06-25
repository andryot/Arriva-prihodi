import 'package:bus_time_table/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class InputFormDeparture extends StatefulWidget {
  @override
  _InputFormDepartureState createState() => _InputFormDepartureState();
}

String hintDepartures = "Vstopna postaja";
Color hintColor = Colors.black;
String hintArrivals = "Izstopna postaja";
Color hintColorA = Colors.black;
bool errorArrival = false;
bool errorDeparture = false;

Color colorArrival = Colors.black;
Color colorDeparture = Colors.black;

//textField za departure
class _InputFormDepartureState extends State<InputFormDeparture> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  FocusNode myFocusNode;
  final SuggestionsBoxController suggestionDestinationController =
      SuggestionsBoxController();
  //final TextEditingController _departuresController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(17.0),
          border: Border.all(),
        ),
        child: Center(
          child: TypeAheadFormField(
            suggestionsBoxController: suggestionDestinationController,
            textFieldConfiguration: TextFieldConfiguration(
              //textInputAction: TextInputAction.next,
              onChanged: (text) {
                if(this._formKey.currentState.validate())
                  this._formKey.currentState.save();
              },
              onTap: () {
                this.suggestionDestinationController.toggle();
                if(this._formKey.currentState.validate())
                  this._formKey.currentState.save();
              },
              focusNode: myFocusNode,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: new Icon(
                  Icons.directions_bus,
                  color: Colors.black,
                  size: 30,
                ),
                
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    _typeAheadController.clear();
                  },
                ),
                hintText: hintDepartures,
                hintStyle: TextStyle(color: hintColor),
                filled: false,
              ),
              
              style: TextStyle(fontSize: 20, color: Colors.black),
              controller: this._typeAheadController,
            ),
            suggestionsCallback: (pattern) {
              return CitiesService.getSuggestions(pattern);
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                borderRadius: BorderRadius.circular(20), elevation: 0),
            noItemsFoundBuilder: (BuildContext context) => Text(
              '\n   Neveljaven vnos!\n',
              style: TextStyle(color: Colors.red),
            ),
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
              this._typeAheadController.text = suggestion;
              if (this._formKey.currentState.validate()) {
                this._formKey.currentState.save();
              }
            },
            validator: (value) {
              if (!predictions.contains(value)) {
                //this._typeAheadController.clear();
                //myFocusNode..unfocus();
                hintDepartures = "Izberi postajo iz seznama";
                hintColor = Colors.black;
                errorDeparture=true;
              }
              else errorDeparture=false;
            },
            onSaved: (value) {
              departure = value;
              routesDeparture = value;
              //errorDeparture=false;
            },
          ),
        ),
      ),
    );
  }
}

class CitiesService {
  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.clear();

    matches.addAll(predictions);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));

    return matches;
  }
}










//textField za arrival
class InputFormArrival extends StatefulWidget {
  @override
  _InputFormArrivalState createState() => _InputFormArrivalState();
}

class _InputFormArrivalState extends State<InputFormArrival> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  
  FocusNode myFocusNode;
  final SuggestionsBoxController suggestionArrivalController =
      SuggestionsBoxController();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        padding: EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(17.0),
          border: Border.all(),
        ),
        child: Center(
          child: TypeAheadFormField(
            suggestionsBoxController: suggestionArrivalController,
            textFieldConfiguration: TextFieldConfiguration(
              onChanged: (text) {
                this._formKey.currentState.validate();
              },
              onTap: () {
                this.suggestionArrivalController.toggle();
              },
              //onSubmitted: (str) => (print(str)),
              focusNode: myFocusNode,
              //decoration: InputDecoration(labelText: 'Vstopna postaja'),
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.directions_bus,
                  color: Colors.black,
                  size: 30,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    _typeAheadController.clear();
                  },
                ),
                border: InputBorder.none,
                hintText: hintArrivals,
                hintStyle: TextStyle(color: hintColorA),
                filled: false,
              ),
              style: TextStyle(fontSize: 20, color: Colors.black),
              controller: this._typeAheadController,
            ),
            suggestionsCallback: (pattern) {
              return CitiesService.getSuggestions(pattern);
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                borderRadius: BorderRadius.circular(20), elevation: 0),
            noItemsFoundBuilder: (BuildContext context) => Text(
              '\n   Neveljaven vnos!\n',
              style: TextStyle(color: Colors.red),
            ),
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            //hideSuggestionsOnKeyboardHide: true,
            onSuggestionSelected: (suggestion) {
              this._typeAheadController.text = suggestion;
              if (this._formKey.currentState.validate()) {
                this._formKey.currentState.save();
              }
              else
                errorArrival=true;
            },
            validator: (value) {
              if (!predictions.contains(value)) {
                //this._typeAheadController.clear();
                hintArrivals = "Izberi postajo iz seznama";
                hintColorA = Colors.red;
                errorArrival=true;

              }
              else errorArrival=false;
            },
            onSaved: (value) {
              destination = value;
              routesDestination = value;
              errorArrival=false;
            },
          ),
        ),
      ),
    );
  }
}
