// ignore_for_file: deprecated_member_use

import 'package:bdeals/Pages/camera.dart';
import 'package:bdeals/Pages/homePage.dart';
import 'package:bdeals/Provider/Coment.dart';
import 'package:bdeals/Provider/Products.dart';
import 'package:bdeals/Provider/Users.dart';
import 'package:flutter/material.dart';
import 'package:bdeals/Pages/detailprodukpage.dart';
import 'package:bdeals/Pages/profilePage.dart';
import 'package:bdeals/Pages/settingPage.dart';
import 'package:bdeals/Pages/settingAkunPage.dart';
import 'package:bdeals/Pages/settingBahasaPage.dart';
import 'package:bdeals/Pages/createPage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class detailproduk extends StatefulWidget {
  const detailproduk({super.key});

  @override
  State<detailproduk> createState() => _detailprodukState();
}

class _detailprodukState extends State<detailproduk> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  final String message = 'Halo, saya tertarik dengan produk Anda';
  TextEditingController _komentar = TextEditingController();
  double ratingg = 0;

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;
    final post = Provider.of<ProductProvider>(context, listen: false);
    final komenmprovider = Provider.of<Comentprovider>(context, listen: false);
    int banyakKomen = komenmprovider.detailKomen.length;

    Widget komentar(int index) {
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.blue[100],
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Column untuk username dan komentar
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Menyelaraskan teks ke kiri
                    children: [
                      Text(
                        komenmprovider.detailKomen[index].username,
                        style: TextStyle(
                            fontWeight:
                                FontWeight.bold), // Menebalkan nama pengguna
                      ),
                      // Komentar teks yang bisa melampaui panjang dan bisa wrap
                      Container(
                        width:
                            200, // Atur lebar sesuai kebutuhan atau gunakan Expanded
                        child: Text(
                          komenmprovider.detailKomen[index].komen,
                          style: TextStyle(color: Colors.black),
                          softWrap: true, // Mengaktifkan pembungkusan teks
                          maxLines:
                              3, // Batasi komentar agar tidak terlalu panjang
                          overflow: TextOverflow
                              .ellipsis, // Tambahkan elipsis jika teks terlalu panjang
                        ),
                      ),
                    ],
                  ),

                  // RatingBar untuk menampilkan rating
                  RatingBarIndicator(
                    rating: komenmprovider.detailKomen[index].rating,
                    itemCount: 5,
                    itemSize: 20,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0), // Padding antar bintang
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      // itemz: 3, // Mengubah ukuran ikon bintang menjadi lebih kecil
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    String getWhatsAppUrl() {
      return 'https://wa.me/62${post.Detailproduk.nomorWAsaller}?text=${Uri.encodeComponent(message)}';
    }

    // Fungsi untuk membuka WhatsApp
    void _launchWhatsApp() async {
      final url = getWhatsAppUrl();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<void> _upload() async {
      // final post = Provider.of<ProductProvider>(context, listen: false);
      final User = Provider.of<UserProvider>(context, listen: false);
      // print("ID LOGIN"+ User.idlogin);
      // dynamic urlPoto =
      //     await User.getFieldById("path_potoProfile", User.idlogin);
      String userName = User.userLogin.username;

      // await post.uploadlagu();
      await komenmprovider.addKomen(User.idlogin, _komentar.text,
          post.Detailproduk.idProduk, userName, ratingg);
      post.showMessageBox(context,'Berhasil','Komen ada telah di Upload', '/home');
      setState(() {});
      // Navigator.pushNamed(context, '/bottomnav');
    }

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Container(
              width: lebar,
              height: tinggi * 1 / 2,
              color: Colors.grey[400],
              child: Image.network(
                post.Detailproduk.URlGambarProduk,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 7),
                    child: Text(post.Detailproduk.judulProduk,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 7),
                    child: Text(post.Detailproduk.kategoriProduk,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 7),
                    child: Text(post.Detailproduk.usernameSeller,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 7),
                    child: Text(post.Detailproduk.deskripsoProduk,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: FloatingActionButton(
                onPressed: _launchWhatsApp,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.call),
                      SizedBox(
                        width: 10,
                      ),
                      Text(AppLocalizations.of(context)!.hubungiPenjual)
                    ],
                  ),
                ),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 10, left: 110),
              child: Text(
                AppLocalizations.of(context)!.komentarPengguna,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Column(
              children: List.generate(banyakKomen, (index) => komentar(index)),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              color: const Color.fromARGB(255, 210, 234, 254),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    AppLocalizations.of(context)!.berikanPenilaian,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        height: 200,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: TextField(
                          maxLines:
                              null, // Untuk memungkinkan teks lebih dari satu baris
                          keyboardType: TextInputType.multiline,
                          controller: _komentar,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.komentarPengguna,
                            contentPadding: EdgeInsets.all(20),
                            border: InputBorder.none, // Menghilangkan border
                          ),
                        ),
                      )),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    maxRating: 5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 50,
                    ),
                    onRatingUpdate: (rating) {
                      ratingg = rating;
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: Icon(Icons.star_border_outlined),
                  //       iconSize: 50,
                  //     ),
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: Icon(Icons.star_border_outlined),
                  //       iconSize: 50,
                  //     ),
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: Icon(Icons.star_border_outlined),
                  //       iconSize: 50,
                  //     ),
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: Icon(Icons.star_border_outlined),
                  //       iconSize: 50,
                  //     ),
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: Icon(Icons.star_border_outlined),
                  //       iconSize: 50,
                  //     ),
                  //   ],
                  // ),
                  Container(
                    width: lebar - 100,
                    child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: ElevatedButton(
                          onPressed: _upload,
                          child: Text(AppLocalizations.of(context)!.kirim),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.yellow,
                              textStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateProduk()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
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
          });
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
