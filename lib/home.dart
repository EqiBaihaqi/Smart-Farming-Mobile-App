import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/nav_controller.dart';
import 'package:smart_farm/page/automation_page/automation_page.dart';
import 'package:smart_farm/page/chart_page/chart_page.dart';
import 'package:smart_farm/page/control_page/control_page.dart';
import 'package:smart_farm/page/home_page/home_page.dart';
import 'package:smart_farm/page/profile_page/profile_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.put(NavController());

    final List<Widget> pages = [
      HomePage(),
      AutomationPage(),
      ChartPage(),
      ControlPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: Obx(() => pages[navController.currentIndex.value]),
      bottomNavigationBar: PersistentTabView(
        context,
        screens: pages,
        hideNavigationBarWhenKeyboardAppears: true,
        navBarHeight: SizeDevice.getHeight(context) * 0.085,
        items: [
          PersistentBottomNavBarItem(
            icon: Icon(Icons.home),
            title: 'Home',
            activeColorPrimary: foundationBlueColor,
            activeColorSecondary: foundationBlueColor,
            inactiveColorPrimary: foundationGreyColor,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(Icons.auto_awesome),
            title: 'Automation',
            activeColorPrimary: foundationBlueColor,
            activeColorSecondary: foundationBlueColor,
            inactiveColorPrimary: foundationGreyColor,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            title: 'Chart',
            activeColorPrimary: foundationBlueColor,
            activeColorSecondary: foundationBlueColor,
            inactiveColorPrimary: foundationGreyColor,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(Icons.settings),
            title: 'Control',
            activeColorPrimary: foundationBlueColor,
            activeColorSecondary: foundationBlueColor,
            inactiveColorPrimary: foundationGreyColor,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(Icons.person),
            title: 'Profile',
            activeColorPrimary: foundationBlueColor,
            activeColorSecondary: foundationBlueColor,
            inactiveColorPrimary: foundationGreyColor,
          ),
        ],
        onItemSelected: (value) {
          navController.currentIndex.value = value;
        },
      ),
    );
  }
}
