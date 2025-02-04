import 'package:flutter/material.dart';
import 'package:mca_project/auth/auth.dart';
import 'package:mca_project/pages/loginpage.dart';
import 'package:mca_project/pages/registerpage.dart';
import 'package:mca_project/themes/darktheme.dart';
import 'package:mca_project/themes/lightmode.dart';
import 'pages/detailspage.dart';
import 'pages/welcomepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'provider/userprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: 
      //ProductDetailPage(),
      MyWelComePage(),
      theme: lightMode,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      // routes: {
      //   "/loginpage": (context) => MyLoginPage(
      //         onToggle: () {
      //           Navigator.pushNamed(context, '/registerpage');
      //         },
      //       ),
      //   "/registerpage": (context) => MyRegisterPage(
      //         onToggle: () {
      //           Navigator.pushNamed(context, '/loginpage');
      //         },
      //       ),
      // },
    );
  }
}
