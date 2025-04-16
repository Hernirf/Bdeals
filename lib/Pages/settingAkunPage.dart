import 'package:flutter/material.dart';

class PengaturanAkunPage extends StatelessWidget {
  const PengaturanAkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Akun'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Cari pengaturan...',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Ganti Akun"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.password),
              title: const Text("Ubah Kata Sandi"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
              },
            ),

            const Divider(),

            
          ],
        ),
      ),
    );
  }
}
