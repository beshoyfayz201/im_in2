import 'package:flutter/material.dart';
import 'package:im_in2/shared/size_config.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/widgets/banner.dart';
import 'package:im_in2/ui/widgets/texts.dart';

class ProfileCover extends StatelessWidget {
  final String name;
  final String bio;
  final dynamic coverImage;
  final dynamic image;

  const ProfileCover(
      {Key? key,
      required this.bio,
      this.image,
      required this.name,
      this.coverImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: SizeConfig.screenHeight * 0.35,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: TempOvalBanner(
                    upperWidget: Container(),
                    image: coverImage ??
                        NetworkImage(
                            "https://media.istockphoto.com/photos/smiling-friendly-young-woman-wearing-spectacles-picture-id1251308867?k=20&m=1251308867&s=612x612&w=0&h=lDj72q8pkc1m1vRTmESQy_zdZFSTiW7vWQyFH0a4_6k=")),
              ),
              Positioned(
                child: image ??
                    NetworkImage(
                        "https://media.istockphoto.com/photos/smiling-friendly-young-woman-wearing-spectacles-picture-id1251308867?k=20&m=1251308867&s=612x612&w=0&h=lDj72q8pkc1m1vRTmESQy_zdZFSTiW7vWQyFH0a4_6k="),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        SubTitle(
          txt: bio,
          size: 16,
          color: Colors.grey,
        ),
      ],
    );
  }
}
