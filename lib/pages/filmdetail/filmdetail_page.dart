import 'dart:convert';
import 'package:filema/helper/local_ticket_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> filmData;

  const DetailPage({super.key, required this.filmData});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isLoading = false;

  Future<void> _startPayment(double amount) async {
    const String endpoint =
        'https://rory-nonconcentrative-pointedly.ngrok-free.dev/generate-token';

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': amount}),
      );

      if (response.statusCode != 200) throw Exception('Server error');

      final data = jsonDecode(response.body);
      final redirectUrl = data['redirect_url'];
      if (redirectUrl == null) throw Exception('No redirect_url');

      if (await canLaunchUrl(Uri.parse(redirectUrl))) {
        await launchUrl(Uri.parse(redirectUrl), mode: LaunchMode.inAppWebView);
      }

      // Simpan tiket ke lokal setelah pembayaran (anggap sukses sandbox)
      await LocalTicketService.saveTicket({
        'title': widget.filmData['title'],
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
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.filmData;
    final price = (data['price'] as num?)?.toDouble() ?? 0;

    return Scaffold(
      appBar: AppBar(title: Text(data['title'] ?? 'Detail Film')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            data['posterUrl'] != null && data['posterUrl'] != ''
                ? Image.network(data['posterUrl'], height: 250)
                : const Icon(Icons.movie, size: 100),
            const SizedBox(height: 20),
            Text(data['description'] ?? '-', textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Text('Harga: Rp$price'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: _isLoading
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.payment),
              label: Text(_isLoading ? 'Memproses...' : 'Beli Tiket'),
              onPressed: _isLoading ? null : () => _startPayment(price),
            ),
          ],
        ),
      ),
    );
  }
}
