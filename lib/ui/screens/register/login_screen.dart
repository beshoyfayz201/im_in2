import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_in2/controllers/login_cubit/cubit/user_cubit.dart';
import 'package:im_in2/helpers/cash_helper.dart';
import 'package:im_in2/shared/toasts.dart';
import 'package:im_in2/ui/screens/home_layouts/home_layout.dart';
import 'package:im_in2/ui/screens/register/signup_screen.dart';
import 'package:im_in2/ui/widgets/or_widget.dart';
import 'package:im_in2/ui/widgets/rounded_button.dart';
import 'package:im_in2/ui/widgets/texts.dart';
import 'package:im_in2/ui/widgets/txtfield.dart';

class LoginScreen extends StatelessWidget {
  static const String id = "LofinScreen";
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
          if (state is AccountSuccessState) {
            CashHelper.saveData("uid", state.userModel.uid).then((value) {
              Navigator.pushNamed(context, HomeLayout.id);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                                  LTitle(txt: "Login"),
                                  SubTitle(txt: "Login to your account"),
                                  TxtField(
                                      validation: (String? c) {
                                        if (!c!.contains("@") &&
                                            !c.contains(".com"))
                                          return "please enter a right form";
                                        else
                                          return null;
                                      },
                                      label: "email",
                                      textEditingController: email),
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
                                            color:
                                                UserCubit.get(context).obsecured
                                                    ? Colors.black
                                                    : Colors.black12,
                                          )),
                                      label: "password",
                                      obsecure:
                                          UserCubit.get(context).obsecured,
                                      textEditingController: password),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),
                                  (state is AccountLoadingState)
                                      ? Center(
                                          child: LinearProgressIndicator(
                                            color: Colors.yellowAccent.shade100,
                                            backgroundColor: Colors.greenAccent,
                                          ),
                                        )
                                      : RoundedButton(
                                          txt: "Login",
                                          color: Colors.yellowAccent.shade100,
                                          onPressed: () {
                                            if (formkey.currentState!
                                                .validate()) {
                                              UserCubit.get(context).login(
                                                  email.text, password.text);
                                            }
                                          },
                                        ),
                                  OrWidegt(
                                      txt1: "don\'t have an account",
                                      txt2: "Sign-up",
                                      navigateTo: () {
                                        Navigator.of(context)
                                            .pushNamed(SignUpScreen.id);
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
