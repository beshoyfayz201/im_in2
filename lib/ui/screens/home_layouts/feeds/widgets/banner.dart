import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:im_in2/shared/size_config.dart';
import 'package:im_in2/ui/widgets/texts.dart';

class TempBanner extends StatelessWidget {
  final Widget? image;
  final Widget? upperWidget;
  TempBanner({Key? key, this.upperWidget, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            height: SizeConfig.screenHeight * 0.3,
            width: SizeConfig.screenWidth,
            child: image,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.01,
            right: MediaQuery.of(context).size.width * 0.01,
            child: Container(
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width * 0.35,
              child: upperWidget ??
                  TextShaded(
                      txt:
                          "welcome to our community . catch up with your family and freinds",),
            ),
          )
        ],
      ),
    );
  }
}

class TempOvalBanner extends StatelessWidget {
  final Widget? image;
  final Widget? upperWidget;
  TempOvalBanner({Key? key, this.upperWidget, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade50,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              height: SizeConfig.screenHeight * 0.25,
              width: SizeConfig.screenWidth,
              child: image,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.01,
            right: MediaQuery.of(context).size.width * 0.01,
            child: Container(
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width * 0.35,
              child: upperWidget ??
                  TextShaded(
                      txt:
                          "welcome to our community . catch up with your family and freinds"),
            ),
          )
        ],
      ),
    );
  }
}
