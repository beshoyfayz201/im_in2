import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_in2/controllers/login_cubit/cubit/user_cubit.dart';
import 'package:im_in2/controllers/social_cubit/cubit/social_cubit.dart';
import 'package:im_in2/models/post_model.dart';
import 'package:im_in2/shared/size_config.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/widgets/banner.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/widgets/post.dart';

class FeedsScreen extends StatelessWidget {
  static const id = "feedsScreen";
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<SocialCubit, SocialState>(listener: (context, state) {
 
      // TODO: implement listener
    }, builder: (context, state) {
      SocialCubit sCubit = SocialCubit.get(context);
      return (SocialCubit.get(context).posts.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    TempBanner(
                        image: Image.network(
                      "https://media.istockphoto.com/photos/the-concept-of-unity-cooperation-teamwork-and-charity-picture-id1223996952?b=1&k=20&m=1223996952&s=170667a&w=0&h=6fBPPecujBL7V1-qCY6X1-A2ZZrlkYsJhMOIwheFd7c=",
                      fit: BoxFit.fill,
                    )),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                        children: List.generate(
                            SocialCubit.get(context).posts.length,
                            (index) => PostWidget(
                                  postModel:
                                      SocialCubit.get(context).posts[index],
                                  likes:
                                      SocialCubit.get(context).postLikes[index],
                                  index: index,
                                )))
                  ],
                ),
              ),
            );
    });
  }
}
