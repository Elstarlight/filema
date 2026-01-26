import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:filema/pages/dashboard/dashboard_page.dart';
import 'package:filema/pages/bioskop/bioskop_page.dart';
import 'package:filema/pages/tiket/tiket_page.dart';
import 'package:filema/pages/profile/profile_page.dart';
import 'package:filema/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  final List<Widget> pages = [
    DashboardPage(),
    BioskopPage(),
    TicketPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          onTap: controller.changeTab,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: "Bioskop",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number),
              label: "Tiket",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      );
    });
  }
}
