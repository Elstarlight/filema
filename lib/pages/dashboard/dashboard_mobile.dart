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
      backgroundColor: Colors.grey.shade100,

      // 🔝 APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Sedang Tayang',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
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

      // 📡 FIRESTORE STREAM
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

          return Column(
            children: [
              // 🎬 LIST FILM
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: docs.length,
                  itemBuilder: (context, i) {
                    final data = docs[i].data() as Map<String, dynamic>;

                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(filmData: data),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // 🎬 POSTER
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.horizontal(
                                left: Radius.circular(20),
                              ),
                              child: data['posterUrl'] != null &&
                                      data['posterUrl'] != ''
                                  ? Image.network(
                                      data['posterUrl'],
                                      width: 110,
                                      height: 160,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 110,
                                      height: 160,
                                      color: Colors.grey.shade300,
                                      child: const Icon(
                                        Icons.movie,
                                        size: 48,
                                      ),
                                    ),
                            ),

                            // 📄 INFO
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    // 🎞 TITLE
                                    Text(
                                      data['title'] ?? '-',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    // ⭐ RATING BADGE
                                    Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange
                                            .withOpacity(0.15),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize:
                                            MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 14,
                                            color: Colors.orange,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${data['rating'] ?? '-'}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    // 💰 PRICE CHIP
                                    Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green
                                            .withOpacity(0.12),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Rp${data['price']}',
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // ➡️ ICON
                            const Padding(
                              padding:
                                  EdgeInsets.only(right: 12),
                              child: Icon(
                                Icons.chevron_right,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 👇 FOOTER ANTI KOSONG
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 20),
                color: Colors.grey.shade100,
                child: Column(
                  children: const [
                    Icon(
                      Icons.local_movies_outlined,
                      size: 36,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Nikmati pengalaman nonton terbaik',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Pesan tiket film favoritmu sekarang',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
