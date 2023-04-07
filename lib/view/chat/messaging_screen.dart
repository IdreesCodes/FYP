import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/view/chat/chat_controller.dart';
import 'package:tech_media/view/chat/custom_chat.dart';
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
  @override
  Widget build(BuildContext context) {
    final chatController = Provider.of<ChatController>(context);
    chatController.receiverId = widget.receiverId;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: CustomChat(
            chatController: chatController,
          )),
          Row(
            children: [
              Expanded(
                  child: Container(
                margin: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: chatController.messageController,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(height: 0, fontSize: 18),
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          chatController.sendMessage();
                        },
                        child: const CircleAvatar(
                          child: Icon(Icons.send_outlined),
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'Enter Message...',
                    hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                        height: 0,
                        color: AppColors.primaryTextTextColor.withOpacity(0.8)),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.textFieldDefaultFocus),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondaryColor),
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
            ],
          ),
        ],
      ),
    );
  }
}
