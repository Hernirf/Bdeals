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

 
  Future<void> addKomen(
    String idPengguna,
    String komen,
    String idProduk,
    String username,
    double rating,
    
  ) async {
    final CollectionReference Komencollect = FirebaseFirestore.instance.collection('Bdeals_Comment');

    try {
      DocumentReference doc = await Komencollect.add({
        'IDPengguna': idPengguna,
        'Komen': komen,
        'IdProduk': idProduk,
        'Username': username,
        'Rating': rating
        // 'judulpostingan': URlGambarProduk,
      });
    } catch (error) {
      print('Error adding postingan: $error');
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


