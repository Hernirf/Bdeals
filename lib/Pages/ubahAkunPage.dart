import 'package:bdeals/Provider/Products.dart';
import 'package:bdeals/Provider/Users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class UbahAkunPage extends StatefulWidget {
  const UbahAkunPage({super.key});

  @override
  _UbahAkunPageState createState() => _UbahAkunPageState();
}

class _UbahAkunPageState extends State<UbahAkunPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _nomorHpController = TextEditingController();
  final TextEditingController _bio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    final post = Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.gantiAkun),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _namaController,
              decoration:  InputDecoration(labelText: AppLocalizations.of(context)!.username),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nomorHpController,
              decoration:  InputDecoration(labelText: AppLocalizations.of(context)!.noWAA),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bio,
              decoration: const InputDecoration(labelText: 'Bio'),
              // keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                String nomorHpText = _nomorHpController.text;

                int? nomorHp =
                    nomorHpText.isNotEmpty ? int.parse(nomorHpText) : null;
                user.ubahAkun(_namaController.text, _bio.text,
                    nomorHp);
                await user.getMyData();
                // await post.getMyProduct(user.idlogin);
                post.showMessageBox(context, 'BERHASIL',
                    'Ubah akun berhasil di dilakukan', 'profilePage');
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child:  Text(AppLocalizations.of(context)!.simpan),
            ),
          ],
        ),
      ),
    );
  }
}
