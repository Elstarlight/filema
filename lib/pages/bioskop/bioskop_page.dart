import 'package:flutter/material.dart';
import 'bioskop_mobile.dart';
import 'bioskop_widescreen.dart';

class BioskopPage extends StatelessWidget {
  const BioskopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 📱 MOBILE
        if (constraints.maxWidth < 800) {
          return const BioskopMobile();
        }

        // 🖥 TABLET / DESKTOP
        return const BioskopWidescreen();
      },
    );
  }
}
