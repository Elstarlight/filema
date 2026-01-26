import 'package:flutter/material.dart';

class FilmDetailWidescreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final double price;
  final ValueNotifier<bool> isLoading;
  final VoidCallback onBuy;

  const FilmDetailWidescreen({
    super.key,
    required this.data,
    required this.price,
    required this.isLoading,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _poster(),
          const SizedBox(width: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['title'] ?? '',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text(data['description'] ?? '-'),
                const SizedBox(height: 24),
                Text(
                  'Harga: Rp$price',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buyButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _poster() {
    return data['posterUrl'] != null && data['posterUrl'] != ''
        ? Image.network(data['posterUrl'], height: 380)
        : const Icon(Icons.movie, size: 180);
  }

  Widget _buyButton() {
    return ValueListenableBuilder<bool>(
      valueListenable: isLoading,
      builder: (_, loading, __) {
        return ElevatedButton.icon(
          icon: loading
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.payment),
          label: Text(loading ? 'Memproses...' : 'Beli Tiket'),
          onPressed: loading ? null : onBuy,
        );
      },
    );
  }
}
