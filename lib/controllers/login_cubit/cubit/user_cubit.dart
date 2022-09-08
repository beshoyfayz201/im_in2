import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_in2/helpers/cash_helper.dart';
import 'package:im_in2/models/user_model.dart';
import 'package:im_in2/shared/shared_data.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserCubitState> {
  UserCubit() : super(RegisterCubitInitial());
  static UserCubit get(BuildContext context) => BlocProvider.of(context);
  bool obsecured = true; //for show or hide icon
  changObsecure() {
    obsecured = !obsecured;
    emit(RegisterObsecureIconState());
  }

  UserModel? userData;
  //sign-up
  registerUser(String email, String password, String name) async {
    emit(AccountLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uid = value.user!.uid;
      userData = UserModel(
          email: email,
          name: name,
          cover:
              "https://i.pinimg.com/736x/d3/98/e7/d398e7aa44185adf60ce86548f208483.jpg",
          password: password,
          uid: value.user!.uid,
          image:
              "https://wisheschoice.com/wp-content/uploads/2018/06/make-someone-smile.jpeg",
          bio: "write your bio");
      FirebaseFirestore.instance
          .collection("users")
          .doc(value.user!.uid)
          .set(userData!.toMap())
          .then((c) {
        emit(AccountSuccessState(userModel: userData!));
      });
    }).catchError((e, st) {
      print(e.toString());
      emit(AccountErrorState(error: e.code));
    });
  }

  //Log in
  login(String email, String password) async {
    emit(AccountLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(AccountSuccessState(userModel: userData!));
    }).catchError((e) {
      print(e.toString());
      emit(AccountErrorState(error: e.code));
    });
  }

  getProfile() async {
    emit(AccountLoadingState());
  }
}
