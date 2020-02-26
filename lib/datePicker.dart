import 'package:flutter/material.dart';


class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}


class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  DateTime _date = DateTime.now();

  final _controller = TextEditingController();

  void initState() {
    _controller.addListener(() {
      if (_controller.text == null) {
      final DateTime picked =  showDatePicker(context: context, initialDate: _date, firstDate: DateTime(1970), lastDate: DateTime(2100)) as DateTime;
      
      setState(() {
        _date = picked;
        _controller.dispose();
      });
      }
      print(_date);
    });
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return TextFormField(   
          controller: _controller,
          decoration: InputDecoration(border: OutlineInputBorder(),
          labelText: "Datum",),
    );
  }
}