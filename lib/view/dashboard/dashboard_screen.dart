import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/home/check.dart';
import 'package:tech_media/view/dashboard/messaging_screen.dart';
import 'package:tech_media/view/dashboard/profile.dart';
import 'package:tech_media/view/dashboard/profile_check.dart';
import 'package:tech_media/view/dashboard/video_dashboard.dart';
import 'package:tech_media/view/users/user_list_screen.dart';
import 'package:tech_media/view/zego/live_streaming.dart';
import 'package:tech_media/view/zego/testing.dart';
import 'package:tech_media/view/zego/video_confrence.dart';

import '../zego/audio_room.dart';
import '../zego/video_call.dart';
import 'homescreen.dart';
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
      const AllUsersScreen(),
      // const VideoCall(),
      // const VideoCall(),
      const VideoDashboard(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        activeColorPrimary: AppColors.primaryColor,
        icon: const Icon(Icons.home_filled, color: Colors.black),
        inactiveIcon: const Icon(Icons.home_filled, color: Colors.black87),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: AppColors.primaryColor,
        icon: const Icon(Icons.videocam, color: Colors.black),
        inactiveIcon: const Icon(Icons.videocam, color: Colors.black87),
      ),
      PersistentBottomNavBarItem(
          activeColorPrimary: AppColors.primaryColor,
          icon: const Icon(Icons.person_outline, color: Colors.black87),
          inactiveIcon:
              const Icon(Icons.person_outline, color: Colors.black87)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _navBarItem(),
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      navBarStyle: NavBarStyle.style7,
    );
  }
}
