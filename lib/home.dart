import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/nav_controller.dart';
import 'package:smart_farm/page/automation_page/automation_page.dart';
import 'package:smart_farm/page/chart_page/chart_page2.dart';
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
      ProfilePage(),
    ];

    return Scaffold(
      body: Obx(() => pages[navController.currentIndex.value]),
      bottomNavigationBar: Container(
        color: indigoColor,
        child: GNav(
          tabs: [
            GButton(icon: Icons.home, text: 'Home', style: GnavStyle.oldSchool),
            GButton(icon: Icons.auto_awesome, text: 'Automation'),
            GButton(icon: Icons.bar_chart, text: 'Chart'),
            GButton(icon: Icons.person, text: 'Profile'),
          ],
          activeColor: whiteColor,
          textStyle: defaultTextStyle.copyWith(
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          gap: 6.0,
          selectedIndex: navController.currentIndex.value,
          onTabChange: (index) => navController.changePage(index),
        ),
      ),
    );
  }
}
