import 'package:flutter/material.dart';
import 'package:bdeals/Provider/localProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PengaturanBahasaPage extends StatelessWidget {
  const PengaturanBahasaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locall = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = locall.locale;

    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.pengaturanBahasa),
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
                hintText: AppLocalizations.of(context)!.cariBahasa,
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
              title:  Text(AppLocalizations.of(context)!.indo),
              trailing: currentLocale.languageCode == 'id'
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                locall.setLocale(const Locale('id'));
              },
            ),
            const Divider(),

            // Bahasa Inggris
            ListTile(
              leading: const Icon(Icons.language, color: Colors.green),
              title:  Text(AppLocalizations.of(context)!.inggris),
              trailing: currentLocale.languageCode == 'en'
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                locall.setLocale(const Locale('en'));
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
