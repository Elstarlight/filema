import 'package:get/get.dart';
import 'package:filema/routes/route.dart';
import 'package:filema/pages/home/home_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
    ),
  ];
}
