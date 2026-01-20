import 'package:flutter/material.dart';

class BioskopWidescreen extends StatelessWidget {
  const BioskopWidescreen({super.key});

  // 🎬 DATA BIOSKOP (10)
  static const List<String> bioskopList = [
    'KLATEN TOWN SQUARE XXI',
    'SOLO GRAND MALL XXI',
    'PARAGON MALL XXI',
    'TRANSMART SOLO XXI',
    'SOLO SQUARE XXI',
    'THE PARK SOLO XXI',
    'AMPLAZ YOGYAKARTA XXI',
    'JOGJA CITY MALL XXI',
    'HARTONO MALL XXI',
    'GALAXY MALL XXI',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔝 APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        title: SizedBox(
          width: 400,
          height: 42,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari di TIX ID',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.person_outline, color: Colors.black),
          ),
        ],
      ),

      // 🧱 BODY
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📍 Lokasi
            Row(
              children: const [
                Icon(Icons.location_on_outlined),
                SizedBox(width: 6),
                Text(
                  'KLATEN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(),

            // 🎬 LIST BIOSKOP (SCROLL)
            Expanded(
              child: ListView.separated(
                itemCount: bioskopList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.star_border),
                      title: Text(
                        bioskopList[index],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        debugPrint('Klik bioskop: ${bioskopList[index]}');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
