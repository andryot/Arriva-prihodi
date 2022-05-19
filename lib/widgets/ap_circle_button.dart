import 'package:flutter/material.dart';

class APCircleButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  final Color? iconColor;
  final double? size;
  final double? elevation;
  const APCircleButton({
    Key? key,
    this.onPressed,
    required this.icon,
    this.iconColor,
    this.size,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.grey,
      elevation: elevation ?? 5.0,
      clipBehavior: Clip.hardEdge,
      type: MaterialType.circle,
      color: Theme.of(context).backgroundColor,
      child: IconButton(
        highlightColor: Colors.grey,
        splashRadius: size != null ? (size! + 4.0) : 24,
        padding: EdgeInsets.zero,
        icon: Icon(
          icon,
          size: size ?? 30,
          color: iconColor,
        ),
        onPressed: onPressed ?? () {},
      ),
    );
  }
}
