// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bdeals/Provider/Users.dart';
import 'package:bdeals/widgets/snackBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _SignInState();
}

class _SignInState extends State<loginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final User = Provider.of<UserProvider>(context, listen: false);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        backgroundColor:Colors.blue,
      ),
      body: Center(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // background atas
            // Container(
            //   height: size.height * 0.35,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Color.fromARGB(255, 29, 72, 106),
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(30),
            //       bottomRight: Radius.circular(30),
            //     ),
            //   ),
            //   child: Column(
            //     children: [
            //       SizedBox(height: 20),
            //       Container(
            //         width: size.width * 0.45,
            //         height: size.width * 0.45,
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           image: DecorationImage(
            //             image: AssetImage('assets/logo.png'),
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 10),
            //       Container(
            //         margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            //         child: Text(
            //           "Take Your Creativity to the Next Level with Tiki Taka.",
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: size.width * 0.05,
            //             fontFamily: 'Raleway',
            //           ),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height:200),

            // Username
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                width: double.infinity,
                height: size.height * 0.09,
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                      color:Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 204, 204, 204),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Password
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                width: double.infinity,
                height: size.height * 0.09,
                child: TextField(
                  controller: _pass,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    labelText: AppLocalizations.of(context)!.pass,
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    ),
                    hintText: AppLocalizations.of(context)!.pass,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 204, 204, 204),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.blue,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.blue,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color:Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            // button bawah
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(0, 50),
                    foregroundColor: Color.fromARGB(255, 18, 45, 66),
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 90),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    await User.login(_email.value.text, _pass.value.text);
                    print(User.userAuth!.email);
                    if (_email.text == "" || _pass.text == ""){
                      Snackbarup.showSnackbar(context, AppLocalizations.of(context)!.harusterisi);
                    }
                    if (User.userAuth != null) {
                      if (User.userAuth!.email == _email.text) {
                        await User.setIDLogin();
                        print(User.idlogin);
                        await User.getMyData();
                        Navigator.pushNamed(context, "/home");
                        _email.dispose();
                        _pass.dispose();
                      }
                    }
                    if(User.userAuth == null){
                      Snackbarup.showSnackbar(context, AppLocalizations.of(context)!.userpassSalah);
                    }
                  },
                  child:  Text(
                    AppLocalizations.of(context)!.login,
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            SizedBox(height: size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  AppLocalizations.of(context)!.tanyaAkun,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 13,
                    color: Color.fromARGB(255, 18, 45, 66),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/signUp');
                  },
                  child: Text(
                    AppLocalizations.of(context)!.register,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.blue,
                      fontSize: 13,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
