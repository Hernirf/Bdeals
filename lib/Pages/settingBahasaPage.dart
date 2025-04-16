import 'package:flutter/material.dart';

class PengaturanBahasaPage extends StatelessWidget {
  const PengaturanBahasaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Bahasa'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bahasa
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Cari bahasa...',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Bahasa Indonesia
            ListTile(
              leading: const Icon(Icons.language, color: Colors.blue),
              title: const Text("Bahasa Indonesia"),
              trailing: const Icon(Icons.check), // Tandai default (opsional)
              onTap: () {
                // Ganti ke Bahasa Indonesia
              },
            ),
            const Divider(),

            // Bahasa Inggris
            ListTile(
              leading: const Icon(Icons.language, color: Colors.green),
              title: const Text("English"),
              onTap: () {
                // Ganti ke English
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
