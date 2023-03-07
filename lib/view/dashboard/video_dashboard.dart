import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view/zego/live_streaming.dart';
import 'package:tech_media/view/zego/video_call.dart';

class VideoDashboard extends StatelessWidget {
  const VideoDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Dashboard'),
      ),
      body: Center(
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
                  children: [
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
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LiveStreaming()),
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
                  children: [
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
          ],
        ),
      ),
    );
  }
}
