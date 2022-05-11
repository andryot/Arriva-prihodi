import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class APDateField extends StatelessWidget {
  DateTime? date;
  APDateField({required this.date});
  final format = DateFormat("dd.MM.yyyy");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
        child: Stack(
          children: [
            Icon(
              Icons.date_range,
              size: 30,
              color: Colors.black,
            ),
            Positioned(
              left: 35,
              bottom: 0,
              top: 0,
              child: DateTimeField(
                resetIcon: null,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(17)),
                  fillColor: Colors.white,
                  filled: true,
                ),
                style: TextStyle(fontSize: 18, color: Colors.black),
                format: format,
                initialValue: date,
                onChanged: (DateTime? dat) => date = dat,
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
            ),
          ],
        ),
      ),
    );
  }
}
