import 'package:bus_time_table/bloc/global/global_bloc.dart';
import 'package:bus_time_table/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

String destination = "";
String departure = "";
List<String> predictions = GlobalBloc.instance.state.stations;
String routesDeparture = "";
String routesDestination = "";
bool errorDeparture = true;
bool errorArrival = true;

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

  FocusNode? myFocusNode;
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
    myFocusNode!.dispose();
    super.dispose();
  }

  void newDeparture(String newD) {
    departureTextController.text = newD;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: new BorderRadius.circular(25.0),
        border: Border.all(color: Theme.of(context).highlightColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15),
        child: TypeAheadFormField(
          loadingBuilder: (context) => Center(
            child: LoadingIndicator(
              dotRadius: 3.24,
              radius: 8,
            ),
          ),
          key: ValueKey("odhod"),
          suggestionsBoxController: suggestionDestinationController,
          textFieldConfiguration: TextFieldConfiguration(
            style: TextStyle(color: Theme.of(context).primaryColor),
            textAlignVertical: TextAlignVertical.center,
            onChanged: (text) {
              /* if (this._formKey.currentState!.validate())
                this._formKey.currentState!.save(); */
            },
            onTap: () {
              /* if (this._formKey.currentState!.validate())
                this._formKey.currentState!.save(); */
            },
            focusNode: myFocusNode,
            decoration: InputDecoration(
              border: InputBorder.none,
              /* prefixIcon: Icon(
                Icons.directions_bus,
                color: Theme.of(context).primaryColor,
              ), */
              /* suffixIcon: CupertinoButton(
                child: Icon(
                  Icons.clear,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  departureTextController.clear();
                  departure = "";
                },
              ), */
              labelText: hintDepartures,
              labelStyle: TextStyle(
                color: Theme.of(context).shadowColor,
              ),
            ),
            controller: departureTextController,
          ),
          suggestionsCallback: (pattern) {
            return getSuggestions(pattern);
          },
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          noItemsFoundBuilder: (BuildContext context) => Text(
            '\n   Neveljaven vnos!\n',
            style: TextStyle(color: Colors.red),
          ),
          itemBuilder: (context, suggestion) {
            return ListTile(
              selectedTileColor: Theme.of(context).shadowColor,
              title: Text(suggestion.toString()),
            );
          },
          onSuggestionSelected: (suggestion) {
            departureTextController.text = suggestion.toString();
            /* if (this._formKey.currentState!.validate()) {
              this._formKey.currentState!.save();
            } */
          },
          /*  validator: (value) {
            if (!predictions.contains(value)) {
              hintDepartures = "Izberi postajo iz seznama";
              hintColor = Colors.black;
              errorDeparture = true;
            } else
              errorDeparture = false;
            return "";
          }, */
          onSaved: (value) {
            departure = value!;
            routesDeparture = value;
          },
        ),
      ),
    );
  }
}

List<String> getSuggestions(String query) {
  final List<String> matches = [];

  matches.addAll(predictions);

  matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));

  return matches;
}

final TextEditingController destinationTextController = TextEditingController();

//textField za arrival
class InputFormArrival extends StatefulWidget {
  @override
  _InputFormArrivalState createState() => _InputFormArrivalState();
}

class _InputFormArrivalState extends State<InputFormArrival> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode? myFocusNode;
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
    myFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double pixelsVertical =
        height * MediaQuery.of(context).devicePixelRatio;
    return Form(
      key: this._formKey,
      child: Container(
        //height: height > 650 ? height * 0.027 * MediaQuery.of(context).devicePixelRatio : height * 0.042 * MediaQuery.of(context).devicePixelRatio,
        height: pixelsVertical > 1750
            ? height *
                (height > 600
                    ? pixelsVertical > 2500
                        ? 0.022
                        : 0.028
                    : 0.024) *
                MediaQuery.of(context).devicePixelRatio
            : height *
                (pixelsVertical > 900 ? 0.042 : 0.05) *
                MediaQuery.of(context).devicePixelRatio,
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
                this._formKey.currentState!.validate();
                this._formKey.currentState!.save();
              },
              onTap: () {
                //this.suggestionArrivalController.toggle();
                if (this._formKey.currentState!.validate())
                  this._formKey.currentState!.save();
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
              return getSuggestions(pattern);
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
                title: Text(suggestion.toString()),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
              destinationTextController.text = suggestion.toString();
              if (this._formKey.currentState!.validate()) {
                this._formKey.currentState!.save();
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

              return "";
            },
            onSaved: (value) {
              destination = value!;
              routesDestination = value;
            },
          ),
        ),
      ),
    );
  }
}
