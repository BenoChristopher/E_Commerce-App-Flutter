import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/textfield.dart';
import '../helper/helperfunction.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyRegisterPage extends StatefulWidget {
  final VoidCallback onToggle;

  final void Function()? onTap;
  // final VoidCallback onTap;
  MyRegisterPage({
    super.key,
    required this.onToggle,
    this.onTap,
  });

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  final TextEditingController usernamecontroller = TextEditingController();

  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passcontroller = TextEditingController();

  final TextEditingController confirmpasscontroller = TextEditingController();

  // void registerUser() async {
  //   //show loading circle
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });

  //   //password match
  //   if (passcontroller.text != confirmpasscontroller) {
  //     Navigator.pop(context);

  //     //display error message
  //     displayMessageToUser("Password doesn't match", context);
  //   }

  //   try {
  //     //create a user
  //     UserCredential? usercredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //             email: emailcontroller.text, password: passcontroller.text);

  //     Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) {
  //     Navigator.pop(context);

  //     displayMessageToUser(e.code, context);
  //   }
  // }

  void testFirebaseConnection() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      print('Firebase connection successful!');
    } catch (e) {
      print('Firebase connection failed: $e');
    }
  }

  // void registerUser() async {
  //   if (usernamecontroller.text.isEmpty ||
  //       emailcontroller.text.isEmpty ||
  //       passcontroller.text.isEmpty ||
  //       confirmpasscontroller.text.isEmpty) {
  //     displayMessageToUser("All fields are required", context);
  //     return;
  //   }

  //   if (passcontroller.text != confirmpasscontroller.text) {
  //     displayMessageToUser("Passwords don't match", context);
  //     return;
  //   }

  //   // Show loading
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });

  //   try {
  //     // Create user
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailcontroller.text.trim(),
  //       password: passcontroller.text.trim(),
  //     );

  //     Navigator.pop(context); // Close loading dialog
  //     displayMessageToUser("Registration successful!", context);
  //   } on FirebaseAuthException catch (e) {
  //     Navigator.pop(context); // Close loading dialog
  //     displayMessageToUser(e.message ?? "Error occurred", context);
  //   }
  // }

  void registerUser() async {
    // Validate input
    if (usernamecontroller.text.isEmpty ||
        emailcontroller.text.isEmpty ||
        passcontroller.text.isEmpty ||
        confirmpasscontroller.text.isEmpty) {
      displayMessageToUser("All fields are required", context);
      return;
    }

    // Passwords must match
    if (passcontroller.text != confirmpasscontroller.text) {
      displayMessageToUser("Passwords don't match", context);
      return;
    }

    // Show loading
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      // Register user
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passcontroller.text.trim(),
      );

      // Dismiss loading dialog
      Navigator.pop(context);

      // Success message
      displayMessageToUser("Registration successful!", context);
    } on FirebaseAuthException catch (e) {
      // Dismiss loading dialog
      Navigator.pop(context);

      // Show error message
      displayMessageToUser(e.message ?? "An error occurred", context);
    }
  }

  var primecolor = const Color(0xFF00c7e7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                // SizedBox(
                //   height: 133,
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back',
                      style: GoogleFonts.blinker(fontSize: 30),
                    ),
                    Text(
                      'SignIn',
                      style: GoogleFonts.blinker(
                          fontSize: 80, fontWeight: FontWeight.bold),
                    ),
                    MyTextField(
                      hintText: 'Enter you username',
                      obsecurText: false,
                      controller: usernamecontroller,
                      icon: Icon(Icons.mail),
                    ),
                    SizedBox(
                      height: 19,
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
                      height: 19,
                    ),
                    MyTextField(
                      hintText: 'Confirm password',
                      obsecurText: true,
                      controller: confirmpasscontroller,
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
                        onPressed: registerUser,
                        child: Text(
                          'SignUp',
                          style: GoogleFonts.blinker(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 25,
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
                          //   Navigator.pushNamed(context, '/loginpage');

                          // },
                          child: Text(
                            " Login here",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 133,
                    // ),
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
