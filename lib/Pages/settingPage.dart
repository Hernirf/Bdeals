import 'package:bdeals/Pages/loginPage.dart';
import 'package:bdeals/Pages/settingAkunPage.dart';
import 'package:bdeals/Pages/settingBahasaPage.dart';
import 'package:bdeals/Provider/Users.dart';
import 'package:bdeals/model/ModelUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final User = Provider.of<UserProvider>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
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
              title: const Text("Pengaturan Akun"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PengaturanAkunPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("Pengaturan Bahasa"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PengaturanBahasaPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                User.userLogin = Userr();
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => loginPage()),
                
                );
                
              },
            ),
          ],
        ),
      ),
    );
  }
}
