import 'package:flutter/material.dart';
import 'package:tech_media/home/post.dart';
import 'package:tech_media/home/story.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: const [
          Story(),
          Expanded(child: Post()),
        ],
      ),
    );
  }
}
