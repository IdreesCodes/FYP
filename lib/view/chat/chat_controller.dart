import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/utils.dart';
import '../../view_model/services/session_controller.dart';

class ChatController extends ChangeNotifier {
  String receiverId = "";
  final messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Chat');

  sendMessage() {
    if (messageController.text.isEmpty) {
      Utils.ToastMessage('Enter Message');
    } else {
      final timeStamp = DateTime.now();
      String time = "${timeStamp.hour}:${timeStamp.minute}";

      ref
          .child(
              "${SessionController().userId.toString()}$receiverId/${timeStamp.microsecondsSinceEpoch.toString()}")
          .set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userId.toString(),
        'receiverId': receiverId,
        'type': 'Text',
        'time': time,
      }).then((value) {
        messageController.clear();
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 150), curve: Curves.easeOut);
      });
      ref
          .child(
              "$receiverId${SessionController().userId.toString()}/${timeStamp.microsecondsSinceEpoch.toString()}")
          .set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userId.toString(),
        'receiverId': receiverId,
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
