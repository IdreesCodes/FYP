import 'package:bubble/bubble.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../../view_model/services/session_controller.dart';

class CustomChat extends StatelessWidget {
  const CustomChat({Key? key, required this.chatController}) : super(key: key);
  final chatController;
  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      controller: chatController.scrollController,
      query: FirebaseDatabase.instance.ref().child(
          'Chat/${SessionController().userId.toString()}${chatController.receiverId}'),
      itemBuilder: (context, snapshot, animation, index) {
        if (SessionController().userId.toString() !=
            snapshot.child('sender').value.toString()) {
          return Bubble(
            margin: const BubbleEdges.only(top: 5, right: 100, bottom: 5),
            alignment: Alignment.topLeft,
            nip: BubbleNip.leftTop,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(snapshot.child('message').value.toString(),
                    textAlign: TextAlign.left),
                Text(
                  snapshot.child('time').value.toString(),
                  style: const TextStyle(fontSize: 10),
                  textAlign: TextAlign.right,
                  //textAlign: TextAlign.right
                ),
              ],
            ),
          );
        } else {
          return Bubble(
            margin: const BubbleEdges.only(top: 5, left: 100, bottom: 5),
            alignment: Alignment.topRight,
            nip: BubbleNip.rightTop,
            color: const Color.fromRGBO(225, 255, 199, 1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(snapshot.child('message').value.toString(),
                    textAlign: TextAlign.left),
                Text(
                  snapshot.child('time').value.toString(),
                  style: const TextStyle(fontSize: 10),
                  textAlign: TextAlign.right,
                  //textAlign: TextAlign.right
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
