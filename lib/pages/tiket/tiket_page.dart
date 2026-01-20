import 'package:flutter/material.dart';

class TiketPage extends StatelessWidget {
  TiketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tiket"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Ini Halaman Tiket",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
