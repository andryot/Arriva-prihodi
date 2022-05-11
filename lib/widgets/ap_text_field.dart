import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class APTextField extends StatelessWidget {
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextStyle? textStyle;
  final bool readOnly;
  final TextEditingController? controller;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  const APTextField({
    Key? key,
    this.placeholder,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.textStyle,
    this.readOnly = false,
    this.controller,
    this.onTap,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: new BorderRadius.circular(25.0),
        border: Border.all(color: Theme.of(context).highlightColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15),
        child: TextField(
          readOnly: readOnly,
          controller: controller,
          style: TextStyle(color: Theme.of(context).primaryColor),
          textAlignVertical: TextAlignVertical.center,
          onChanged: (text) {},
          onTap: onTap,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: "Datum",
            labelStyle: TextStyle(
              color: Theme.of(context).highlightColor,
            ),
          ),
        ),
      ),
    );
  }
}
