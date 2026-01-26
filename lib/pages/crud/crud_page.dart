import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controllers/crud_controller.dart';

class CrudPage extends StatelessWidget {
  CrudPage({super.key});

  final CrudController controller = Get.put(CrudController());

  final titleC = TextEditingController();
  final descC = TextEditingController();
  final priceC = TextEditingController();
  final ratingC = TextEditingController();
  final posterUrlC = TextEditingController();

  final RxString selectedGenre = "".obs;
  final RxInt selectedMinAge = 12.obs;

  final List<String> genres = ["Action", "Comedy", "Horror", "Drama", "Romance"];
  final List<int> minAges = [12, 17, 20];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CRUD Film")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.getFilms(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data?.docs;
            if (docs == null || docs.isEmpty) {
              return const Center(child: Text("Belum ada film"));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: docs.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                final poster = data["posterUrl"] ?? "";

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== POSTER =====
                    Container(
                      width: 90,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: _buildPoster(poster),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // ===== INFO + BUTTON =====
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data["title"] ?? "-",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data["description"] ?? "-",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "${data["genre"]} • "
                            "${data["rating"]} ⭐ • "
                            "Rp${data["price"]} • "
                            "Min ${data["minAge"]}+",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 8),

                          // ===== BUTTON EDIT & HAPUS =====
                          Row(
                            children: [
                              SizedBox(
                                height: 34,
                                child: OutlinedButton.icon(
                                  icon: const Icon(Icons.edit, size: 16),
                                  label: const Text(
                                    "Edit",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () => _showEditDialog(
                                    context,
                                    docs[index].id,
                                    data,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                height: 34,
                                child: OutlinedButton.icon(
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 16,
                                    color: Colors.red,
                                  ),
                                  label: const Text(
                                    "Hapus",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.red,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    side: const BorderSide(color: Colors.red),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () =>
                                      controller.deleteFilm(docs[index].id),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  // ================= POSTER =================
  Widget _buildPoster(String poster) {
    try {
      if (poster.isEmpty) return _placeholder();

      if (poster.startsWith("http")) {
        return Image.network(
          poster,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _placeholder(),
        );
      }

      final bytes = base64Decode(poster);
      return Image.memory(bytes, fit: BoxFit.contain);
    } catch (_) {
      return _placeholder();
    }
  }

  Widget _placeholder() {
    return const Center(
      child: Icon(Icons.movie, size: 40, color: Colors.grey),
    );
  }

  // ================= ADD =================
  void _showAddDialog(BuildContext context) {
    titleC.clear();
    descC.clear();
    priceC.clear();
    ratingC.clear();
    posterUrlC.clear();

    selectedGenre.value = genres.first;
    selectedMinAge.value = minAges.first;

    Get.dialog(_filmDialog(
      context,
      title: "Tambah Film",
      buttonText: "Simpan",
      onSubmit: () {
        controller.addFilm(
          title: titleC.text.trim(),
          description: descC.text.trim(),
          price: double.tryParse(priceC.text) ?? 0,
          rating: double.tryParse(ratingC.text) ?? 0,
          genre: selectedGenre.value,
          minAge: selectedMinAge.value,
          posterUrl: posterUrlC.text.trim().isEmpty
              ? null
              : posterUrlC.text.trim(),
        );
        Get.back();
      },
    ));
  }

  // ================= EDIT =================
  void _showEditDialog(
      BuildContext context, String id, Map<String, dynamic> data) {
    titleC.text = data["title"] ?? "";
    descC.text = data["description"] ?? "";
    priceC.text = data["price"].toString();
    ratingC.text = data["rating"].toString();
    posterUrlC.text = data["posterUrl"] ?? "";

    selectedGenre.value = data["genre"];
    selectedMinAge.value = data["minAge"];

    Get.dialog(_filmDialog(
      context,
      title: "Edit Film",
      buttonText: "Update",
      onSubmit: () {
        controller.updateFilm(
          id: id,
          title: titleC.text.trim(),
          description: descC.text.trim(),
          price: double.tryParse(priceC.text) ?? 0,
          rating: double.tryParse(ratingC.text) ?? 0,
          genre: selectedGenre.value,
          minAge: selectedMinAge.value,
          posterUrl: posterUrlC.text.trim(),
        );
        Get.back();
      },
    ));
  }

  // ================= DIALOG UI =================
  Widget _filmDialog(
    BuildContext context, {
    required String title,
    required String buttonText,
    required VoidCallback onSubmit,
  }) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: titleC, decoration: const InputDecoration(labelText: "Judul")),
            TextField(controller: descC, decoration: const InputDecoration(labelText: "Deskripsi")),
            TextField(controller: priceC, decoration: const InputDecoration(labelText: "Harga")),
            TextField(controller: ratingC, decoration: const InputDecoration(labelText: "Rating")),
            TextField(
                controller: posterUrlC,
                decoration:
                    const InputDecoration(labelText: "URL / Base64 Poster")),
            const SizedBox(height: 10),
            const Text("Genre"),
            Obx(() => Wrap(
                  spacing: 8,
                  children: genres
                      .map((g) => ChoiceChip(
                            label: Text(g),
                            selected: selectedGenre.value == g,
                            onSelected: (_) => selectedGenre.value = g,
                          ))
                      .toList(),
                )),
            const SizedBox(height: 10),
            const Text("Usia Minimal"),
            Obx(() => Wrap(
                  spacing: 8,
                  children: minAges
                      .map((a) => ChoiceChip(
                            label: Text("$a+"),
                            selected: selectedMinAge.value == a,
                            onSelected: (_) => selectedMinAge.value = a,
                          ))
                      .toList(),
                )),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSubmit,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
