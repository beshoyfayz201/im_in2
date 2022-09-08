import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String txt;
  final Function onPressed;
  final Color color;
  final double radius;
  const RoundedButton({
    Key? key,
    required this.txt,
    required this.onPressed,
    this.color = Colors.white,
    this.radius = 25.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(color: Colors.black87))),
        onPressed: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                txt,
                style: TextStyle(color: Colors.black87, fontSize: 17),
              ),
            )
          ],
        ));
  }
}
