import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mca_project/provider/userprovider.dart';
import 'package:provider/provider.dart';

import '../auth/authmethods.dart';
import '../auth/database.dart';
import '../components/textfield.dart';
import '../helper/helperfunction.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'homepage.dart';

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

  // void testFirebaseConnection() async {
  //   try {
  //     await FirebaseAuth.instance.signInAnonymously();
  //     print('Firebase connection successful!');
  //   } catch (e) {
  //     print('Firebase connection failed: $e');
  //   }
  // }

void registerUser(BuildContext context, UserProvider userprovider) async {
  
  if (usernamecontroller.text.isEmpty ||
      emailcontroller.text.isEmpty ||
      passcontroller.text.isEmpty ||
      confirmpasscontroller.text.isEmpty) {
    displayMessageToUser("All fields are required", context);
    return;
  }

  
  if (passcontroller.text != confirmpasscontroller.text) {
    displayMessageToUser("Passwords don't match", context);
    return;
  }

 
  showDialog(
    context: context,
    builder: (context) => Center(
      child: CircularProgressIndicator(
        color: primecolor 
      ),
    ),
  );

  try {
    
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailcontroller.text.trim(),
      password: passcontroller.text.trim(),
    );

    
    await userCredential.user!
        .updateDisplayName(usernamecontroller.text.trim());

    
    userprovider.setUsername(usernamecontroller.text.trim());

    
    Map<String, dynamic> userInfoMap = {
      "Name": userCredential.user!.displayName,
      "Image": userCredential.user!.photoURL ?? "",  // Handle null photoURL
      "E-Mail": userCredential.user!.email,
      "Id": userCredential.user!.uid,
    };

    await DataBaseMethod().addUserDetails(userInfoMap, userCredential.user!.uid);

    
    Navigator.pop(context);

    
    displayMessageToUser("Registration successful!", context);

    
    Navigator.pop(context);

  } on FirebaseAuthException catch (e) {
    
    Navigator.pop(context);

    
    displayMessageToUser(e.message ?? "An error occurred", context);
  }
}

  

  var primecolor = const Color(0xFF00c7e7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 36,
            right: 36,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  height: 230,
                ),
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
                      icon: Icon(Icons.account_circle_rounded),
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
                        onPressed: () {
                          final userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          registerUser(context, userProvider);
                        },
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
                    //  Column(
                    //     children: [
                    //  Text('------ Or Login With ------ ',style: GoogleFonts.blinker(fontWeight: FontWeight.bold),),
                    // SizedBox(
                    //   height: 19,
                    // ),

                    //       GestureDetector(
                    //         onTap: (){
                    //           Authmethods().signInWithGoogle(context);
                    //         },
                    //         child: Container(
                    //           height:50,
                    //           width: 50,
                    //           margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3),
                               
                    //           child:  Image.asset('asset/images/google.png')),
                    //       ),
                    //     ],
                    //   ),
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
                    SizedBox(
                      height: 35,
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











