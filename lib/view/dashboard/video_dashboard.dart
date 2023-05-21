import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view/zego/audio_room.dart';
import 'package:tech_media/view/zego/video_call.dart';
import 'package:tech_media/view/zego/video_confrence.dart';

import '../zego/live.dart';

class VideoDashboard extends StatelessWidget {
  const VideoDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController callingId = TextEditingController();
    final FocusNode userNameFocusNode = FocusNode();
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/video_logo.png'),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VideoCall()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Container(
                      height: 140,
                      child: Stack(children: [
                        Image.asset(
                          'assets/images/vid_call.png',
                          fit: BoxFit.cover,
                        ),
                      ]),
                    ),
                  ),
                  // Container(
                  //   width: 280.0,
                  //   //  height: 190,
                  //   decoration: const BoxDecoration(),
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         height: 150,
                  //         decoration: BoxDecoration(
                  //             color: Color(0xffF4BAA6),
                  //             borderRadius: BorderRadius.circular(10)),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Image(
                  //               image: AssetImage(
                  //                   'assets/images/video_call.png'),
                  //               height: 180,
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LiveSt()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Container(
                      height: 150,
                      width: 330,
                      child: Stack(alignment: Alignment.topCenter, children: [
                        Image.asset(
                          'assets/images/live_str.png',
                          fit: BoxFit.cover,
                        ),
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VideoConferencePage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Container(
                      height: 150,
                      width: 350,
                      child: Stack(alignment: Alignment.topCenter, children: [
                        Image.asset(
                          'assets/images/live_conf.png',
                          fit: BoxFit.cover,
                        ),
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    Future<String?> name = getUsernameFromFirebase();
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AudioRoomScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 21.0),
                    child: Container(
                      height: 160,
                      child: Stack(children: [
                        Image.asset(
                          'assets/images/audio_room.png',
                          fit: BoxFit.cover,
                        ),
                      ]),
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
