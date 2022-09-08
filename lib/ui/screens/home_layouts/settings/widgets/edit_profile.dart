import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_in2/controllers/social_cubit/cubit/social_cubit.dart';
import 'package:im_in2/shared/size_config.dart';
import 'package:im_in2/ui/screens/home_layouts/settings/widgets/cover.dart';
import 'package:im_in2/ui/screens/home_layouts/settings/widgets/status_widegt.dart';

import 'package:im_in2/ui/widgets/txtfield.dart';

import 'container_img.dart';

class EditProfile extends StatelessWidget {
  static const id = "Edit Profile";
  EditProfile({Key? key}) : super(key: key);
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("objectssssss");
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var socialcu = SocialCubit.get(context);
        File? image = socialcu.image;
        File? coverImage = socialcu.coverImage;

        return Scaffold(
            body: SocialCubit.get(context).userdata == null
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.greenAccent),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: SizeConfig.screenHeight * 0.45,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ProfileCover(
                                    bio: socialcu.userdata!.bio,
                                    image: image == null
                                        ? ImgContainer(
                                            image: NetworkImage(
                                                socialcu.userdata!.image),
                                          )
                                        : ImgContainer(
                                            image: FileImage(
                                              socialcu.image!,
                                            ),
                                          ),
                                    name: socialcu.userdata!.name,
                                    coverImage: coverImage == null
                                        ? Image.network(
                                            socialcu.userdata!.cover,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.file(socialcu.coverImage!,
                                            fit: BoxFit.fill),
                                  ),
                                  Positioned(
                                      bottom: SizeConfig.screenHeight * 0.09,
                                      right: SizeConfig.screenWidth * 0.39,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.greenAccent.shade700,
                                        child: IconButton(
                                          icon: Icon(Icons.camera),
                                          color: Colors.white,
                                          onPressed: () {
                                            socialcu.getImage();
                                          },
                                        ),
                                      )),
                                  Positioned(
                                      top: SizeConfig.screenHeight * 0.03,
                                      right: SizeConfig.screenWidth * 0.05,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.greenAccent.shade700,
                                        child: IconButton(
                                          icon: Icon(Icons.camera),
                                          color: Colors.white,
                                          onPressed: () {
                                            socialcu.getCoverImage();
                                          },
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        // ProfileCover(
                        //   bio: socialcu.userdata!.bio,
                        //   image: socialcu.userdata!.image,
                        //   name: socialcu.userdata!.name,
                        // ),
                        //status
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.05),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  StatusWidget(number: "10", title: "post"),
                                  StatusWidget(
                                      number: "4k", title: "followers"),
                                  StatusWidget(
                                      number: "34", title: "following"),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.screenHeight * 0.02),
                                child: Column(
                                  children: [
                                    (state is ImageLoadingState ||
                                            state is ImageLoadingState)
                                        ? LinearProgressIndicator(
                                            backgroundColor:
                                                Colors.yellowAccent,
                                            color: Colors.greenAccent,
                                          )
                                        : SizedBox(),
                                    TextButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.greenAccent.shade700,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      onPressed: () {
                                        socialcu.updateUser(
                                            name: name.text,
                                            bio: bio.text,
                                            cover: socialcu.coverurl,
                                            image: socialcu.imageurl);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Save Updates",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TxtField(
                                  validation: (txt) => null,
                                  label: "Name",
                                  textEditingController: name
                                    ..text = socialcu.userdata!.name),
                              TxtField(
                                  validation: (txt) => null,
                                  label: "Bio",
                                  textEditingController: bio
                                    ..text = socialcu.userdata!.bio),
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
      },
    );
  }
}
