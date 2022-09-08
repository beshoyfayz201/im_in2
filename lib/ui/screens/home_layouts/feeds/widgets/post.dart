import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_in2/controllers/social_cubit/cubit/social_cubit.dart';
import 'package:im_in2/models/post_model.dart';
import 'package:im_in2/shared/size_config.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/widgets/mydivider.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/widgets/post_header.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/widgets/tags_widget.dart';
import 'package:im_in2/ui/widgets/text_icon_button.dart';
import 'package:im_in2/ui/widgets/texts.dart';

class PostWidget extends StatelessWidget {
  PostWidget(
      {Key? key, required this.postModel, required this.index, this.likes = 0})
      : super(key: key);
  final PostModel postModel;
  final int index;
  int? likes;

  @override
  Widget build(BuildContext context) {
    String? img = postModel.postImageUrl;
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostHeader(
                    date: postModel.date,
                    image: postModel.imageurl,
                    title: postModel.name),
                MyDivider(),
                Container(
                  padding:
                      EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.01),
                  child: Text(postModel.text),
                ),
                TagsWidget(),
                img!.isNotEmpty
                    ? Container(
                        height: SizeConfig.screenHeight * 0.2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(img))),
                      )
                    : SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconTextButton(
                        iconData: Icons.favorite,
                        onPressed: () {},
                        txt: likes.toString()),
                    IconTextButton(
                      onPressed: () {},
                      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                      iconData: Icons.chat,
                      txt: "100 comment",
                    )
                  ],
                ),
                //commient bar
                MyDivider(),
                Row(children: [
                  CircleAvatar(
                      minRadius: 20,
                      backgroundImage: NetworkImage(postModel.imageurl)),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.02,
                  ),
                  SubTitle(
                    txt: "Write a comment...",
                    size: 13,
                  ),
                  Spacer(),
                  IconTextButton(
                    onPressed: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postsIds[index]);
                    },
                    txt: " Like",
                    iconData: Icons.favorite,
                  )
                ])
              ],
            ),
          ),
        );
      },
    );
  }
}
