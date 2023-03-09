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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/call.png',
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              InputTextField(
                  myController: callingId,
                  focusNode: userNameFocusNode,
                  onFieldSubmittedValue: (value) {},
                  keyBoardType: TextInputType.emailAddress,
                  obscureText: false,
                  hint: 'Enter App Id',
                  onValidator: (value) {
                    return value.isEmpty ? 'enter App Id' : null;
                  }),
              RoundButton(
                title: 'Join Call',
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
