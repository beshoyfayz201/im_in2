import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final String txt;
  final Color textColor;
  final IconData iconData;
  final Color iconColor;
  final Color background;
  final double size;
  final Function onPressed;
  final EdgeInsetsGeometry padding;

  const IconTextButton({
    required this.txt,
    this.size = 19,
    this.textColor = Colors.black,
    this.iconColor = Colors.greenAccent,
    this.background = Colors.white,
    required this.iconData,
    required this.onPressed,
    this.padding = const EdgeInsets.fromLTRB(0, 5, 20, 5),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
          decoration: BoxDecoration(
              color: background, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                Icon(
                  iconData,
                  size: size,
                  color: iconColor,
                ),
                Text(
                  txt,
                  style: TextStyle(color: textColor),
                )
              ],
            ),
          ),
        ));
  }
}
