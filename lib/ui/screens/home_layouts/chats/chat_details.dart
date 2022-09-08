import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_in2/controllers/social_cubit/cubit/social_cubit.dart';
import 'package:im_in2/models/user_model.dart';
import 'package:im_in2/shared/size_config.dart';
import 'package:im_in2/ui/screens/home_layouts/feeds/widgets/post_header.dart';
import 'package:im_in2/ui/widgets/txtfield.dart';

class ChatDetails extends StatelessWidget {
  final AppBar appBar = AppBar();
  static const id = "ChatScreen";
  ChatDetails({Key? key, required this.userData}) : super(key: key);
  final UserModel userData;
  TextEditingController message = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        String text = "fgdgfd\n\nfgdgfdg";
        return Scaffold(
          appBar: buildBar(userData, context),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.bottomCenter,
                    image: AssetImage("assets/images/reg_background.png"))),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(children: [
                ...List.generate(
                    10,
                    (index) => MessageBuble(
                          text: text,
                          isMe: index % 2 == 0,
                        )),
                Card(
                  shape: StadiumBorder(),
                  color: Colors.blue.shade900.withOpacity(0.2),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: message,
                          cursorHeight: 30,
                          cursorWidth: 3,
                          cursorRadius: Radius.circular(20),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: Card(
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: Colors.green, width: 2)),
                                color: Colors.white60,
                                child: IconButton(
                                  icon: Icon(Icons.send, color: Colors.white),
                                  onPressed: () {
                                    if (message.text.isNotEmpty) {
                                      SocialCubit.get(context).sendMessage(
                                          receiver: userData.uid,
                                          date:
                                              DateTime.now().toIso8601String(),
                                          txt: message.text);
                                    }
                                  },
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }

  buildBar(UserModel u, BuildContext context) {
    return AppBar(
        backgroundColor: Colors.greenAccent,
        actions: [
          Icon(
            Icons.videocam,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.call,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          SizedBox(width: 10)
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Row(
          children: [
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    u.image,
                  ),
                )),
            Text(
              u.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }
}

class MessageBuble extends StatelessWidget {
  const MessageBuble({
    Key? key,
    required this.text,
    required this.isMe,
  }) : super(key: key);

  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: isMe
                ? Colors.grey.shade400.withOpacity(0.5)
                : Color.fromARGB(255, 243, 235, 155).withOpacity(0.9),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(isMe ? 0 : 20),
                bottomRight: Radius.circular(isMe ? 20 : 0),
                topLeft: Radius.circular(20))),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        width: SizeConfig.screenWidth * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(text),
        ),
      ),
    );
  }
}
