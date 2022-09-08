import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_in2/controllers/social_cubit/cubit/social_cubit.dart';
import 'package:im_in2/models/user_model.dart';
import 'package:im_in2/ui/screens/home_layouts/chats/chat_details.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/widgets/post_header.dart';

class ChatScreen extends StatelessWidget {
  static const id = "ChatScreen";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return (SocialCubit.get(context).allUsers.isNotEmpty)
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    itemBuilder: (context, index) => buildUserTile(
                        SocialCubit.get(context).allUsers[index], context),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: SocialCubit.get(context).allUsers.length),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  buildUserTile(UserModel u, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetails(userData: u),
            ));
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              u.image,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                u.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    );
  }
}
