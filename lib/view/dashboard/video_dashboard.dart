import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view/zego/audio_room.dart';
import 'package:tech_media/view/zego/live_streaming.dart';
import 'package:tech_media/view/zego/video_call.dart';
import 'package:tech_media/view/zego/video_confrence.dart';

import '../zego/live.dart';
import '../zego/testing.dart';

class VideoDashboard extends StatelessWidget {
  const VideoDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController callingId = TextEditingController();
    final FocusNode userNameFocusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoCall()),
                    );
                  },
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: AppColors.grayColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.video_chat,
                          size: 50.0,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Video Call',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LiveSt()),
                    );
                  },
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: AppColors.grayColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.live_tv_sharp,
                          size: 50.0,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Live Streaming',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VideoConferencePage()),
                    );
                  },
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: AppColors.grayColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.switch_video_sharp,
                          size: 50.0,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Video Conference',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    Future<String?> name = getUsernameFromFirebase();
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AudioRoomScreen()),
                    );
                  },
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: AppColors.grayColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.record_voice_over,
                          size: 50.0,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Audio Room',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<String?> getUsernameFromFirebase() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user != null && user.displayName != null) {
    if (kDebugMode) {
      print(user.email);
    }
    return user.email;
  } else {
    // User is not signed in or display name is not set
    return null;
  }
}
