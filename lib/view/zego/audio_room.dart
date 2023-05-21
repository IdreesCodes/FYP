import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import 'dart:math' as math;
import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';

final user = FirebaseAuth.instance.currentUser;
final userID = user?.uid;
final displayName = user?.email;

class AudioRoomScreen extends StatefulWidget {
  const AudioRoomScreen({
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
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Image(
                image: AssetImage('assets/images/Back.png'),
              )),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            'Audio Room',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Image(
                image: const AssetImage('assets/images/audio.png'),
                width: MediaQuery.of(context).size.width * 0.70,
              ),
            ),
            Text(
              'Join or start an Audio Call, Enter ID ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, bottom: 5, top: 0),
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
                title: 'Join as Host',
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
                title: 'Join as Audience',
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
      ),
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
