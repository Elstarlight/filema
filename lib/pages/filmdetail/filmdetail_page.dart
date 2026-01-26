import 'dart:convert';
import 'package:filema/helper/local_ticket_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'filmdetail_mobile.dart';
import 'filmdetail_widescreen.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> filmData;

  DetailPage({super.key, required this.filmData});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> startPayment(
    BuildContext context,
    double amount,
  ) async {
    const String endpoint =
        'https://rory-nonconcentrative-pointedly.ngrok-free.dev/generate-token';

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': amount}),
      );

      if (response.statusCode != 200) {
        throw Exception('Server error');
      }

      final data = jsonDecode(response.body);
      final redirectUrl = data['redirect_url'];
      if (redirectUrl == null) throw Exception('No redirect_url');

      await launchUrl(
        Uri.parse(redirectUrl),
        mode: LaunchMode.inAppWebView,
      );

      await LocalTicketService.saveTicket({
        'title': filmData['title'],
        'price': amount,
        'purchasedAt': DateTime.now().toIso8601String(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tiket berhasil disimpan.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal: $e')),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final price = (filmData['price'] as num?)?.toDouble() ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(filmData['title'] ?? 'Detail Film'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth < 700
              ? FilmDetailMobile(
                  data: filmData,
                  price: price,
                  isLoading: isLoading,
                  onBuy: () => startPayment(context, price),
                )
              : FilmDetailWidescreen(
                  data: filmData,
                  price: price,
                  isLoading: isLoading,
                  onBuy: () => startPayment(context, price),
                );
        },
      ),
    );
  }
}
