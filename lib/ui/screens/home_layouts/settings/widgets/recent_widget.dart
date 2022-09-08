import 'package:flutter/material.dart';
import 'package:im_in2/shared/size_config.dart';
import 'package:im_in2/ui/widgets/text_icon_button.dart';

class RecentWidget extends StatelessWidget {
  const RecentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          IconTextButton(
              size: 30,
              txt: "recent posts",
              iconColor: Colors.grey.shade600,
              textColor: Colors.grey.shade700,
              iconData: Icons.image_outlined,
              onPressed: () {}),
          Container(
            height: SizeConfig.screenHeight * 0.4,
            child: GridView.count(
                childAspectRatio: 1.5,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(
                  4,
                  (index) => Container(
                      height: 200,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.antiAlias,
                      child: SizedBox(
                        child: Image.network(
                          "https://img.freepik.com/free-photo/gorgeous-white-girl-with-long-wavy-hair-chilling-autumn-day-outdoor-portrait-interested-ginger-female-model-with-cup-coffee_197531-11735.jpg?w=1060&t=st=1661421799~exp=1661422399~hmac=208863944529d3c6ea10f4671f83191dcd90e511cadf7c30ec80f5292016c702",
                          fit: BoxFit.fill,
                        ),
                      )),
                )),
          ),
        ],
      ),
    );
  }
}
