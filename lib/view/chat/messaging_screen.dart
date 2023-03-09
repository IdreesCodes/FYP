import 'package:bubble/bubble.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_controller.dart';

import '../../res/color.dart';

class ChatScreen extends StatefulWidget {
  String name;
  String image;
  String receiverId;
  ChatScreen(
      {Key? key,
      required this.name,
      required this.image,
      required this.receiverId})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Chat');
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.name.toString()),
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.menu_rounded),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.network(widget.image.toString()),
              )),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      if (index % 2 == 0) {
                        return Bubble(
                          margin: const BubbleEdges.only(top: 10),
                          alignment: Alignment.topRight,
                          nip: BubbleNip.rightTop,
                          color: const Color.fromRGBO(225, 255, 199, 1.0),
                          child:
                              const Text('Idrees', textAlign: TextAlign.right),
                        );
                      } else {
                        return Bubble(
                          margin: const BubbleEdges.only(top: 10),
                          alignment: Alignment.topLeft,
                          nip: BubbleNip.leftTop,
                          child: const Text('Irfan'),
                        );
                      }

                      //Text(index.toString());
                    })),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: TextFormField(
                    controller: messageController,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(height: 0, fontSize: 18),
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            sendMessage();
                          },
                          child: const CircleAvatar(
                            child: Icon(Icons.send_outlined),
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      hintText: 'Enter Message...',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(
                              height: 0,
                              color: AppColors.primaryTextTextColor
                                  .withOpacity(0.8)),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldDefaultFocus),
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.secondaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.alertColor),
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldDefaultBorderColor),
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                    ),
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  sendMessage() {
    if (messageController.text.isEmpty) {
      Utils.ToastMessage('Enter Message');
    } else {
      final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      ref.child(timeStamp).set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userId.toString(),
        'receiverId': widget.receiverId,
        'type': 'Text',
        'time': timeStamp.toString()
      }).then((value) {
        messageController.clear();
      });
    }
  }
}
