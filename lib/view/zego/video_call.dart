import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'dart:math' as math;

import '../../../res/components/input_text_field.dart';
import '../../../res/components/round_button.dart';

final user = FirebaseAuth.instance.currentUser;
final userID = user?.uid;
final displayName = user?.email;

class VideoCall extends StatefulWidget {
  const VideoCall({Key? key}) : super(key: key);

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final TextEditingController callingId = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image(
                image: AssetImage('assets/images/Back.png'),
              )),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Video Calling',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/videoCall.png',
                width: MediaQuery.of(context).size.width * 0.75,
              ),
              Text(
                'Please enter video call receiver ID',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 25,
              ),
              InputTextField(
                  myController: callingId,
                  focusNode: userNameFocusNode,
                  onFieldSubmittedValue: (value) {},
                  keyBoardType: TextInputType.emailAddress,
                  obscureText: false,
                  hint: 'Enter ID',
                  onValidator: (value) {
                    return value.isEmpty ? 'enter App Id' : null;
                  }),
              SizedBox(
                height: 10,
              ),
              RoundButton(
                title: 'Call',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CallPage(callID: callingId.text.toString())));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  final String callID;
  const CallPage({
    Key? key,
    required this.callID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 865675497,
        appSign:
            '446e63e71d94879525f97ddc3c91f8c7fd157538c06a127d28ff816b9db2835f',
        userID: userID.toString(),
        userName: displayName.toString(),
        callID: callID,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..onOnlySelfInRoom = (context) {
            Navigator.of(context).pop();
          },
      ),
    );
  }
}
