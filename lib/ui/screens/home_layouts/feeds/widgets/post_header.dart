import 'package:flutter/material.dart';
import 'package:im_in2/shared/size_config.dart';
import 'package:im_in2/ui/widgets/texts.dart';

class PostHeader extends StatelessWidget {
  const PostHeader(
      {Key? key, required this.date, required this.image, required this.title})
      : super(key: key);
  final String image;
  final String date;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(minRadius: 30, backgroundImage: NetworkImage(image)),
        SizedBox(
          width: SizeConfig.screenWidth * 0.02,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.check_circle,
                    size: 18,
                    color: Colors.greenAccent.shade700,
                  )
                ],
              ),
              SubTitle(
                txt: date,
                size: 12,
              )
            ],
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
      ],
    );
  }
}
