import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:filema/routes/route.dart';

class ProfileController extends GetxController {

  // ================= DATA PROFILE =================
  var name = "Nathanael".obs;
  var email = "nathanael@email.com".obs;
  var phone = "08xxxxxxxxxx".obs;

  // ================= ROLE / AKSES =================
  var isAdmin = true.obs;

  // ================= ACTION =================

  // 👉 LOGOUT = KELUAR DARI APLIKASI
  void logout() {
    Get.snackbar(
      "Logout",
      "Aplikasi ditutup",
      snackPosition: SnackPosition.BOTTOM,
    );

    Future.delayed(Duration(milliseconds: 500), () {
      SystemNavigator.pop(); // keluar dari app
    });
  }

  // 👉 KE HALAMAN CRUD FILM
  void goToCrudFilm() {
    Get.toNamed(AppRoutes.crudFilm);
  }

  // DIBIARIN DULU
  void goToSettings() {}

  void goToAbout() {}
}
