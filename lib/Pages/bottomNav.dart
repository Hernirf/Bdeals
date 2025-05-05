// import 'dart:io';

// import 'package:bdeals/Pages/homePage.dart';
// // import 'package:bdeals/Pages/indonesian/home.dart';
// // import 'package:bdeals/Pages/indonesian/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:bdeals/Pages/detailprodukpage.dart';
// import 'package:bdeals/Pages/profilePage.dart';
// import 'package:bdeals/Pages/settingPage.dart';
// import 'package:bdeals/Pages/settingAkunPage.dart';
// import 'package:bdeals/Pages/settingBahasaPage.dart';
// import 'package:bdeals/Pages/createPage.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:path/path.dart';
// // import 'dart:io';
// import 'package:bdeals/Provider/Products.dart';
// import 'package:bdeals/Provider/Users.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';







// class CreateProduk extends StatefulWidget {
//   const CreateProduk({Key? key}) : super(key: key);

//   @override
//   State<CreateProduk> createState() => _CreateProdukState();
// }

// class _CreateProdukState extends State<CreateProduk> {
  
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
//   int _currentIndex = 1;

//   TextEditingController _judul = TextEditingController();
//   TextEditingController _deskripsi = TextEditingController();
//   TextEditingController _alamat = TextEditingController();
//  String _kategori = "wueyquprq";
// //  String _judul = "wueyquprq";
// //  String _deskripsi = "wueyquprq";
// //  String _alamat= "wueyquprq";


  
//   String SelectedCategory = "";
//   bool propertiSelected = false;
//   bool jasaSelected = false;
//   bool lainnyaSelected = false;
//   bool kulinerSelected = true;

//   File? _image; // Menyimpan gambar yang dipilih
//   final ImagePicker picker = ImagePicker();

//   // Fungsi untuk mengambil gambar dari kamera
//   Future<void> _getImageFromCamera() async {
//     // final pickedFile = await picker.getImage(source: ImageSource.camera);
//     final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path); // Menyimpan file gambar
//       } else {
//         print('Tidak ada gambar yang dipilih');
//       }
//     });
//   }

//   // Fungsi untuk mengambil gambar dari galeri
//   Future<void> _getImageFromGallery() async {
//     // final pickedFile = await picker.getImage(source: ImageSource.gallery);
//   final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path); // Menyimpan file gambar
//       } else {
//         print('Tidak ada gambar yang dipilih');
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // Jangan lupa memanggil dispose pada controller untuk membebaskan resource
//     // _judul.dispose();
//     // _deskripsi.dispose();
//     // _alamat.dispose();

  


//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final post = Provider.of<ProductProvider>(context, listen: false);

    
//     double lebar = MediaQuery.of(context).size.width;
//     double tinggi = MediaQuery.of(context).size.height;


//   Future<void> _upload() async {
//       // final post = Provider.of<ProductProvider>(context, listen: false);
//       final User = Provider.of<UserProvider>(context, listen: false);
//       print("ID LOGIN"+ User.idlogin);
//       // dynamic urlPoto =
//       //     await User.getFieldById("path_potoProfile", User.idlogin);
//       dynamic userName = await User.getFieldById("username", User.idlogin);
//       dynamic noWa = await User.getFieldById("nomorWA", User.idlogin);
//       int noWAA = int.parse(noWa.toString());

//       await post.uploadFiles();
//       // await post.uploadlagu();
//       await post.addPostingan(User.idlogin,userName,_judul.text,SelectedCategory,_deskripsi.text,post.URlGambarProduk,noWAA,_alamat.text);
//       post.showMessageBox(
//           context, 'BERHASIL', 'Postingan anda berhasil di unggah');
//       setState(() {
//         post.URlGambarProduk = '';
//       //   post.selectedFiles = [];
//       //   post.bytes = null;
//       //   post.url_lagu = "";
//       //   post.url = [];
//       //   // post.selectedFiles= const [];
//       });
//       // Navigator.pushNamed(context, '/bottomnav');
//     }

    

