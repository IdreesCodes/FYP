import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/view/zego/live_streaming.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import 'dart:math' as math;

import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';

//final String userId = math.Random().nextInt(10000).toString();
final user = FirebaseAuth.instance.currentUser;
final userID = user?.uid;
final displayName = user?.email;

class AudioRoomScreen extends StatefulWidget {
  AudioRoomScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AudioRoomScreen> createState() => _AudioRoomScreenState();
}

class _AudioRoomScreenState extends State<AudioRoomScreen> {
  final TextEditingController callingId = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    bool Host = false;
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/images/video_conf.png'),
            height: 300,
            width: 300,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20, bottom: 5, top: 0),
            child: InputTextField(
                myController: callingId,
                focusNode: userNameFocusNode,
                onFieldSubmittedValue: (value) {},
                keyBoardType: TextInputType.emailAddress,
                obscureText: false,
                hint: 'Enter  Id',
                onValidator: (value) {
                  return value.isEmpty ? 'enter Id' : null;
                }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: RoundButton(
              title: 'Join Call as host?',
              onPress: () {
                Host = true;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LivePage(
                              roomID: callingId.text.toString(),
                              isHost: Host,
                            )));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: RoundButton(
              title: 'Join Call as audience?',
              onPress: () {
                Host = true;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LivePage(
                              roomID: callingId.text.toString(),
                            )));
              },
            ),
          )
        ],
      )),
    );
  }
}

class LivePage extends StatelessWidget {
  final String roomID;
  final bool isHost;

  const LivePage({Key? key, required this.roomID, this.isHost = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveAudioRoom(
        appID:
            148160183, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign:
            'd198ea2c797a2f7550b64e4b519eecb8b481dfe2e7e75f7bbfb3eb0ef0aaae63', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: userID.toString(),
        userName: displayName.toString(),
        roomID: roomID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
            : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience(),
      ),
    );
  }
}
