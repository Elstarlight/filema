import 'package:flutter/material.dart';

class BioskopMobile extends StatefulWidget {
  const BioskopMobile({super.key});

  @override
  State<BioskopMobile> createState() => _BioskopMobileState();
}

class _BioskopMobileState extends State<BioskopMobile> {
  // 🎬 Data bioskop
  final List<String> bioskopList = [
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

  // ⭐ Status favorit
  late List<bool> favoriteList;

  @override
  void initState() {
    super.initState();
    favoriteList = List.generate(bioskopList.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Cari di TIX ID',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.person_outline, color: Colors.black),
            ),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📍 Lokasi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: const [
                Icon(Icons.location_on_outlined, size: 20),
                SizedBox(width: 6),
                Text(
                  'KLATEN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),

          const Divider(height: 1),

          // 🎬 LIST BIOSKOP
          Expanded(
            child: ListView.separated(
              itemCount: bioskopList.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: IconButton(
                    icon: Icon(
                      favoriteList[index]
                          ? Icons.star
                          : Icons.star_border,
                      color: favoriteList[index]
                          ? Colors.orange
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        favoriteList[index] = !favoriteList[index];
                      });
                    },
                  ),
                  title: Text(
                    bioskopList[index],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    debugPrint('Klik bioskop: ${bioskopList[index]}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
