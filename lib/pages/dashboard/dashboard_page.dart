import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Ini Halaman Dashboard",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
