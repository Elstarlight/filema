import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:filema/routes/pages.dart';
import 'package:filema/routes/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 WAJIB INI
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // const sudah BENAR

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filema App',
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,
    );
  }
}
