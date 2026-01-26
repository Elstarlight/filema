import 'package:filema/helper/local_ticket_service.dart';
import 'package:flutter/material.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  List<Map<String, dynamic>> tickets = [];

  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  Future<void> _loadTickets() async {
    final data = await LocalTicketService.getTickets();
    setState(() => tickets = data.reversed.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tiket Saya')),
      body: tickets.isEmpty
          ? const Center(child: Text('Belum ada tiket.'))
          : ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, i) {
                final t = tickets[i];
                return ListTile(
                  leading: const Icon(Icons.confirmation_num_outlined),
                  title: Text(t['title']),
                  subtitle: Text('Rp${t['price']}'),
                  trailing: Text(
                    t['purchasedAt'].toString().split('T').first,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                );
              },
            ),
    );
  }
}
