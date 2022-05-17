import 'package:flutter/material.dart';

class APCircleButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  final Color? iconColor;
  const APCircleButton({
    Key? key,
    this.onPressed,
    required this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.grey,
      elevation: 5.0,
      shape: const CircleBorder(),
      color: Theme.of(context).backgroundColor,
      child: IconButton(
        highlightColor: Colors.grey,
        splashRadius: 24,
        icon: Icon(
          icon,
          size: 30,
          color: iconColor,
        ),
        onPressed: onPressed ?? () {},
      ),
    );
  }
}
