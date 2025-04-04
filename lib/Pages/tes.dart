// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              SizedBox(height: 100),
              Text(
                'RAHMAN JELEK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.06,
                  color: Color.fromARGB(255, 18, 45, 66),
                ),
              ),
            
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 18, 45, 66),
                  ),
                ),
                child: Text('LOGIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                      color: Colors.white,
                    )),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  'Sign In To My Account',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Color.fromARGB(255, 41, 179, 173),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
