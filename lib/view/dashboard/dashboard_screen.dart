import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/view/dashboard/profile.dart';
import 'package:tech_media/view/dashboard/video_call.dart';

import '../../home/homescreen.dart';
import '../../res/color.dart';
import '../../utils/routes/route_name.dart';
import '../../view_model/services/session_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      HomeScreen(),
      const Text('Chat'),
      const Text('Add'),
      VideoCall(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        activeColorPrimary: Colors.green.shade300,
        icon: const Icon(Icons.home_filled, color: Colors.black),
        inactiveIcon: Icon(Icons.home_filled, color: Colors.grey.shade700),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: Colors.green.shade300,
        icon: const Icon(Icons.chat_bubble_sharp, color: Colors.black),
        inactiveIcon:
            Icon(Icons.chat_bubble_sharp, color: Colors.grey.shade700),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: Colors.green.shade300,
        icon: const Icon(Icons.add, color: Colors.black),
        inactiveIcon: Icon(Icons.add, color: Colors.grey.shade700),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: Colors.green.shade300,
        icon: const Icon(Icons.videocam, color: Colors.black),
        inactiveIcon: Icon(Icons.videocam, color: Colors.grey.shade700),
      ),
      PersistentBottomNavBarItem(
          activeColorPrimary: Colors.green.shade300,
          icon: const Icon(Icons.person_outline, color: Colors.black),
          inactiveIcon:
              Icon(Icons.person_outline, color: Colors.grey.shade700)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _navBarItem(),
      backgroundColor: AppColors.textFieldDefaultFocus,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      navBarStyle: NavBarStyle.style10,
    );
  }
}
