import 'package:flutter/material.dart';

class TiketPage extends StatelessWidget {
  const TiketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiket'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Tab sederhana
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Tiket Aktif',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 20),
              Text(
                'Daftar Transaksi',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 50),

          // Konten kosong
          Icon(
            Icons.confirmation_number_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'Nonton Film Yuk!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Belum ada tiket.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),

        ],
      ),
    );
  }
}
