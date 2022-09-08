import 'package:flutter/material.dart';

class LTitle extends StatelessWidget {
  final String txt;
  const LTitle({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style:
          Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),
    );
  }
}

class SubTitle extends StatelessWidget {
  final color;
  final double size;
  final String txt;
  const SubTitle(
      {Key? key,
      required this.txt,
      this.size = 20,
      this.color = const Color.fromRGBO(97, 97, 97, 1)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(color: color, fontSize: size),
    );
  }
}

////////
///////
/////
///
//
class TextShaded extends StatelessWidget {
  const TextShaded({
    required this.txt,
    Key? key,
  }) : super(key: key);
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
          color: Colors.yellowAccent.shade700,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          shadows: [
            Shadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 5))
          ]),
    );
  }
}
