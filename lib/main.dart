import 'package:bdeals/Pages/tes.dart';
import 'package:bdeals/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bdeals/Provider/Users.dart';
import 'package:bdeals/Pages/loginPage.dart';
import 'package:bdeals/Pages/registerPage.dart';
// import 'Provider/postingan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        // ChangeNotifierProvider(create: (context) => postinganProvider()),
        // ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      // Inisialisasi DataProvider
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final User = Provider.of<UserProvider>(context, listen: false);

    return MaterialApp(
      title: 'Tiki Taka',
      debugShowCheckedModeBanner: false,
      // theme: Provider.of<ThemeProvider>(context).getTheme(),
      routes: {
        
        '/': (context) => loginPage(),
        '/signUp': (context) => SignUp(),
        '/splash': (context) => SplashScreen(),

      
        //'/tes': (context) => tessW(),
      },
      initialRoute: '/',
    );
  }
}

// JUST NOTE for COLOR 

// WARNA TOSCA      29B3AD Color.fromARGB(255, 41, 179, 173)
// WARNA Biru Muda  1D486A Color.fromARGB(255, 29, 72, 106)
// WARNA Biru Tua   122D42 Color.fromARGB(255, 18, 45, 66)
// WARNA Abu cerah  D9D9D9 Color.fromARGB(255, 217, 217, 217)
