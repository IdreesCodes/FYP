import 'package:bubble/bubble.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
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
  ScrollController scrollController = ScrollController();
  getDate() {
    DatabaseReference refe = FirebaseDatabase.instance.ref().child(
        'Chat/${SessionController().userId.toString()}${widget.receiverId}');
    refe.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print("data in chat responce:");

      print(data);
    });
  }

  @override
  void initState() {
    getDate();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.name.toString()),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.menu_rounded),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
              height: 50,
              width: 50,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    200), // radius of 10green as background color
              ),
              child: widget.image == ""
                  ? Image.asset("assets/images/user.png")
                  : Image.network(
                      widget.image,
                      fit: BoxFit.cover,
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
                child: FirebaseAnimatedList(
              controller: scrollController,
              query: FirebaseDatabase.instance.ref().child(
                  'Chat/${SessionController().userId.toString()}${widget.receiverId}'),
              itemBuilder: (context, snapshot, animation, index) {
                if (SessionController().userId.toString() !=
                    snapshot.child('sender').value.toString()) {
                  return Bubble(
                    margin: const BubbleEdges.only(top: 10),
                    alignment: Alignment.topLeft,
                    nip: BubbleNip.leftTop,
                    child: Text(snapshot.child('message').value.toString()),
                  );
                } else {
                  return Bubble(
                    margin: const BubbleEdges.only(top: 10, left: 100),
                    alignment: Alignment.topRight,
                    nip: BubbleNip.rightTop,
                    color: const Color.fromRGBO(225, 255, 199, 1.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(snapshot.child('message').value.toString(),
                              textAlign: TextAlign.left),
                          Text(
                            snapshot.child('time').value.toString(),
                            style: TextStyle(fontSize: 10),
                            textAlign: TextAlign.right,
                            //textAlign: TextAlign.right
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            )),
            const SizedBox(
              height: 10,
            ),
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
      final timeStamp = DateTime.now();
      String time = "${timeStamp.hour}:${timeStamp.minute}";

      ref
          .child(
              "${SessionController().userId.toString()}${widget.receiverId}/${timeStamp.microsecondsSinceEpoch.toString()}")
          .set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userId.toString(),
        'receiverId': widget.receiverId,
        'type': 'Text',
        'time': time,
      }).then((value) {
        messageController.clear();
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 150), curve: Curves.easeOut);
      });
      ref
          .child(
              "${widget.receiverId}${SessionController().userId.toString()}/${timeStamp.microsecondsSinceEpoch.toString()}")
          .set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userId.toString(),
        'receiverId': widget.receiverId,
        'type': 'Text',
        'time': time,
      }).then((value) {
        messageController.clear();
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 150), curve: Curves.easeOut);
      });
    }
  }
}
