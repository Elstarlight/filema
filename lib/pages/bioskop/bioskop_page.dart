import 'package:flutter/material.dart';

class BioskopPage extends StatelessWidget {
  BioskopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bioskop"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Ini Halaman Bioskop",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
