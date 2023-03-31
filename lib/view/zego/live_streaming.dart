import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

import '../../res/color.dart';
import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';

//final String userID = Random().nextInt(900000 + 100000).toString();
final user = FirebaseAuth.instance.currentUser;
final userID = user?.uid;
final displayName = user?.email;

class LiveStream extends StatefulWidget {
  const LiveStream({
    Key? key,
  }) : super(key: key);

  @override
  State<LiveStream> createState() => _LiveStreamState();
}

class _LiveStreamState extends State<LiveStream> {
  // final String userID = Random().nextInt(900000 + 100000).toString();
  // Generate Live Streaming ID with 6 digit length
  final liveIDController = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/live-stream.png',
              width: MediaQuery.of(context).size.width * 0.90,
            ),

            // const Text('Please test with two or more devices'),
            InputTextField(
                myController: liveIDController,
                focusNode: userNameFocusNode,
                onFieldSubmittedValue: (value) {},
                keyBoardType: TextInputType.emailAddress,
                obscureText: false,
                hint: 'Enter App Id',
                onValidator: (value) {
                  return value.isEmpty ? 'enter App Id' : null;
                }),
            TextFormField(
              controller: liveIDController,
              decoration: const InputDecoration(
                labelText: 'Join or Start a Live by Input an ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            const SizedBox(
              height: 16,
            ),
            RoundButton(
              title: 'Join Live',
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => jumpToLivePage(
                        context,
                        liveID: liveIDController.text,
                        isHost: false,
                      ),
                    ));
              },
            ),

            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  // Go to Live Page
  jumpToLivePage(BuildContext context,
      {required String liveID, required bool isHost}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivePage(
          liveID: liveID,
          isHost: isHost,
        ),
      ),
    );
  }
}

// Live Page Prebuilt UI from ZEGOCLOUD UIKits
class LivePage extends StatelessWidget {
  final String liveID;
  final bool isHost;

  LivePage({
    Key? key,
    required this.liveID,
    this.isHost = false,
  }) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 1343989995,
        appSign:
            '109c3e7765015285bceddb808544fe1ec54025374ac8dc96f0a0fa6b67f9e0a9',
        userID: userID.toString(),
        userName: displayName.toString(),
        liveID: liveID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience()
          ..audioVideoViewConfig.showAvatarInAudioMode = true
          ..audioVideoViewConfig.showSoundWavesInAudioMode = true,
      ),
    );
  }
}

Future<String?> getUsernameFromFirebase() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user != null && user.displayName != null) {
    return user.displayName;
  } else {
    // User is not signed in or display name is not set
    return null;
  }
}
