// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:bdeals/Pages/createPage.dart';
import 'package:bdeals/Pages/profilePage.dart';
import 'package:bdeals/Pages/homePage.dart';





class bottomnav extends StatefulWidget {
  final int idx;
  const bottomnav({super.key, required this.idx});

  @override
  State<bottomnav> createState() => _bottomnavState();
}

class _bottomnavState extends State<bottomnav> {
  late int currentIndex;
  final List<Widget> _children = [
    beranda(),
    CreateProduk(),
    Profile(),
    
    // inputan(),
    // profile(),
  ];

   @override
  void initState() {
    super.initState();
    currentIndex = widget.idx;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(size: 35),
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo),
            label: 'Tambah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
