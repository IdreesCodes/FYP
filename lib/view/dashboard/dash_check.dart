import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class AnimatedDashboard extends StatefulWidget {
  const AnimatedDashboard({Key? key}) : super(key: key);

  @override
  _AnimatedDashboardState createState() => _AnimatedDashboardState();
}

class _AnimatedDashboardState extends State<AnimatedDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: _animation,
            child: Container(
              width: 150.0,
              height: 150.0,
              color: Colors.black45,
              child: const Center(child: Text('Widget 1')),
            ),
          ),
          SlideTransition(
            position: _animation,
            child: Container(
              width: 150.0,
              height: 150.0,
              color: Colors.blue,
              child: const Center(child: Text('Widget 2')),
            ),
          ),
        ],
      ),
    );
  }
}
