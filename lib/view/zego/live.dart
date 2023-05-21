import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import '../../res/components/input_text_field.dart';

class LiveSt extends StatefulWidget {
  const LiveSt({Key? key}) : super(key: key);

  @override
  State<LiveSt> createState() => _LiveStState();
}

class _LiveStState extends State<LiveSt> {
  final TextEditingController streamIdController = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();

  _jumpToLivePage({required String liveID, required bool isHost}) {
    if (streamIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a stream ID'),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveScreen(liveID: liveID, isHost: isHost),
      ),
    );
  }

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
              child: const Image(
                image: AssetImage('assets/images/Back.png'),
              )),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Live Streaming',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/live-stream.png',
              // fit: BoxFit.fill,
            ),
            InputTextField(
                myController: streamIdController,
                focusNode: userNameFocusNode,
                onFieldSubmittedValue: (value) {},
                keyBoardType: TextInputType.emailAddress,
                obscureText: false,
                hint: 'Enter App Id',
                onValidator: (value) {
                  return value.isEmpty ? 'enter App Id' : null;
                }),
            // TextField(
            //   controller: streamIdController,
            //   keyboardType: TextInputType.number,
            // ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('Go Live Now'),
                  onPressed: () => _jumpToLivePage(
                    liveID: streamIdController.text,
                    isHost: true,
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(),
                  child: const Text(
                    'Watch Live Stream',
                  ),
                  onPressed: () => _jumpToLivePage(
                    liveID: streamIdController.text,
                    isHost: false,
                  ),
                ),
                // ElevatedButton(
                //   style: ButtonStyle(),
                //   child: Text(
                //     'Watch Live Stream',
                //   ),
                //   onPressed: () => _jumpToLivePage(
                //     liveID: streamIdController.text,
                //     isHost: false,
                //   ),
                // ),
              ],
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class LiveScreen extends StatelessWidget {
  const LiveScreen({Key? key, required this.liveID, this.isHost = false})
      : super(key: key);

  final bool isHost;
  final String liveID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltLiveStreaming(
      appID: 1343989995,
      appSign:
          '109c3e7765015285bceddb808544fe1ec54025374ac8dc96f0a0fa6b67f9e0a9',
      userID: "localUserID",
      userName: "localUserID",
      liveID: liveID,
      config: isHost
          ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
          : ZegoUIKitPrebuiltLiveStreamingConfig.audience()
        ..audioVideoViewConfig.showAvatarInAudioMode = true
        ..audioVideoViewConfig.showSoundWavesInAudioMode = true,
    );
  }
}
