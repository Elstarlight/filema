import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

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

            // ================= FOTO PROFILE =================
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurple,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 16),

            Text(
              "Nathanael",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 4),

            Text(
              "nathanael@email.com",
              style: TextStyle(color: Colors.grey),
            ),

            SizedBox(height: 24),

            // ================= CARD DATA PROFILE =================
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Nama"),
                    subtitle: Text("Nathanael"),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text("Email"),
                    subtitle: Text("nathanael@email.com"),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text("No. Telepon"),
                    subtitle: Text("08xxxxxxxxxx"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // ================= BUTTON MENU =================
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [

                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Pengaturan"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: ke halaman setting
                    },
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text("Tentang Aplikasi"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: ke halaman about
                    },
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text(
                      "Logout",
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      // TODO: logout
                    },
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
