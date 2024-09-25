import 'package:flutter/material.dart';

import '../style/theme.dart';

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
  final String? labelText;
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
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: Theme.of(context).highlightColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15),
        child: TextField(
          readOnly: readOnly,
          controller: controller,
          style: textStyle ?? TextStyle(color: Theme.of(context).primaryColor),
          textAlignVertical: TextAlignVertical.center,
          onChanged: (text) {},
          onTap: onTap,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,
            labelStyle: TextStyle(
              color: myColors.labelColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
