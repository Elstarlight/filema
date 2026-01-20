import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CrudController extends GetxController {
  final CollectionReference filmsCollection =
      FirebaseFirestore.instance.collection('films');

  // ================= GET =================
  Stream<QuerySnapshot> getFilms() {
    return filmsCollection.orderBy('createdAt', descending: true).snapshots();
  }

  // ================= ADD =================
  Future<void> addFilm({
    required String title,
    required String description,
    required double price,
    required double rating,
    required String genre,
    required int minAge,
    String? posterUrl,
  }) async {
    if (title.isEmpty || description.isEmpty) {
      Get.snackbar('Error', 'Judul dan deskripsi wajib diisi');
      return;
    }

    if (rating < 0 || rating > 5) {
      Get.snackbar('Error', 'Rating harus 0 - 5');
      return;
    }

    if (price < 0) {
      Get.snackbar('Error', 'Harga tidak boleh negatif');
      return;
    }

    try {
      await filmsCollection.add({
        'title': title,
        'description': description,
        'price': price,
        'rating': rating,
        'genre': genre,
        'minAge': minAge,
        'posterUrl': posterUrl ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar('Sukses', 'Film berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // ================= UPDATE / EDIT =================
  Future<void> updateFilm({
    required String id,
    required String title,
    required String description,
    required double price,
    required double rating,
    required String genre,
    required int minAge,
    String? posterUrl,
  }) async {
    if (title.isEmpty || description.isEmpty) {
      Get.snackbar('Error', 'Judul dan deskripsi wajib diisi');
      return;
    }

    if (rating < 0 || rating > 5) {
      Get.snackbar('Error', 'Rating harus 0 - 5');
      return;
    }

    if (price < 0) {
      Get.snackbar('Error', 'Harga tidak boleh negatif');
      return;
    }

    try {
      await filmsCollection.doc(id).update({
        'title': title,
        'description': description,
        'price': price,
        'rating': rating,
        'genre': genre,
        'minAge': minAge,
        'posterUrl': posterUrl ?? '',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar('Sukses', 'Film berhasil diperbarui');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // ================= DELETE =================
  Future<void> deleteFilm(String id) async {
    try {
      await filmsCollection.doc(id).delete();
      Get.snackbar('Sukses', 'Film berhasil dihapus');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
