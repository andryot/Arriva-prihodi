import 'package:flutter/material.dart';

import 'ap_text_field.dart';

class APDateField extends StatelessWidget {
  final DateTime initialDate;
  final TextEditingController _textEditingController;
  final Function()? onTap;
  const APDateField({
    required this.initialDate,
    required TextEditingController textEditingController,
    required this.onTap,
  }) : _textEditingController = textEditingController;

  @override
  Widget build(BuildContext context) {
    return APTextField(
      readOnly: true,
      controller: _textEditingController,
      onTap: onTap,
      textStyle: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 18,
      ),
      labelText: "Datum",
    );
  }
}
