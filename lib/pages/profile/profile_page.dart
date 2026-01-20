import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filema/controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),

            SizedBox(height: 16),

            Obx(() => Text(
              controller.name.value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),

            SizedBox(height: 4),

            Obx(() => Text(
              controller.email.value,
              style: TextStyle(color: Colors.grey),
            )),

            SizedBox(height: 24),

            // ================= DATA PROFILE =================
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Obx(() => ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Nama"),
                    subtitle: Text(controller.name.value),
                  )),
                  Divider(height: 1),
                  Obx(() => ListTile(
                    leading: Icon(Icons.email),
                    title: Text("Email"),
                    subtitle: Text(controller.email.value),
                  )),
                  Divider(height: 1),
                  Obx(() => ListTile(
                    leading: Icon(Icons.phone),
                    title: Text("No. Telepon"),
                    subtitle: Text(controller.phone.value),
                  )),
                ],
              ),
            ),

            SizedBox(height: 24),

            // ================= MENU =================
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [

                  // CRUD FILM (ADMIN)
                  Obx(() => controller.isAdmin.value
                      ? ListTile(
                          leading: Icon(Icons.movie_creation),
                          title: Text("CRUD Film"),
                          subtitle: Text("Kelola data film"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: controller.goToCrudFilm,
                        )
                      : SizedBox()
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Pengaturan"),
                    onTap: controller.goToSettings,
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text("Tentang Aplikasi"),
                    onTap: controller.goToAbout,
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text("Logout", style: TextStyle(color: Colors.red)),
                    onTap: controller.logout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
