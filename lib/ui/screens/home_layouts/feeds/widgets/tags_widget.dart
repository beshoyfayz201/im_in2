import 'package:flutter/material.dart';

class TagsWidget extends StatelessWidget {
  const TagsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      
        children: List.generate(
      1,
      (index) => Padding(
          child: InkWell(
            onTap: () {},
            child: Text(
              "#the_best_doctor",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          padding: EdgeInsetsDirectional.only(end: 10)),
    ));
  }
}
