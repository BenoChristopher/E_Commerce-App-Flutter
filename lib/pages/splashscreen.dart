import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/auth.dart';
import '../components/mybutton.dart';

class MySplashScreen extends StatefulWidget {
  MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MyWelComePageState();
}



class _MyWelComePageState extends State<MySplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AuthPage(),
      ));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    super.dispose();
  }

  var primecolor = const Color(0xFF00c7e7);

  var seccolor = const Color(0xFF75e1f7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 230, child: Image.asset('asset/images/bag.png')),
            SizedBox(height: 37),
            Text(
              'welcome to',
              style: GoogleFonts.bubblegumSans(
                  textStyle: TextStyle(fontSize: 26, color: Colors.grey[700])),
            ),
            Row(
              
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'CART',
                  style: GoogleFonts.bubblegumSans(
                      textStyle: TextStyle(
                          fontSize: 70,
                          color: primecolor,
                          fontWeight: FontWeight.bold)),
                ),
                Text(
                  'IFY',
                  style: GoogleFonts.bubblegumSans(
                      textStyle: TextStyle(
                          fontSize: 70,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Text(
              'Shop more,Spend less',
              style: GoogleFonts.blinker(
                  textStyle: TextStyle(fontSize: 24, color: Colors.grey[700])),
            ),
            SizedBox(
              height: 47,
            ),
          ],
        ),
      ),
    );
  }
}
