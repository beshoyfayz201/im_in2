import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_in2/controllers/login_cubit/cubit/user_cubit.dart';
import 'package:im_in2/controllers/social_cubit/cubit/social_cubit.dart';
import 'package:im_in2/helpers/cash_helper.dart';
import 'package:im_in2/shared/shared_data.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/addpost/addpost_screen.dart';
import 'package:im_in2/ui/screens/home_layouts/home_layout.dart';
import 'package:im_in2/ui/screens/home_layouts/settings/widgets/edit_profile.dart';
import 'package:im_in2/ui/screens/home_screen.dart';
import 'package:im_in2/ui/screens/register/login_screen.dart';
import 'package:im_in2/ui/screens/register/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();

  await Firebase.initializeApp();
  uid = CashHelper.getData("uid");
  final distination = (uid == null) ? WelcomeScreen() : HomeLayout();
  runApp(MyApp(
    distination: distination,
  ));
}

class MyApp extends StatelessWidget {
  final Widget distination;
  const MyApp({Key? key, required this.distination}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SocialCubit>(
      create: (context) => SocialCubit()
        ..getUserData()
        ..getPosts(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: distination,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme:
                AppBarTheme(iconTheme: IconThemeData(color: Colors.black87))),
      ),
    );
  }
}
