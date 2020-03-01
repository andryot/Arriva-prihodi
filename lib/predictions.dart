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

class _InputFormDepartureState extends State<InputFormDeparture> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  FocusNode myFocusNode;
  final SuggestionsBoxController suggestionDestinationController =
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(17.0),
        ),
        child: TypeAheadFormField(
          suggestionsBoxController: suggestionDestinationController,
          textFieldConfiguration: TextFieldConfiguration(
            //textInputAction: TextInputAction.next,

            onChanged: (text) {
              this._formKey.currentState.validate();
            },
            onTap: () {
              this.suggestionDestinationController.toggle();
              this._formKey.currentState.save();
            },
            onSubmitted: (str) => (print(str)),
            focusNode: myFocusNode,
            //decoration: InputDecoration(labelText: 'Vstopna postaja'),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintDepartures,
              hintStyle: TextStyle(color: hintColor),
              filled: true,
            ),
            style: TextStyle(),
            controller: this._typeAheadController,
          ),
          suggestionsCallback: (pattern) {
            return CitiesService.getSuggestions(pattern);
          },
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: BorderRadius.circular(20), elevation: 0),
          
          noItemsFoundBuilder: (BuildContext context) => Text(
            '   Neveljaven vnos!',
            style: TextStyle(color: Colors.red),
          ),
          itemBuilder: (context, suggestion) {
            //if()
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
            if (value.isEmpty) {
              //this._typeAheadController.clear();
              //myFocusNode..unfocus();
              hintDepartures = "Prosim izberi postajo iz seznama";
              hintColor = Colors.red;
              //return "Prosim izberi postajo iz seznama";
            }
          },
          onSaved: (value) => departure = value,
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(17.0),
        ),
        child: Container(
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
                border: InputBorder.none,
                hintText: hintArrivals,
                hintStyle: TextStyle(color: hintColorA),
                filled: true,
              ),
              style: TextStyle(),
              controller: this._typeAheadController,
            ),
            suggestionsCallback: (pattern) {
              return CitiesService.getSuggestions(pattern);
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                borderRadius: BorderRadius.circular(20), elevation: 0),
            noItemsFoundBuilder: (BuildContext context) => Text(
              '   Neveljaven vnos!',
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
            },
            validator: (value) {
              if (value.isEmpty) {
                //this._typeAheadController.clear();

                hintArrivals = "Prosim izberi postajo iz seznama";
                hintColorA = Colors.red;
                //return "Prosim izberi postajo iz seznama";
              }
            },
            onSaved: (value) => destination = value,
          ),
        ),
      ),
    );
  }
  
}
