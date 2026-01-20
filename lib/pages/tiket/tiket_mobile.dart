import 'package:flutter/material.dart';

class TiketMobilePage extends StatelessWidget {
  const TiketMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Cari di TIX ID',
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          Icon(Icons.person_outline, color: Colors.black),
          SizedBox(width: 12),
          Stack(
            children: [
              Icon(Icons.notifications_none, color: Colors.black),
              Positioned(
                right: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.orange,
                  child: Text(
                    '11',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          _tabMenu(),
          SizedBox(height: 40),
          _emptyTicket(),
        ],
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _tabMenu() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              _tabText('TIKET AKTIF', true),
              SizedBox(width: 20),
              _tabText('DAFTAR TRANSAKSI', false),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _chip('Film', true),
              _chip('Makanan', false),
              _chip('Event', false),
              _chip('Atraksi', false),
            ],
          )
        ],
      ),
    );
  }

  Widget _tabText(String text, bool active) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: active ? Colors.blue : Colors.grey,
      ),
    );
  }

  Widget _chip(String text, bool active) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: active ? Colors.blue.shade50 : Colors.white,
          side: BorderSide(color: active ? Colors.blue : Colors.grey),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(color: active ? Colors.blue : Colors.grey),
        ),
      ),
    );
  }

  Widget _emptyTicket() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.confirmation_number_outlined,
              size: 80, color: Colors.grey.shade300),
          SizedBox(height: 16),
          Text(
            'Nonton Film Yuk!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Dapatkan tiket nonton seru di bioskop favoritmu.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF162A4E),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            ),
            onPressed: () {},
            child: Text('Lihat Film'),
          )
        ],
      ),
    );
  }

  Widget _bottomNav() {
    return BottomNavigationBar(
      currentIndex: 4,
      selectedItemColor: Color(0xFF162A4E),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Bioskop'),
        BottomNavigationBarItem(icon: Icon(Icons.local_play), label: 'TIX Fun'),
        BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number), label: 'Tiket'),
      ],
    );
  }
}
