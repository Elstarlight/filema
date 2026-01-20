import 'package:flutter/material.dart';

class TiketWidescreenPage extends StatelessWidget {
  const TiketWidescreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: 3,
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                  icon: Icon(Icons.home), label: Text('Beranda')),
              NavigationRailDestination(
                  icon: Icon(Icons.movie), label: Text('Bioskop')),
              NavigationRailDestination(
                  icon: Icon(Icons.local_play), label: Text('TIX Fun')),
              NavigationRailDestination(
                  icon: Icon(Icons.confirmation_number),
                  label: Text('Tiket')),
            ],
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.confirmation_number_outlined,
                        size: 100, color: Colors.grey.shade300),
                    SizedBox(height: 20),
                    Text(
                      'Nonton Film Yuk!',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Dapatkan tiket nonton seru di bioskop favoritmu.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF162A4E),
                        padding: EdgeInsets.symmetric(
                            horizontal: 50, vertical: 16),
                      ),
                      onPressed: () {},
                      child: Text('Lihat Film'),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
