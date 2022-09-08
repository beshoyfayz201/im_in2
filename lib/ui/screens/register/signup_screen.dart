import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_in2/controllers/login_cubit/cubit/user_cubit.dart';
import 'package:im_in2/helpers/cash_helper.dart';
import 'package:im_in2/shared/toasts.dart';
import 'package:im_in2/ui/screens/home_layouts/home_layout.dart';
import 'package:im_in2/ui/screens/register/login_screen.dart';
import 'package:im_in2/ui/widgets/or_widget.dart';
import 'package:im_in2/ui/widgets/rounded_button.dart';
import 'package:im_in2/ui/widgets/texts.dart';
import 'package:im_in2/ui/widgets/txtfield.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = "SignUpScreen";
  SignUpScreen({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();

  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("object");

    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserCubitState>(
        listener: (context, state) {
          if (state is AccountErrorState) {
            showToast(
                context: context, msg: state.error, color: Colors.red.shade300);
          }
          // TODO: implement listener
          if (state is AccountSuccessState) {
            CashHelper.saveData("uid", state.userModel.uid).then((value) {
              Navigator.pushNamed(context, HomeLayout.id);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.topCenter,
                fit: StackFit.loose,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "assets/images/reg_background.png",
                      height: MediaQuery.of(context).size.height * 0.42,
                    ),
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.15,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1),
                            child: Form(
                              key: formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const LTitle(txt: "Sign-up"),
                                  const SubTitle(
                                      txt:
                                          "be one of us and create your account"),
                                  TxtField(
                                      validation: (String? c) {
                                        return null;
                                      },
                                      label: "name",
                                      textEditingController: name),
                                  TxtField(
                                      validation: (String? c) {
                                        if ((!c!.contains("@")) ||
                                            (!c.contains(".com")))
                                          return "please enter a right form";
                                        else
                                          return null;
                                      },
                                      label: "email",
                                      textEditingController: email),
                                  Column(
                                    children: [
                                      TxtField(
                                          validation: (String? c) {
                                            if (c!.length < 5)
                                              return "password is too weak";
                                            else
                                              return null;
                                          },
                                          suffix: IconButton(
                                              onPressed: () {
                                                UserCubit.get(context)
                                                    .changObsecure();
                                              },
                                              icon: Icon(
                                                Icons.remove_red_eye,
                                                color: UserCubit.get(context)
                                                        .obsecured
                                                    ? Colors.black
                                                    : Colors.black12,
                                              )),
                                          label: "password",
                                          obsecure:
                                              UserCubit.get(context).obsecured,
                                          textEditingController: password),
                                      TxtField(
                                          validation: (String? c) {
                                            if (password.text !=
                                                confirmPassword.text)
                                              return "passwords are not matched";
                                            else
                                              return null;
                                          },
                                          suffix: IconButton(
                                              onPressed: () {
                                                UserCubit.get(context)
                                                    .changObsecure();
                                              },
                                              icon: Icon(
                                                Icons.remove_red_eye,
                                                color: UserCubit.get(context)
                                                        .obsecured
                                                    ? Colors.black
                                                    : Colors.black12,
                                              )),
                                          label: "confirm password",
                                          obsecure:
                                              UserCubit.get(context).obsecured,
                                          textEditingController:
                                              confirmPassword),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),
                                  BlocConsumer<UserCubit, UserCubitState>(
                                    listener: (context, state) {
                                      if (state is AccountErrorState) {
                                        showToast(
                                            context: context,
                                            msg: state.error,
                                            color: Colors.red.shade300);
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is AccountLoadingState)
                                        return Center(
                                          child: LinearProgressIndicator(
                                            color: Colors.yellowAccent.shade100,
                                            backgroundColor: Colors.greenAccent,
                                          ),
                                        );
                                      return RoundedButton(
                                        txt: "Sign-up",
                                        color: Colors.yellowAccent.shade100,
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            UserCubit.get(context).registerUser(
                                                email.text,
                                                password.text,
                                                name.text);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                  OrWidegt(
                                      txt1: "Already have an account",
                                      txt2: "Login",
                                      navigateTo: () {
                                        Navigator.of(context)
                                            .pushNamed(LoginScreen.id);
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
