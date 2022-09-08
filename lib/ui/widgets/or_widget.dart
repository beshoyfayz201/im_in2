import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OrWidegt extends StatelessWidget {
  final String txt1, txt2;
  final Function navigateTo;

  const OrWidegt(
      {Key? key,
      required this.txt1,
      required this.txt2,
      required this.navigateTo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: txt1,
            style: TextStyle(fontSize: 17, color: Colors.grey.shade700)),
        TextSpan(
            text: " " + txt2,
            recognizer: TapGestureRecognizer()
              ..onTap = (() {
                navigateTo();
              }),
            style: TextStyle(fontSize: 17, color: Colors.black)),
      ])),
    );
  }
}
