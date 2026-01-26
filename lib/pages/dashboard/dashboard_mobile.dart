import 'package:filema/pages/filmdetail/filmdetail_page.dart';
import 'package:filema/pages/tiket/tiket_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardMobile extends StatelessWidget {
  const DashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final films = FirebaseFirestore.instance.collection('films');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Film'),
        actions: [
          IconButton(
            icon: const Icon(Icons.confirmation_num_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TicketPage()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: films.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text('Belum ada film.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final data = docs[i].data() as Map<String, dynamic>;
              return ListTile(
                leading: data['posterUrl'] != null && data['posterUrl'] != ''
                    ? Image.network(data['posterUrl'], width: 50, fit: BoxFit.cover)
                    : const Icon(Icons.movie),
                title: Text(data['title'] ?? '-'),
                subtitle: Text('Rp${data['price']} • ⭐${data['rating']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(filmData: data),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
