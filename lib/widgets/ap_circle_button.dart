import 'package:flutter/material.dart';

class APCircleButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  const APCircleButton({
    Key? key,
    this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: MaterialButton(
        elevation: 10,
        minWidth: 30,
        shape: CircleBorder(),
        color: Theme.of(context).backgroundColor,
        onPressed: onPressed ?? () {},
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          size: 30,
          color: Theme.of(context).highlightColor,
        ),
      ),
    );
  }
}
