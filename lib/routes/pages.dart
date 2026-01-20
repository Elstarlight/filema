import 'package:filema/pages/crud/crud_page.dart';
import 'package:get/get.dart';
import 'package:filema/routes/route.dart';
import 'package:filema/pages/home/home_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
    ),
    
      GetPage(
      name: AppRoutes.crudFilm,
      page: () => CrudPage(),
    ),
  ];
}
