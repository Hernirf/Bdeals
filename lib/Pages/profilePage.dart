import 'package:bdeals/Pages/homePage.dart';
import 'package:bdeals/Provider/Coment.dart';
import 'package:bdeals/Provider/Products.dart';
import 'package:bdeals/Provider/Users.dart';
import 'package:flutter/material.dart';
import 'package:bdeals/Pages/detailprodukpage.dart';
import 'package:bdeals/Pages/settingPage.dart';
import 'package:bdeals/Pages/createPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.getMyData();
      await Provider.of<ProductProvider>(context, listen: false)
          .getMyProduct(userProvider.idlogin);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final postProvider = Provider.of<ProductProvider>(context);
    final comen = Provider.of<Comentprovider>(context);

    int banyakProduk = postProvider.MyProduct.length;

    // if (banyakProduk == 0) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            // Header Profile
            Container(
              color: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PengaturanPage()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Konten Scroll
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white, // bebas warnanya
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      userProvider.userLogin.username,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userProvider.userLogin.noWA.toString(),
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        userProvider.userLogin.bio,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const Divider(),

                    // Produk Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: banyakProduk,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            postProvider.Detailproduk =
                                postProvider.MyProduct[index];
                            comen.getDetaiKomen(
                                postProvider.MyProduct[index].idProduk);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => detailproduk()),
                            );
                          },
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(postProvider
                                    .MyProduct[index].URlGambarProduk),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateProduk()),
            );
          } else if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => beranda()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo), label: "Upload"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
