import 'package:flutter/material.dart';
import 'package:im_in2/ui/screens/register/login_screen.dart';
import 'package:im_in2/ui/screens/register/signup_screen.dart';
import 'package:im_in2/ui/widgets/rounded_button.dart';
import 'package:im_in2/ui/widgets/texts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.08, horizontal: size.width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LTitle(txt: "welcome"),
              SubTitle(
                  txt: "don\'t stay behind the scene join us now", size: 16),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.08),
                child: Image.asset("assets/images/onboard.png",
                    height: size.height * 0.4),
              ),
              RoundedButton(
                  txt: "Login",
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
                  }),
              SizedBox(
                height: size.height * 0.015,
              ),
              RoundedButton(
                txt: "Sign-up",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ));
                },
                color: Colors.yellow.shade300,
              )
            ],
          ),
        ),
      )),
    );
  }
}
