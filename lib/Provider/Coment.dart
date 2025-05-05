import 'package:bdeals/Provider/Products.dart';
import 'package:bdeals/Provider/Users.dart';
import 'package:bdeals/model/ModelKomen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:provider/provider.dart';

// FirebaseFirestore db = FirebaseFirestore.instance;


class Comentprovider extends ChangeNotifier {
  Bdealskomen komenn = Bdealskomen();
  List<Bdealskomen> komenList = [];
  List<Bdealskomen> detailKomen = [];
  // final post = Provider.of<ProductProvider>(context, listen: false);

 
  Future<void> addKomen(
  String idPengguna,
  String komen,
  String idProduk,
  String username,
  double rating,
) async {
  final CollectionReference komenCollect =
      FirebaseFirestore.instance.collection('Bdeals_Comment');

  try {
    // Cek apakah user sudah pernah komentar untuk produk ini
    final existingKomenQuery = await komenCollect
        .where('IDPengguna', isEqualTo: idPengguna)
        .where('IdProduk', isEqualTo: idProduk)
        .limit(1)
        .get();

    if (existingKomenQuery.docs.isNotEmpty) {
      // Kalau sudah ada komentar, update
      final docId = existingKomenQuery.docs.first.id;

      await komenCollect.doc(docId).update({
        'Komen': komen,
        'Rating': rating,
        'Username': username, // opsional, kalau user bisa ganti username
        'UpdatedAt': FieldValue.serverTimestamp(),
      });

      print('Komentar diperbarui.');
    } else {
      // Kalau belum ada, tambah baru
      await komenCollect.add({
        'IDPengguna': idPengguna,
        'Komen': komen,
        'IdProduk': idProduk,
        'Username': username,
        'Rating': rating,
        'CreatedAt': FieldValue.serverTimestamp(),
      });

      print('Komentar ditambahkan.');
    }
  } catch (error) {
    print('Error saat menambah/memperbarui komentar: $error');
  }

  notifyListeners();
}



  Future<void> getAllKomen() async {
  var collectionReference = FirebaseFirestore.instance.collection('Bdeals_Comment');
  komenList.clear();
  await collectionReference.get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
              komenList.add(Bdealskomen(
              idPengguna : doc['IDPengguna'],
              komen : doc['Komen'],
              idProduk : doc['IdProduk'],
              username : doc['Username'],
              rating : doc['Rating'],
              id_komen: doc.id
          ));
    });
  })
  .catchError((error) {
    print("Error: $error");
  });
}

Future<void> getDetaiKomen(String id) async {
  detailKomen.clear();
  for (var element in komenList) {
    if (element.idProduk == id) {
       detailKomen.add(Bdealskomen(
              idPengguna : element.idPengguna,
              komen : element.komen,
              idProduk : element.idProduk,
              username : element.username,
              rating : element.rating,
              id_komen : element.id_komen,
          ));
    }
  }
}

}


