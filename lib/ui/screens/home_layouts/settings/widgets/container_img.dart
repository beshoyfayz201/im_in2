import 'package:flutter/material.dart';
import 'package:im_in2/shared/size_config.dart';

class ImgContainer extends StatelessWidget {
  const ImgContainer({
    Key? key,
    required this.image,
  }) : super(key: key);

  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 4, color: Colors.greenAccent.shade100),
          shape: BoxShape.circle),
      child: CircleAvatar(
        radius: SizeConfig.screenHeight * 0.1,
        backgroundImage: image!,
      ),
    );
  }
}