//     return Scaffold(
//       key: _scaffoldKey, 
//       body:ListView(
//         children: [
//           Column(
//             children: [
//               Container(
//                 child: 
//                       _image == null
//                           ? Icon(
//                             Icons.image_outlined,
//                             size: 100,
//                             color: Colors.grey,
//                           )
//                           : Image.file(
//                               _image!, // Menampilkan gambar yang dipilih
//                               height: (tinggi * 1 / 2) + 50,
//                               width: lebar ,
//                               fit: BoxFit.cover,
//                             ),
//               ),
//                       SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.camera_alt, size: 40), // Gallery icon
//                             onPressed: _getImageFromCamera,
//                             tooltip: 'Pilih Gambar Dari Camera',
//                           ),
//                           SizedBox(width: 10),
//                           IconButton(
//                             icon: Icon(Icons.photo_library, size: 40), // Gallery icon
//                             onPressed: _getImageFromGallery,
//                             tooltip: 'Pilih Gambar Dari Galeri',
//                           ),
//                         ],
//                       ),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 20, right: 20, top: 20),
//             child: TextField(
//               controller: _judul,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.all(10),
//                 labelText: "Judul/Nama Produk",
//                 filled: true,
//                 fillColor: Colors.amber[200],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 20, right: 20, top: 20),
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   kulinerSelected = !kulinerSelected;
//                   propertiSelected = false;
//                   jasaSelected = false;
//                   lainnyaSelected = false;
//                 });
//               },
//               child: Container(
//                 color: Colors.amber[200],
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text("Kategori Produk"),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           kulinerSelected = !kulinerSelected;
//                           propertiSelected = false;
//                           jasaSelected = false;
//                           lainnyaSelected = false;
//                         });
//                       },
//                       icon: Icon(Icons.menu),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
          
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Pilih Kategori:"),
//                   RadioListTile<String>(
//                     title: Text('Kuliner'),
//                     value: 'Kuliner', // Menggunakan teks untuk setiap kategori
//                     groupValue: SelectedCategory,
//                     onChanged: (String? value) {
//                       setState(() {
//                         SelectedCategory = value!;
//                       });
//                     },
//                   ),
//                   RadioListTile<String>(
//                     title: Text('Properti'),
//                     value: 'Properti', // Menggunakan teks untuk setiap kategori
//                     groupValue: SelectedCategory,
//                     onChanged: (String? value) {
//                       setState(() {
//                         SelectedCategory = value!;
//                       });
//                     },
//                   ),
//                   RadioListTile<String>(
//                     title: Text('Jasa'),
//                     value: 'Jasa', // Menggunakan teks untuk setiap kategori
//                     groupValue: SelectedCategory,
//                     onChanged: (String? value) {
//                       setState(() {
//                         SelectedCategory = value!;
//                       });
//                     },
//                   ),
//                   RadioListTile<String>(
//                     title: Text('Lainnya'),
//                     value: 'Lainnya', // Menggunakan teks untuk setiap kategori
//                     groupValue: SelectedCategory,
//                     onChanged: (String? value) {
//                       setState(() {
//                         SelectedCategory = value!;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           Padding(
//             padding: EdgeInsets.only(left: 20, right: 20, top: 20),
//             child: TextField(
//               controller: _deskripsi,
//               maxLines: null, // Untuk memungkinkan teks lebih dari satu baris
//               keyboardType: TextInputType.multiline,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.all(10),
//                 labelText: "Deskripsi Produk",
//                 filled: true,
//                 fillColor: Colors.amber[200],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 20, right: 20, top: 20),
//             child: TextField(
//               controller: _alamat,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.all(10),
//                 labelText: "Alamat",
//                 filled: true,
//                 suffixIcon: Icon(Icons.add_location_outlined),
//                 fillColor: Colors.amber[200],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
//             child: FloatingActionButton(
//               onPressed: _upload,
//               child: Text("Upload"),
//               backgroundColor: Colors.amber,
//             ),
//           )
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           setState(() {
           
//             if (index == 0) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => beranda()),
//             );
            
//           } 
//           else if (index == 2){
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Profile()),
//             );
//           }
//           else {
//             setState(() {
//               _currentIndex = index;
//             });
//           }
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.add_a_photo), label: "Upload"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }