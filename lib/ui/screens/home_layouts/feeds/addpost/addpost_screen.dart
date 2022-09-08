import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_in2/controllers/social_cubit/cubit/social_cubit.dart';
import 'package:im_in2/models/user_model.dart';
import 'package:im_in2/shared/size_config.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/widgets/banner.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/widgets/post_header.dart';
import 'package:im_in2/ui/widgets/rounded_button.dart';

class AddPostScreen extends StatelessWidget {
  static const id = "Add post";
  AddPostScreen({Key? key}) : super(key: key);
  TextEditingController postTxt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print("object");
        UserModel userData = SocialCubit.get(context).userdata!;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade200,
            title: Text(
              id,
              style: TextStyle(color: Colors.black87),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                (state is ImageLoadingState || state is CreatPostLoadingState)
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: LinearProgressIndicator(
                          color: Colors.greenAccent,
                          backgroundColor: Colors.yellowAccent,
                        ),
                      )
                    : SizedBox(),
                PostHeader(
                    date: "public",
                    image: SocialCubit.get(context).userdata!.image,
                    title: SocialCubit.get(context).userdata!.name),
                TextFormField(
                  controller: postTxt,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "What is in your mind ..."),
                ),
                (SocialCubit.get(context).postImage != null)
                    ? Container(
                        width: double.infinity,
                        child: Image.file(
                          SocialCubit.get(context).postImage!,
                          fit: BoxFit.fitWidth,
                          height: SizeConfig.screenHeight * 0.4,
                        ),
                      )
                    : const SizedBox(),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        icon: Icon(Icons.podcasts_rounded,
                            color: Colors.greenAccent.shade700),
                        label: Text(
                          "post",
                          style: TextStyle(color: Colors.greenAccent.shade700),
                        ),
                        onPressed: () async {
                          await SocialCubit.get(context).CreatePost(
                              name: userData.name,
                              imageurl: userData.image,
                              uid: userData.uid,
                              date: DateTime.now().toIso8601String(),
                              text: postTxt.text);
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Colors.greenAccent.shade700,
                        ),
                        label: Text(
                          "add photo",
                          style: TextStyle(color: Colors.greenAccent.shade700),
                        ),
                        onPressed: () async {
                          await SocialCubit.get(context).UploadPostImage();
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
