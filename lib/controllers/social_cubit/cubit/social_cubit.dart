import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_in2/models/message_model.dart';
import 'package:im_in2/models/post_model.dart';
import 'package:im_in2/models/user_model.dart';
import 'package:im_in2/shared/shared_data.dart';
import 'package:im_in2/shared/toasts.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/addpost/addpost_screen.dart';
import 'package:image_picker/image_picker.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());
  static SocialCubit get(BuildContext context) => BlocProvider.of(context);
  UserModel? userdata;
  getUserData() {
    print("fffffffff");
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uid).get().then((value) {
      userdata = UserModel.fromMap(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString() + "-------------");
      emit(SocialGetUserErrorState(error));
    });
  }

  int index = 0;
  void changeIndex(int val, BuildContext context) {
    if (val == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddPostScreen(),
          ));
      emit(AddPostState());
    } else {
      if (val == 1) {
        allUsers = [];
        getUsers();
      }
      index = val;
      emit(SocialBottomNavBar());
    }
  }

  //pickImage
  File? image;
  String? imageurl;

  Future<void> getImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(ImageLoadingState());
    if (pickedFile != null) {
      image = File(pickedFile.path);
      await uploadImage();
      emit(ImagePickerState());
    } else {
      print("no image picked");
    }
  }

  File? coverImage;
  String? coverurl;
  Future<void> getCoverImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(ImageLoadingState());

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      await uploadCover();
      emit(ImagePickerState());
    } else {
      print("no image picked");
    }
  }

  uploadImage() async {
    print("11111---------");
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(image!.path).pathSegments.last}")
        .putFile(image!)
        .then((p0) {
      p0.ref.getDownloadURL().then((url) {
        print("2222222---------");

        imageurl = url;
        print(url);
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  uploadCover() async {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((picRes) {
      picRes.ref.getDownloadURL().then((url) {
        coverurl = url;
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  updateUser(
      {required String name,
      required String bio,
      String? cover,
      String? image}) {
    emit(ImageLoadingState());
    FirebaseFirestore.instance.collection("users").doc(userdata!.uid).update({
      "bio": bio,
      "name": name,
      "cover": cover ?? userdata!.cover,
      "email": userdata!.email,
      "image": image ?? userdata!.image,
      "uid": userdata!.uid
    }).then((value) {
      getUserData();
    }).catchError((e) {
      emit(SocialUpdateUserErrorState(e));
    });
  }

  ///upload post Image///////////////////////////////////////////
  File? postImage;
  String? postImageurl;
  Future<void> UploadPostImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(ImageLoadingState());
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
          .putFile(postImage!)
          .then((picRes) {
        picRes.ref.getDownloadURL().then((url) {
          postImageurl = url;
        });
      }).catchError((e) {
        print(e.toString());
      });
      emit(ImagePickerState());
    } else {
      print("no image picked");
    }
  }

  Future<void> CreatePost({
    required String name,
    required String imageurl,
    required String uid,
    required String date,
    required String text,
  }) async {
    emit(CreatPostLoadingState());
    FirebaseFirestore.instance
        .collection("posts")
        .add(PostModel(
                uid: uid,
                name: name,
                imageurl: imageurl,
                date: date,
                text: text,
                postImageUrl: postImageurl ?? "")
            .toMap())
        .then((value) {
      emit(PostSuccessState());
    }).catchError((e) {
      emit(ErrorPostState());
    });
  }

  //
  List<PostModel> posts = [];
  List<String> postsIds = [];
  List<int> postLikes = [];

  getPosts() async {
    emit(GetPostsLoadingState());
    await FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) async {
        element.reference.collection("likes").get().then((value) {
          postLikes.add(value.docs.length);
          posts.add(PostModel.fromMap(element.data()));
          postsIds.add(element.id);
          print(posts.length);
        }).catchError((e) {
          print("e11111111111111");
        });
      });
    }).catchError((error) {
      emit(GetPostsErrorState(error));
    });

    emit(GetPostsSuccessState());
  }

  //like
  void likePost(String postId) async {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(userdata!.uid)
        .set({"like": true}).then((value) {
      emit(LikePostState());
    }).catchError((error) {});
  }

  List<UserModel> allUsers = [];
  //users
  getUsers() async {
    emit(GetUsersLoadingState());
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) async {
        if (element.data()["name"] != userdata!.name)
          allUsers.add(UserModel.fromMap(element.data()));
      });
      emit(GetUsersState());
    }).catchError((error) {
      emit(GetPostsErrorState(error));
    });
  }

  sendMessage({
    required String receiver,
    required String date,
    required String txt,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("chats")
        .doc(receiver)
        .collection("messages").add(MessageModel(
                sender: uid!, receiver: receiver, dateTime: date, txt: txt)
            .toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((e) {});
    FirebaseFirestore.instance
        .collection("users")
        .doc(receiver)
        .collection("chats")
        .doc(uid)
        .collection("messages").add(MessageModel(
                sender: uid!, receiver: receiver, dateTime: date, txt: txt)
            .toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((e) {});
  }
}
