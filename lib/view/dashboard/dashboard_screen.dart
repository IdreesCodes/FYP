import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/view/dashboard/messaging_screen.dart';
import 'package:tech_media/view/dashboard/profile.dart';
import 'package:tech_media/view/dashboard/video_dashboard.dart';
import '../../res/color.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _settingController;
  late AnimationController _videoController;
  late AnimationController _menuController;

  @override
  void initState() {
    super.initState();

    _settingController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _videoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _menuController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _settingController.dispose();
    _videoController.dispose();
    _menuController.dispose();

    super.dispose();
  }

  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      const AllUsersScreen(),
      const VideoDashboard(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        onPressed: (context) {
          HapticFeedback.mediumImpact();
          controller.jumpToTab(0);
          _menuController.reset();
          _menuController.forward();
        },
        activeColorPrimary: AppColors.primaryColor,
        icon: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Lottie.asset(Icons8.chat_message, controller: _menuController),
        ),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: AppColors.primaryColor,
        onPressed: (context) {
          HapticFeedback.heavyImpact();
          controller.jumpToTab(1);
          _videoController.reset();
          _videoController.forward();
        },
        icon: Padding(
          padding: const EdgeInsets.all(9.0),
          child:
              Lottie.asset(Icons8.live_video_on, controller: _videoController),
        ),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: AppColors.primaryColor,
        onPressed: (context) {
          HapticFeedback.heavyImpact();
          controller.jumpToTab(2);
          _settingController.reset();
          _settingController.forward();
        },
        icon: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Lottie.asset(Icons8.adjust, controller: _settingController),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: controller,
        screens: _buildScreen(),
        items: _navBarItem(),
        backgroundColor: Colors.white,
        padding: NavBarPadding.all(6),
        margin: EdgeInsets.only(top: 5),
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        navBarStyle: NavBarStyle.style14,
      ),
    );
  }
}
