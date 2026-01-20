import 'package:filema/pages/tiket/tiket_page.dart';
import 'package:filema/routes/route.dart';
import 'package:filema/pages/dashboard/dashboard_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
    ),

    GetPage(
      name: AppRoutes.tiket,
      page: () => TiketPage(),
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
    ),
  ];
}
