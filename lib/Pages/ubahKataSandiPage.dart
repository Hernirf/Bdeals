import 'package:bdeals/Provider/Products.dart';
import 'package:bdeals/Provider/Users.dart';
import 'package:bdeals/model/ModelUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class UbahKataSandiPage extends StatefulWidget {
  const UbahKataSandiPage({super.key});

  @override
  _UbahKataSandiPageState createState() => _UbahKataSandiPageState();
}

class _UbahKataSandiPageState extends State<UbahKataSandiPage> {
  final TextEditingController _kataSandiLamaController =
      TextEditingController();
  final TextEditingController _kataSandiBaruController =
      TextEditingController();
  final TextEditingController _konfirmasiKataSandiBaruController =
      TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<ProductProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.ubahKataSandi),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _kataSandiLamaController,
              decoration:  InputDecoration(labelText: AppLocalizations.of(context)!.oldpass,
              suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText3 ? Icons.visibility : Icons.visibility_off,
                        color:Colors.orange,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText3 = !_obscureText3;
                        });
                      },
                    ),),
              obscureText: _obscureText3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _kataSandiBaruController,
              decoration:  InputDecoration(
                labelText: AppLocalizations.of(context)!.newpass,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText2 ? Icons.visibility : Icons.visibility_off,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText2 = !_obscureText2;
                    });
                  },
                ),
              ),
              obscureText: _obscureText2,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _konfirmasiKataSandiBaruController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.confirmPass,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final lama = _kataSandiLamaController.text.trim();
                final baru = _kataSandiBaruController.text.trim();
                final konfirmasi =
                    _konfirmasiKataSandiBaruController.text.trim();

                // Cek input kosong dulu
                if (lama.isEmpty || baru.isEmpty || konfirmasi.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                        content: Text(AppLocalizations.of(context)!.harusterisi)),
                  );
                  return; // stop di sini
                }

                // Cek sandi lama cocok
                // if (lama != user.userLogin.pass) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //         content: Text('Kata sandi lama anda tidak cocok.')),
                //   );
                //   return;
                // }

                // Cek konfirmasi sandi baru cocok
                if (baru != konfirmasi) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Kata sandi baru dan konfirmasi tidak cocok.')),
                  );
                  return;
                }

                // Semua valid, lakukan update
                await user.UpdateSandi(lama, baru, konfirmasi);
                user.signOut();
                user.userLogin =
                    Userr(); // reset login (opsional, sesuai logika kamu)
                post.showMessageBox(
                  context,
                  'BERHASIL',
                  'Kata Sandi anda berhasil diperbarui',
                  '/',
                );
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
