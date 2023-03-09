import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'dart:math' as math;
import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';

final String userId = math.Random().nextInt(10000).toString();

class VideoConferencePage extends StatefulWidget {
  const VideoConferencePage({
    Key? key,
  }) : super(key: key);

  @override
  State<VideoConferencePage> createState() => _VideoConferencePageState();
}

class _VideoConferencePageState extends State<VideoConferencePage> {
  final TextEditingController callingId = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
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
              title: 'Join Call',
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoConfCallPage(
                            callID: callingId.text.toString())));
              },
            ),
          )
        ],
      )),
    );
  }
}

class VideoConfCallPage extends StatelessWidget {
  final String callID;
  const VideoConfCallPage({Key? key, required this.callID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ZegoUIKitPrebuiltVideoConference(
          appID:
              579143381, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
          appSign:
              '7828fbd7e7d881d70873f0a450474f925ec7ed777bd34bfd5e765f615385b2b7', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
          userID: userId.toString(),
          userName: 'user_name${userId}',
          conferenceID: callID,
          config: ZegoUIKitPrebuiltVideoConferenceConfig(),
        ),
      ),
    );
  }
}
