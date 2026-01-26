import 'package:flutter/material.dart';

class FilmDetailMobile extends StatelessWidget {
  final Map<String, dynamic> data;
  final double price;
  final ValueNotifier<bool> isLoading;
  final VoidCallback onBuy;

  // 🔹 ganti state dengan ValueNotifier
  final ValueNotifier<int> selectedTab = ValueNotifier(0);

  FilmDetailMobile({
    super.key,
    required this.data,
    required this.price,
    required this.isLoading,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _header(),
          _content(context),
        ],
      ),
      bottomNavigationBar: _bottomBuy(),
    );
  }

  // 🌈 HEADER
  Widget _header() {
    return Container(
      height: 260,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0F2027),
            Color(0xFF203A43),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  // 📦 CONTENT
  Widget _content(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 200),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _movieInfo(context),
              const SizedBox(height: 20),
              _tabs(),
              const SizedBox(height: 12),
              _tabContent(),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  // 🎬 MOVIE INFO
  Widget _movieInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                data['posterUrl'] ?? '',
                width: 115,
                height: 170,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 115,
                  height: 170,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.movie, size: 40),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'] ?? '-',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Genre: ${data['genre'] ?? '-'}'),
                  Text('Durasi: ${data['duration'] ?? '02.15'}'),
                  Text('Sutradara: ${data['director'] ?? 'Mamang'}'),
                  const SizedBox(height: 14),

                  // ▶️ NONTON TRAILER
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Nonton Trailer'),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // 🔥 GARIS FULL KIRI → KANAN
        const SizedBox(height: 12),
        Transform.translate(
          offset: const Offset(-20, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 4,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.deepPurple,
                  Colors.blue,
                  Colors.cyan,
                ],
              ),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    );
  }

  // 📑 TABS
  Widget _tabs() {
    return ValueListenableBuilder<int>(
      valueListenable: selectedTab,
      builder: (_, tab, __) {
        return Row(
          children: [
            _tabItem('SINOPSIS', 0, tab),
            _tabItem('JADWAL', 1, tab),
          ],
        );
      },
    );
  }

  Widget _tabItem(String text, int index, int activeTab) {
    final active = index == activeTab;

    return Expanded(
      child: InkWell(
        onTap: () => selectedTab.value = index,
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
                color: active ? Colors.blue : Colors.black54,
              ),
            ),
            const SizedBox(height: 6),
            if (active)
              Container(
                height: 3,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _tabContent() {
    return ValueListenableBuilder<int>(
      valueListenable: selectedTab,
      builder: (_, tab, __) {
        if (tab == 0) {
          return Text(
            data['description'] ?? '-',
            style: const TextStyle(height: 1.6),
          );
        }
        return const Text('Jadwal belum tersedia');
      },
    );
  }

  // 🎟️ BUY BUTTON
  Widget _bottomBuy() {
    return ValueListenableBuilder<bool>(
      valueListenable: isLoading,
      builder: (_, loading, __) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: loading ? null : onBuy,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: loading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    'Beli Tiket • Rp$price',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
