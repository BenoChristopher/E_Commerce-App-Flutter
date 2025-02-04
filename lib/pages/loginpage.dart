import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mca_project/auth/authmethods.dart';
import 'package:mca_project/components/textfield.dart';
import 'package:mca_project/helper/helperfunction.dart';
import 'package:lottie/lottie.dart';


class MyLoginPage extends StatefulWidget {

  final VoidCallback onToggle;
  
  MyLoginPage({
    super.key,
    required this.onToggle,
  });

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passcontroller = TextEditingController();

  var primecolor = const Color(0xFF00c7e7);

  void loginUser() async {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent closing the dialog by tapping outside
      builder: (context) => Center(
        child: Lottie.asset('asset/images/Animation - 1736521859654.json'),
      ),
    );

    // Automatically close the dialog after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context); // Close the dialog
      }
    });
//try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passcontroller.text);

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      displayMessageToUser(e.code ?? 'Invalid credentials', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'CART',
                      style: GoogleFonts.bubblegumSans(
                          textStyle: TextStyle(
                              fontSize: 40,
                              color: primecolor,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      'IFY',
                      style: GoogleFonts.bubblegumSans(
                          textStyle: TextStyle(
                              fontSize: 40,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back',
                      style: GoogleFonts.blinker(fontSize: 30),
                    ),
                    Text(
                      'Login',
                      style: GoogleFonts.blinker(
                          fontSize: 80, fontWeight: FontWeight.bold),
                    ),
                    MyTextField(
                      hintText: 'Enter a mail',
                      obsecurText: false,
                      controller: emailcontroller,
                      icon: Icon(Icons.mail),
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    MyTextField(
                      hintText: 'Enter a password',
                      obsecurText: true,
                      controller: passcontroller,
                      icon: Icon(Icons.key),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Text('Forgot password?')],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    MaterialButton(
                        height: 50,
                        minWidth: 362,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: primecolor,
                        onPressed: loginUser,
                        child: Text(
                          'Login',
                          style: GoogleFonts.blinker(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                     height: 19,
                    ),
                  
                    
                     
                      Column(
                        children: [
                     Text('------ Or Login With ------ ',style: GoogleFonts.blinker(fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: 19,
                    ),

                          GestureDetector(
                            onTap: ()=> Authmethods().signInWithGoogle(context),
                            child: Container(
                              height:50,
                              width: 50,
                              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3),
                               
                              child:  Image.asset('asset/images/google.png')),
                          ),
                        ],
                      ),
                         SizedBox(
                     height: 19,
                    ),
                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                        ),
                        GestureDetector(
                          onTap: widget.onToggle,
                          // onTap: () {
                          //   Navigator.pushNamed(context, '/registerpage');

                          // },
                          child: Text(
                            " Register here",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          
                        ),
                      ],
                    ),
                    
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
