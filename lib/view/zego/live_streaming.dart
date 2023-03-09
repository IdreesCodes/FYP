import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

import '../../res/color.dart';

//final String userID = Random().nextInt(900000 + 100000).toString();
final user = FirebaseAuth.instance.currentUser;
final userID = user?.uid;
final displayName = user?.email;

class LiveStreaming extends StatefulWidget {
  LiveStreaming({
    Key? key,
  }) : super(key: key);

  @override
  State<LiveStreaming> createState() => _LiveStreamingState();
}

class _LiveStreamingState extends State<LiveStreaming> {
  // final String userID = Random().nextInt(900000 + 100000).toString();
  // Generate Live Streaming ID with 6 digit length
  final liveIDController = TextEditingController(
    text: Random().nextInt(900000 + 100000).toString(),
  );

  @override
  Widget build(BuildContext context) {
    var buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/videoCall.png',
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Your UserID: $userID'),
            // const Text('Please test with two or more devices'),
            const SizedBox(
              height: 30,
            ),
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
            ElevatedButton(
              style: buttonStyle,
              child: const Text(
                'Start a Live',
                style: TextStyle(),
              ),
              onPressed: () => jumpToLivePage(
                context,
                liveID: liveIDController.text,
                isHost: true,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: buttonStyle,
              child: const Text('Join a Live'),
              onPressed: () => jumpToLivePage(
                context,
                liveID: liveIDController.text,
                isHost: false,
              ),
            )
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

  // Read AppID and AppSign from .env file
  // Make sure you replace with your own
  final int appID = int.parse(('1343989995'));
  final String appSign =
      ('109c3e7765015285bceddb808544fe1ec54025374ac8dc96f0a0fa6b67f9e0a9');

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
