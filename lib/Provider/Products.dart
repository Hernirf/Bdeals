import 'package:bdeals/Provider/Users.dart';
import 'package:bdeals/model/ModelProduk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';

import 'package:provider/provider.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class ProductProvider extends ChangeNotifier {
  File? selectedFiles;
  String URlGambarProduk= "";
  // List<String> url = [];
  // String judul_lagu = "";
  // String url_lagu = "";
  File? bytes;
  BdealsProduk produk = BdealsProduk();
  List<BdealsProduk> produksList = [];
  BdealsProduk Detailproduk = BdealsProduk();
  List<BdealsProduk> MyProduct = [];



  // String idSaller;
  // String usernameSeller;
  // String judulProduk;
  // String kategoriProduk;
  // String deskripsoProduk;
  // String URlGambarProduk;
  // int nomorWAsaller;
  // String idProduk;
  // String alamatProduk;

  Future<void> addPostingan(
    String idSaller,
    String usernameSeller,
    String judulProduk,
    String kategoriProduk,
    String deskripsoProduk,
    String URlGambarProduk,
    int nomorWAsaller,
    // String idProduk,
    String alamatProduk
  ) async {
    final CollectionReference product = db.collection('Bdeals_Products');

    try {
      DocumentReference doc = await product.add({
        'JudulProduk': judulProduk,
        'KategoriProduk': kategoriProduk,
        'DeskripsiProduk': deskripsoProduk,
        'AlamatProduk': alamatProduk,
        'IDSaller': idSaller,
        'UsernameSaller': usernameSeller,
        'NomorWaSaller': nomorWAsaller,
        'URlProduct': URlGambarProduk,
        // 'judulpostingan': URlGambarProduk,
      });
    } catch (error) {
      print('Error adding postingan: $error');
    }
    notifyListeners();
  }

  void showMessageBox(BuildContext context, String title, String msg) {
    MessageBox msgBox = MessageBox(
      title: title,
      message: msg,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return msgBox;
      },
    );
  }

  Future<void> uploadFiles() async {
  try {
    final storage = FirebaseStorage.instance;

    // for (var file in selectedFiles) {
      if (selectedFiles != null) {
        String fileName = 'gambar_${DateTime.now().millisecondsSinceEpoch}.jpg';

        Uint8List byteData = await selectedFiles!.readAsBytes();

        Reference storageReference =
            storage.ref().child('postingan/gambar/$fileName');
        // await storageReference.putData(byteData);
        UploadTask uploadTask = storageReference.putData(byteData);
        
        await uploadTask.whenComplete(() async {
        String downloadUrl = await storageReference.getDownloadURL();
        URlGambarProduk = downloadUrl;
        });
    
        // print('File uploaded: $downloadUrl');
      }
      
    // }
  } catch (error) {
    print('Error uploading image: $error');
  }
}

Future<void> getMyProduct(String id) async {
  // searchPage = false;
  // var collectionReference = FirebaseFirestore.instance.collection('Bdeals_Products');
  await getProducts();
  MyProduct.clear();
  for (var element in produksList) {
    if (element.idSaller == id) {
       MyProduct.add(BdealsProduk(
              idSaller : element.idSaller,
              usernameSeller : element.usernameSeller,
              judulProduk : element.judulProduk,
              kategoriProduk : element.kategoriProduk,
              deskripsoProduk : element.deskripsoProduk,
              URlGambarProduk : element.URlGambarProduk,
              nomorWAsaller : element.nomorWAsaller,
              idProduk : element.idProduk,
              alamatProduk: element.alamatProduk
          ));
    }
  }
}

