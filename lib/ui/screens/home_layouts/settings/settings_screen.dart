import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_in2/controllers/social_cubit/cubit/social_cubit.dart';
import 'package:im_in2/models/user_model.dart';
import 'package:im_in2/shared/size_config.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/widgets/banner.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/widgets/post_header.dart';
import 'package:im_in2/ui/screens/home_layouts/settings/widgets/container_img.dart';
import 'package:im_in2/ui/screens/home_layouts/settings/widgets/cover.dart';
import 'package:im_in2/ui/screens/home_layouts/settings/widgets/edit_profile.dart';
import 'package:im_in2/ui/screens/home_layouts/settings/widgets/recent_widget.dart';
import 'package:im_in2/ui/screens/home_layouts/settings/widgets/status_widegt.dart';
import 'package:im_in2/ui/widgets/rounded_button.dart';
import 'package:im_in2/ui/widgets/text_icon_button.dart';
import 'package:im_in2/ui/widgets/texts.dart';

class SettingsScreen extends StatelessWidget {
  static const id = "SettingsScreen";
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("SettingsScreen");
    UserModel? userData = SocialCubit.get(context).userdata;
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is SocialGetUserSuccessState)
          userData = SocialCubit.get(context).userdata;
      },
      builder: (context, state) {
        File? coverImage = SocialCubit.get(context).coverImage;
        File? image = SocialCubit.get(context).image;

        return (userData == null)
            ? Center(
                child: CircularProgressIndicator(color: Colors.greenAccent),
              )
            : SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileCover(
                          bio: userData!.bio,
                          image: image == null
                              ? ImgContainer(
                                  image: NetworkImage(userData!.image),
                                )
                              : ImgContainer(
                                  image: FileImage(
                                    image,
                                  ),
                                ),
                          name: userData!.name,
                          coverImage: coverImage == null
                              ? Image.network(
                                  userData!.cover,
                                  fit: BoxFit.fill,
                                )
                              : Image.file(coverImage, fit: BoxFit.fill),
                        ),

                        //status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            StatusWidget(number: "10", title: "post"),
                            StatusWidget(number: "4k", title: "followers"),
                            StatusWidget(number: "34", title: "following"),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: TextButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.greenAccent.shade700,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    onPressed: () {},
                                    child: Text(
                                      "    Follow   ",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              SizedBox(width: SizeConfig.screenWidth * 0.15),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "   Message  ",
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      primary: Colors.grey.shade700,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                ),
                              ),
                            ],
                          ),
                        ),

                        RecentWidget()
                      ],
                    ),
                    Positioned(
                        right: 0,
                        top: 15,
                        child: IconButton(
                          icon: Icon(Icons.settings, color: Colors.black45),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(),
                                ));
                          },
                        ))
                  ],
                ),
              );
      },
    );
  }
}

class ProfileStatusItem extends StatelessWidget {
  const ProfileStatusItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            "100",
            style: TextStyle(fontSize: 18),
          ),
          SubTitle(
            txt: "post",
            size: 15,
          )
        ],
      ),
    );
  }
}
