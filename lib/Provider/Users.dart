import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bdeals/model/ModelUser.dart';

FirebaseAuth _fireAuth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;

class UserProvider extends ChangeNotifier {
  User? userAuth = null;

  CollectionReference users = db.collection("Bdeals_Users");
  String _idLogin = '';
  String get idlogin => _idLogin;
  Userr userSearch = Userr();
  List<Userr> listUser = [];
  Userr userLogin = Userr();

  bool searchPage = false;

  Future<void> getMyData() async {
    // searchPage = false;
    var collectionReference =
        FirebaseFirestore.instance.collection('Bdeals_Users');

    // MyProduct.clear();
    await collectionReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.id.toString().contains(idlogin)) {
          userLogin = Userr(
            username: doc['username'],
            email: doc['email'],
            pass: doc['pass'],
            bio: doc['bio'],
            path_potoProfile: doc['path_potoProfile'],
            id: idlogin,
            noWA: doc['nomorWA'],
          );
        }
      });
    }).catchError((error) {
      print("Error: $error");
    });
  }

  Future<dynamic> getFieldById(String fieldName, String id) async {
    try {
      // Mendapatkan referensi dokumen dengan ID tertentu
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Bdeals_Users')
          .doc(id)
          .get();

      // Memeriksa apakah dokumen ditemukan
      if (documentSnapshot.exists) {
        // Mendapatkan data dari dokumen
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Mendapatkan nilai field tertentu
        dynamic fieldValue = data[fieldName];

        // Mengembalikan nilai field
        return data[fieldName];
      } else {
        // Dokumen tidak ditemukan, bisa mengembalikan nilai default atau null sesuai kebutuhan
        return '';
      }
    } catch (e) {
      // Menangani error, bisa mengembalikan nilai default atau null sesuai kebutuhan
      return '';
    }
  }

  Future<void> signOut() async {
    if (userAuth != null) {
      FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.signOut();

      // Setelah logout, Anda bisa mengosongkan variabel yang menyimpan data pengguna.
      // userAuth = _auth.currentUser;
      userAuth = null;
    }
  }

  Future<void> setIDLogin() async {
    await users
        .where('email', isEqualTo: userAuth!.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Loop melalui hasil query untuk mendapatkan ID dari dokumen yang cocok
        querySnapshot.docs.forEach((doc) {
          _idLogin = doc.id;
          print("ini adalah id login: " + _idLogin);
          print(userAuth!.email);
        });
      } else {
        print('No documents found with the specified field value');
      }
    }).catchError((error) {
      print('Error searching for documents: $error');
    });
    notifyListeners();
  }

  Future signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userAuth = _fireAuth.currentUser;
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      userAuth = _fireAuth.currentUser;
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> AddUserToFirebase(
      String username, String email, String pass, int noWA) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Bdeals_Users');

    try {
      DocumentReference doc = await users.add({
        'username': username,
        'email': email,
        'pass': pass,
        'nomorWA': noWA,
        'bio': "",
        'path_potoProfile': ""
      });
      // Disini Anda bisa melakukan operasi lain yang memanfaatkan nilai docID
    } catch (error) {
      print('Error: $error');
    }
    notifyListeners();
  }

  Future<void> UpdateSandi(
      String oldPass, String newPass, String confirmPass) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Bdeals_Users');
    // if (oldPass == userLogin.pass) {
    // if (newPass == confirmPass) {
    final userrr = FirebaseAuth.instance.currentUser!;
    final cred = EmailAuthProvider.credential(
      email: userrr.email!,
      password: oldPass,
    );

    await userrr.reauthenticateWithCredential(cred);
    await userrr.updatePassword(newPass);
    try {
      await users.doc(idlogin).update({'pass': newPass});
      // Disini Anda bisa melakukan operasi lain yang memanfaatkan nilai docID
    } catch (error) {
      print('Error: $error');
    }
    // }
    // }
    

    notifyListeners();


  }

  Future<void> ubahAkun(
    String? nama,
    String? bio,
    int? noHp,
  ) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Bdeals_Users');
    final CollectionReference produks =
        FirebaseFirestore.instance.collection('Bdeals_Products');
    final CollectionReference komens =
        FirebaseFirestore.instance.collection('Bdeals_Comment');

    try {
      // Buat map untuk update user
      final Map<String, dynamic> userUpdateData = {};
      final Map<String, dynamic> produkUpdateData = {};

      if (nama != null && nama.isNotEmpty) {
        userUpdateData['username'] = nama;
        produkUpdateData['UsernameSaller'] = nama;
      }
      if (bio != null && bio.isNotEmpty) {
        userUpdateData['bio'] = bio;
      }
      if (noHp != null) {
        userUpdateData['nomorWA'] = noHp;
        produkUpdateData['NomorWaSaller'] = noHp;
        
      }

      if (userUpdateData.isNotEmpty) {
        await users.doc(idlogin).update(userUpdateData);
      }

      // Update di produk
      final produkSnapshot =
          await produks.where('IDSaller', isEqualTo: idlogin).get();

      for (final document in produkSnapshot.docs) {
        if (produkUpdateData.isNotEmpty) {
          await produks.doc(document.id).update(produkUpdateData);
        }
      }

      // Update di komen
      final komenSnapshot =
          await komens.where('IDPengguna', isEqualTo: idlogin).get();

      for (final document in komenSnapshot.docs) {
        if (nama != null && nama.isNotEmpty) {
          await komens.doc(document.id).update({'Username': nama});
        }
      }

      notifyListeners();
      print('Data akun berhasil diperbarui.');
    } catch (error) {
      print('Error saat memperbarui akun: $error');
    }
  }

// import 'package:cloud_firestore/cloud_firestore.dart';

  Future<void> searchFirestore(String searchTerm) async {
    // searchPage = false;
    var collectionReference =
        FirebaseFirestore.instance.collection('Bdeals_Users');

    listUser.clear();
    await collectionReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['username']
            .toString()
            .toLowerCase()
            .contains(searchTerm.toLowerCase())) {
          listUser.add(Userr(
            bio: doc['bio'],
            username: doc['username'],
            email: doc['email'],
            path_potoProfile: doc['path_potoProfile'],
            pass: doc['pass'],
            id: doc.id,
          ));
          searchPage = true;
        }
      });
    }).catchError((error) {
      print("Error: $error");
    });
  }

  Future<void> otherProfile(String id) async {
    try {
      // Mendapatkan referensi dokumen dengan ID tertentu
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(id).get();

      // Memeriksa apakah dokumen ditemukan
      if (documentSnapshot.exists) {
        // Mendapatkan data dari dokumen
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Mendapatkan nilai field tertentu
        userSearch.id = id;
        userSearch.bio = data['bio'];
        userSearch.username = data['username'];
        userSearch.email = data['email'];
        userSearch.path_potoProfile = data['path_potoProfile'];

        // Mengembalikan nilai field
      } else {
        // Dokumen tidak ditemukan, bisa mengembalikan nilai default atau null sesuai kebutuhan
      }
    } catch (e) {
      // Menangani error, bisa mengembalikan nilai default atau null sesuai kebutuhan
    }
  }
}
