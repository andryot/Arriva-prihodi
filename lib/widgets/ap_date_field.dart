import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class APDateField extends StatelessWidget {
  DateTime date;
  APDateField({required this.date});
  final format = DateFormat("dd.MM.yyyy");

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double pixelsVertical = height * MediaQuery.of(context).devicePixelRatio;
    return Container(
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
      //height: height > 650 ? height * 0.027 * MediaQuery.of(context).devicePixelRatio : height * 0.042 * MediaQuery.of(context).devicePixelRatio,
      child: DateTimeField(
        resetIcon: Icon(
          Icons.clear,
          color: Colors.black,
          size: 30,
        ),
        /* expands: true, */
        maxLines: 1,
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(17)),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: new Icon(
            Icons.date_range,
            size: 30,
            color: Colors.black,
          ),
        ),
        style: TextStyle(fontSize: height < 750 ? 18 : 20, color: Colors.black),
        format: format,
        initialValue: date,
        onChanged: (DateTime? dat) {
          date = dat!;
        },
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            helpText: "Izberi datum odhoda",
            context: context,
            builder: (BuildContext? context, Widget? child) {
              return Theme(
                data: Theme.of(context!),
                child: child!,
              );
            },
            firstDate: DateTime(2020),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2030),
          );
        },
      ),
    );
  }
}