Future<void> getProducts() async {
  // searchPage = false;
  var collectionReference = FirebaseFirestore.instance.collection('Bdeals_Products');
  
  produksList.clear();
 await collectionReference.get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      //  if (doc['username'].toString().toLowerCase().contains(searchTerm.toLowerCase())){
              produksList.add(BdealsProduk(
              idSaller : doc['IDSaller'],
              usernameSeller : doc['UsernameSaller'],
              judulProduk : doc['JudulProduk'],
              kategoriProduk : doc['KategoriProduk'],
              deskripsoProduk : doc['DeskripsiProduk'],
              URlGambarProduk : doc['URlProduct'],
              nomorWAsaller : doc['NomorWaSaller'],
              idProduk : doc.id,
              alamatProduk: doc['AlamatProduk']
          ));
      // searchPage = true;
    // }

    });
  })
  .catchError((error) {
    print("Error: $error");
  });
}

Future<void> SearchProduct(String searchTerm) async {
  // searchPage = false;
  var collectionReference = FirebaseFirestore.instance.collection('Bdeals_Products');
  
produksList.clear();
 await collectionReference.get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
       if (doc['JudulProduk'].toString().toLowerCase().contains(searchTerm.toLowerCase())){
              produksList.add(BdealsProduk(
              idSaller : doc['IDSaller'],
              usernameSeller : doc['UsernameSaller'],
              judulProduk : doc['JudulProduk'],
              kategoriProduk : doc['KategoriProduk'],
              deskripsoProduk : doc['DeskripsiProduk'],
              URlGambarProduk : doc['URlProduct'],
              nomorWAsaller : doc['NomorWaSaller'],
              idProduk : doc.id,
              alamatProduk: doc['AlamatProduk']
          ));
      // searchPage = true;
    }

    });
  })
  .catchError((error) {
    print("Error: $error");
  });
}


  // Future<void> uploadlagu() async {
  //   try {
  //     if (bytes != null && judul_lagu.isNotEmpty) {
  //       String fileName =
  //           'musik_${DateTime.now().millisecondsSinceEpoch}.mp3';

  //       Reference storageReference =
  //           FirebaseStorage.instance.ref().child('postingan/musik/$fileName');

  //       UploadTask uploadTask = storageReference.putFile(bytes!);

  //       TaskSnapshot taskSnapshot = await uploadTask;

  //       url_lagu = await taskSnapshot.ref.getDownloadURL();

  //       print('Upload successful. Download URL: $url_lagu');
  //     } else {
  //       print('Error: bytes is null or judul_lagu is empty');
  //     }
  //   } catch (error) {
  //     print('Error during music upload: $error');
  //   }
  // }

  Future<void> deleteDocumentById(String documentId) async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('postingan').doc(documentId);

      await documentReference.delete();

      print('Document with ID $documentId successfully deleted.');
    } catch (error) {
      print('Error deleting document: $error');
    }
  }

  Future<void> getFilteredProducts(List<String> kategoriList) async {
  var collectionReference =
      FirebaseFirestore.instance.collection('Bdeals_Products');

  produksList.clear();

  try {
    Query query = collectionReference;

    // Kalau ada kategori, filter pakai whereIn
    if (kategoriList.isNotEmpty) {
      query = query.where('KategoriProduk', whereIn: kategoriList);
    }

    QuerySnapshot querySnapshot = await query.get();

    for (var doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;

      produksList.add(BdealsProduk(
        idSaller: data['IDSaller'],
        usernameSeller: data['UsernameSaller'],
        judulProduk: data['JudulProduk'],
        kategoriProduk: data['KategoriProduk'],
        deskripsoProduk: data['DeskripsiProduk'],
        URlGambarProduk: data['URlProduct'],
        nomorWAsaller: data['NomorWaSaller'],
        idProduk: doc.id,
        alamatProduk: data['AlamatProduk'],
      ));
    }

    notifyListeners();
  } catch (e) {
    print("Error saat ambil produk dengan filter kategori: $e");
  }
}


}

class MessageBox extends StatelessWidget {
  final String title;
  final String message;

  MessageBox({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          child: Text('OK'),
        ),
      ],
    );
  }

  
}
