import 'package:bdeals/Provider/Coment.dart';
import 'package:bdeals/Provider/Products.dart';
import 'package:bdeals/model/ModelProduk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bdeals/Pages/detailprodukpage.dart';
import 'package:bdeals/Pages/profilePage.dart';
import 'package:bdeals/Pages/settingPage.dart';
import 'package:bdeals/Pages/settingAkunPage.dart';
import 'package:bdeals/Pages/settingBahasaPage.dart';
import 'package:bdeals/Pages/createPage.dart';
import 'package:provider/provider.dart';

class beranda extends StatefulWidget {
  const beranda({super.key});

  @override
  State<beranda> createState() => _berandaState();
}

class _berandaState extends State<beranda> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> kategoriList = [
    'Kuliner',
    'Properti',
    'Jasa',
    'Lainnya',
  ];
  final Map<String, bool> kategoriDipilih = {};

  // Menyimpan kategori yang dipilih
  List<String> kategoriTerpilih = [];
  bool filterApplied =
      false; // Menyimpan status filter (apakah tombol diterapkan?)
  

  int _currentIndex = 0;
  TextEditingController _search = TextEditingController();
  List<BdealsProduk> listFilter = [];
  
  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ProductProvider>(context, listen: false).getProducts();
      await Provider.of<Comentprovider>(context, listen: false).getAllKomen();
      setState(() {
        // listFilter.clear();
        // listFilter = getALL();
      }); // Memanggil setState setelah data selesai diambil
    });

    // Menginisialisasi kategoriDipilih dengan nilai false
    for (var kategori in kategoriList) {
      kategoriDipilih[kategori] = false;
    }
  }

  // Fungsi untuk mendapatkan produk yang sudah difilter berdasarkan kategori
  // List<BdealsProduk> getFilteredProducts() {
  //   final post = Provider.of<ProductProvider>(context, listen: false);
  //   List<BdealsProduk> filteredProducts = post.produksList;

  //   // Filter berdasarkan kategori yang dipilih
  //   if (kategoriTerpilih.isNotEmpty) {
  //     filteredProducts = filteredProducts.where((product) {
  //       return kategoriTerpilih.contains(product.kategoriProduk);
  //     }).toList();
  //   }

  //   // Filter berdasarkan teks pencarian (judul produk)
  //   String searchText = _search.text.toLowerCase(); // Ambil teks pencarian
  //   if (searchText.isNotEmpty) {
  //     filteredProducts = filteredProducts.where((product) {
  //       return product.judulProduk.toLowerCase().contains(searchText);
  //     }).toList();
  //   }

  //   setState(() {
  //     _search.text = "";
  //   });

  //   return filteredProducts;
  // }

  // List<BdealsProduk> getFilteredProducts() {
  //   final post = Provider.of<ProductProvider>(context, listen: false);
  //   listFilter.clear();
  //   if (kategoriTerpilih.isNotEmpty) {
  //     return post.produksList.where((product) {
  //       return kategoriTerpilih.contains(product.kategoriProduk);
  //       // Menampilkan hasil evaluasi kondisi
  //     }).toList();
  //   }
  //   return post
  //       .produksList; // Menampilkan semua produk jika tidak ada kategori yang dipilih
  // }

  // List<BdealsProduk> getALL() {
  //   final post = Provider.of<ProductProvider>(context, listen: false);
  //   listFilter.clear();
    
  //   return post.produksList; // Menampilkan semua produk jika tidak ada kategori yang dipilih
  // }

  // Widget untuk menampilkan produk
  Widget produk(int index) {
    final post = Provider.of<ProductProvider>(context, listen: false);
  

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          setState(() {
            post.Detailproduk.idProduk = post.produksList[index].idProduk;
            post.Detailproduk.idSaller = post.produksList[index].idSaller;
            post.Detailproduk.URlGambarProduk =
                post.produksList[index].URlGambarProduk;
            post.Detailproduk.usernameSeller = post.produksList[index].usernameSeller;
            post.Detailproduk.kategoriProduk = post.produksList[index].kategoriProduk;
            post.Detailproduk.deskripsoProduk =
                post.produksList[index].deskripsoProduk;
            post.Detailproduk.judulProduk = post.produksList[index].judulProduk;
            post.Detailproduk.nomorWAsaller = post.produksList[index].nomorWAsaller;
            post.Detailproduk.alamatProduk = post.produksList[index].alamatProduk;
            Provider.of<Comentprovider>(context, listen: false)
                .getDetaiKomen(post.produksList[index].idProduk);
          });

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => detailproduk()),
          );
        },
        child: Container(
          child: Row(
            children: [
              Container(
                height: 150,
                width: 150,
                color: Colors.grey,
                child: Image.network(
                  post.produksList[index].URlGambarProduk,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 7),
                    child: Text(post.produksList[index].judulProduk,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 7),
                    child: Text(post.produksList[index].kategoriProduk,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 7),
                    child: Text(post.produksList[index].usernameSeller,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 7),
                    child: Text(post.produksList[index].deskripsoProduk,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<ProductProvider>(context, listen: false);
    final komen = Provider.of<Comentprovider>(context, listen: false);
    int banyakProduk = post.produksList.length;

    if (banyakProduk == 0 && komen.komenList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              'Pilih Kategori',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            ...kategoriList.map((kategori) {
              return CheckboxListTile(
                title: Text(kategori),
                value: kategoriDipilih[kategori],
                onChanged: (val) {
                  setState(() {
                    kategoriDipilih[kategori] = val ?? false;
                    if (val ?? false) {
                      kategoriTerpilih
                          .add(kategori); // Menambahkan kategori ke filter
                    } else {
                      kategoriTerpilih
                          .remove(kategori); // Menghapus kategori dari filter
                    }
                  });
                },
              );
            }).toList(),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                print(kategoriTerpilih);

                await Provider.of<ProductProvider>(context, listen: false).getFilteredProducts(kategoriTerpilih);
                setState(()  {
        


                  Navigator.pop(context); // Menutup drawer
                });
              },
              child: Text("Terapkan"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // SEARCHING
              Container(
                color: Colors.orange,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      // onTap: () {
                      //   setState(() {
                      //     filterApplied= false;
                      //   });
                      // },
                      // autocorrect: true,
                      controller: _search,
                      onSubmitted: (value) async {
                         await Provider.of<ProductProvider>(context, listen: false).SearchProduct(value);

                            // Tindakan ketika tombol diklik, misalnya memfilter produk
                            setState(() {
                              _search.clear();
                            });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'CARI PRODUK YANG ANDA INGINKAN',
                        labelStyle: TextStyle(color: Colors.grey),
                        icon: Icon(Icons.search), // Ikon pencarian di kiri
                       
                      ),
                    ),
                  ),
                ),
              ),

              // KATEGORI TOMBOL
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                        // setState(() {
                          
                          
                        //   listFilter.clear();
                        //   listFilter =getALL();
                        //   filterApplied = false;
                        // });
                      },
                      icon: Icon(Icons.category, color: Colors.orange),
                      label: Text(
                        "Kategori",
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              // PRODUK
              Column(
                children: List.generate( banyakProduk, (index) => produk(index),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            if (index == 1) {
              // setState(() {
              //   listFilter.clear();
              //   listFilter=getALL();
              // });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateProduk()),
              );
            } else if (index == 2) {
              // setState(() {
              //   listFilter.clear();

              //   listFilter=getALL();
              // });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
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
