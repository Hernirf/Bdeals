import 'package:bdeals/Pages/ubahAkunPage.dart';
import 'package:bdeals/Pages/ubahKataSandiPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PengaturanAkunPage extends StatelessWidget {
  const PengaturanAkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.pengaturanAkun),
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
                hintText: AppLocalizations.of(context)!.caripengaturan,
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
              title:  Text(AppLocalizations.of(context)!.gantiAkun),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UbahAkunPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.password),
              title:  Text(AppLocalizations.of(context)!.ubahKataSandi),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UbahKataSandiPage()),
    );
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
