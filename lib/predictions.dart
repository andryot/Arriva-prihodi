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

Color colorArrival = Colors.black;
Color colorDeparture = Colors.black;
TextEditingController departureTextController = TextEditingController();

//textField za departure
class _InputFormDepartureState extends State<InputFormDeparture> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  void newDeparture(String newD) {
    departureTextController.text = newD;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Container(
        height: pixelsVertical > 1750
            ? height *
                (height > 600 ? 0.028 : 0.024) *
                MediaQuery.of(context).devicePixelRatio
            : height * (pixelsVertical > 900 ? 0.042 : 0.05) * MediaQuery.of(context).devicePixelRatio,
        //height: height > 650 ? height * 0.027 * MediaQuery.of(context).devicePixelRatio : height * 0.042 * MediaQuery.of(context).devicePixelRatio,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(17.0),
          border: Border.all(),
        ),
        child: Center(
          child: TypeAheadFormField(
            key: ValueKey("odhod"),
            suggestionsBoxController: suggestionDestinationController,
            textFieldConfiguration: TextFieldConfiguration(
              onChanged: (text) {
                if (this._formKey.currentState.validate())
                  this._formKey.currentState.save();
              },
              onTap: () {
                //this.suggestionDestinationController.toggle();
                if (this._formKey.currentState.validate())
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
                    departureTextController.clear();
                    departure = "";
                  },
                ),
                hintText: hintDepartures,
                hintStyle: TextStyle(color: hintColor),
                filled: false,
              ),
              style: TextStyle(
                  fontSize: height < 750 ? 18 : 20, color: Colors.black),
              controller: departureTextController,
            ),
            suggestionsCallback: (pattern) {
              return CitiesService.getSuggestions(pattern);
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                offsetX: -1,
                constraints: BoxConstraints(minWidth: width * 0.935),
                borderRadius: BorderRadius.circular(20),
                elevation: 1),
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
              departureTextController.text = suggestion;
              if (this._formKey.currentState.validate()) {
                this._formKey.currentState.save();
              }
            },
            validator: (value) {
              if (!predictions.contains(value)) {
                hintDepartures = "Izberi postajo iz seznama";
                hintColor = Colors.black;
                errorDeparture = true;
              } else
                errorDeparture = false;
            },
            onSaved: (value) {
              departure = value;
              routesDeparture = value;
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

final TextEditingController destinationTextController = TextEditingController();

//textField za arrival
class InputFormArrival extends StatefulWidget {
  @override
  _InputFormArrivalState createState() => _InputFormArrivalState();
}

class _InputFormArrivalState extends State<InputFormArrival> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        //height: height > 650 ? height * 0.027 * MediaQuery.of(context).devicePixelRatio : height * 0.042 * MediaQuery.of(context).devicePixelRatio,
        height: pixelsVertical > 1750
            ? height *
                (height > 600 ? 0.028 : 0.024) *
                MediaQuery.of(context).devicePixelRatio
            : height * (pixelsVertical > 900 ? 0.042 : 0.05) * MediaQuery.of(context).devicePixelRatio,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(17.0),
          border: Border.all(),
        ),
        child: Center(
          child: TypeAheadFormField(
            key: ValueKey("prihod"),
            suggestionsBoxController: suggestionArrivalController,
            textFieldConfiguration: TextFieldConfiguration(
              onChanged: (text) {
                this._formKey.currentState.validate();
                this._formKey.currentState.save();
              },
              onTap: () {
                //this.suggestionArrivalController.toggle();
                if (this._formKey.currentState.validate())
                  this._formKey.currentState.save();
              },
              focusNode: myFocusNode,
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
                    destinationTextController.clear();
                    destination = "";
                  },
                ),
                border: InputBorder.none,
                hintText: hintArrivals,
                hintStyle: TextStyle(color: hintColorA),
                filled: false,
              ),
              style: TextStyle(
                  fontSize: height < 750 ? 18 : 20, color: Colors.black),
              controller: destinationTextController,
            ),
            suggestionsCallback: (pattern) {
              return CitiesService.getSuggestions(pattern);
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                offsetX: -1,
                constraints: BoxConstraints(minWidth: width * 0.935),
                borderRadius: BorderRadius.circular(17),
                elevation: 1),
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
              destinationTextController.text = suggestion;
              if (this._formKey.currentState.validate()) {
                this._formKey.currentState.save();
              } else
                errorArrival = true;
            },
            validator: (value) {
              if (!predictions.contains(value)) {
                hintArrivals = "Izberi postajo iz seznama";
                hintColorA = Colors.black;
                errorArrival = true;
              } else
                errorArrival = false;
            },
            onSaved: (value) {
              destination = value;
              routesDestination = value;
            },
          ),
        ),
      ),
    );
  }
}
