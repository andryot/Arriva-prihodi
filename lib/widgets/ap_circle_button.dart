import 'package:flutter/material.dart';

class APCircleButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  final Color? iconColor;
  final double? size;
  final double? elevation;
  final Color? color;
  const APCircleButton({
    Key? key,
    this.onPressed,
    required this.icon,
    this.iconColor,
    this.size,
    this.elevation,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Theme.of(context).backgroundColor.withOpacity(.8),
      elevation: elevation ?? 5.0,
      clipBehavior: Clip.antiAlias,
      type: MaterialType.circle,
      color: color ?? Theme.of(context).primaryColor,
      child: IconButton(
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black54
            : Colors.white38,
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
