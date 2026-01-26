import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalTicketService {
  static const _key = 'user_tickets';

  /// Menyimpan tiket baru ke local storage
  static Future<void> saveTicket(Map<String, dynamic> ticket) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_key) ?? [];
    existing.add(jsonEncode(ticket));
    await prefs.setStringList(_key, existing);
  }

  /// Mengambil semua tiket
  static Future<List<Map<String, dynamic>>> getTickets() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_key) ?? [];
    return existing.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }

  /// Menghapus semua tiket (opsional)
  static Future<void> clearTickets() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
