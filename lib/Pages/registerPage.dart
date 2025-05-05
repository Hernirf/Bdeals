// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bdeals/Provider/Users.dart';
import 'package:bdeals/widgets/snackBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class SignUp extends StatefulWidget {
  const SignUp({super.key});
  

  @override
  State<SignUp> createState() => _SignUpState();

}

class _SignUpState extends State<SignUp> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _conpass = TextEditingController();
  final TextEditingController _noWA = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final User = Provider.of<UserProvider>(context, listen: false);
    final Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        backgroundColor: Color.fromARGB(255, 29, 72, 106),
      ),
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // backgorund atas
            // Container(
            //   height: size.height * 0.3,
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
            //       SizedBox(height: 30),
            //       Container(
            //         width: 150,
            //         height: 150,
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
            //         margin: EdgeInsets.symmetric(horizontal: 15),
            //         child: Text(
            //           "Start your Creation Adventure with Tiki Taka",
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 18,
            //             fontFamily: 'Raleway',
            //           ),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 60),
            // Username, Password, Confirm Password
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              height: 70,
              child: TextField(
                controller: _username,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  labelText: AppLocalizations.of(context)!.username,
                  labelStyle: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText: AppLocalizations.of(context)!.username,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 204, 204, 204),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color:  Colors.blue,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color:  Colors.blue,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
             SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              height: 70,
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    color:  Colors.blue,
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
             SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              height: 70,
              child: TextField(
                controller: _noWA,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  labelText: AppLocalizations.of(context)!.noWAA,
                  labelStyle: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText: AppLocalizations.of(context)!.noWAA,
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
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              height: 70,
              child: TextField(
                controller: _pass,
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
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              height: 70,
              child: TextField(
                controller: _conpass,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  labelText: AppLocalizations.of(context)!.confirmPass,
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color:Colors.blue,
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
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            // button bawah
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  AppLocalizations.of(context)!.pernyataanDaftar,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 13,
                    color: Color.fromARGB(255, 18, 45, 66),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    AppLocalizations.of(context)!.tanya2,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Color.fromARGB(255, 18, 45, 66),
                      fontSize: 13,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 5),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(0, 50),
                    foregroundColor: Color.fromARGB(255, 18, 45, 66),
                    backgroundColor:Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 90),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    if(_email.text == "" || _username.text == "" || _pass.text == ""|| _conpass.text ==""|| _noWA.text ==""){
                      Snackbarup.showSnackbar(context, AppLocalizations.of(context)!.harusterisi);
                    }
                    else if(_pass.text == _conpass.text){
                        User.signUp(_email.text, _pass.text);
                        if (User.userAuth != null){
                          User.setIDLogin();
                          print(_email.text);
                          if(User.userAuth!.email == _email.text){
                            await User.AddUserToFirebase(_username.text, _email.text, _pass.text,int.parse(_noWA.text));
                            await User.setIDLogin();
                            await User.getMyData();
                            Navigator.pushNamed(context, "/home");
                            _username.dispose();
                            _email.dispose();
                            _pass.dispose();
                            _conpass.dispose();
                          }
                        }
                    }
                  },
                  child:  Text(
                    AppLocalizations.of(context)!.register,
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
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
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text(
                    AppLocalizations.of(context)!.login,
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
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
