import 'package:flutter/material.dart';
import 'dashboard_mobile.dart';
import 'dashboard_widescreen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Mobile
          if (constraints.maxWidth < 700) {
            return const DashboardMobile();
          }
          // Tablet / Desktop / Web
          else {
            return const DashboardWidescreen();
          }
        },
      ),
    );
  }
}
