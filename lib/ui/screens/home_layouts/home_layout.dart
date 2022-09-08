import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_in2/controllers/social_cubit/cubit/social_cubit.dart';
import 'package:im_in2/shared/size_config.dart';
import 'package:im_in2/ui/screens/home_layouts/chats/chat_screen.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/feeds_screen.dart';
import 'package:im_in2/ui/screens/home_layouts/settings/settings_screen.dart';
import 'package:im_in2/ui/screens/home_layouts/users/users_screen.dart';

class HomeLayout extends StatelessWidget {
  static const id = "HomeLayout";
  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    UsersScreen(),
    UsersScreen(),
    SettingsScreen()
  ];
  List<String> titles = const ["Home", "Chat", "Users", "add post", "Settings"];
  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade200,
              title: Text(
                titles[SocialCubit.get(context).index],
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      (Icons.search),
                      color: Colors.black54,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      (Icons.notifications),
                      color: Colors.black54,
                    ))
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.greenAccent.shade400,
              unselectedItemColor: Colors.grey.shade400,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.feedback), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_outline_sharp), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.edit,
                    ),
                    label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
              ],
              currentIndex: SocialCubit.get(context).index,
              onTap: (int val) {
                SocialCubit.get(context).changeIndex(val, context);
              },
            ),
            body: screens[SocialCubit.get(context).index],
          ),
        );
      },
    );
  }
}
