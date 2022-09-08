import 'package:flutter/material.dart';
import 'package:im_in2/ui/widgets/texts.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({Key? key, required this.number, required this.title})
      : super(key: key);
  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        SubTitle(txt: number, size: 24),
        SubTitle(txt: title, size: 15),
      ],
    );
  }
}
