import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mca_project/auth/database.dart';
import 'package:mca_project/pages/homepage.dart';

class Authmethods {

  final FirebaseAuth auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  getCurrrentUser()async{

    return await auth.currentUser;


  }




signInWithGoogle(BuildContext context) async{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final GoogleSignInAccount? googleSignInAccount =  await googleSignIn.signIn();

  final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication?.idToken, accessToken: googleSignInAuthentication?.accessToken );

    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User? userDetails = result.user;

     if(result != null) {

      Map<String, dynamic> userInfoMap = {

        "Name": userDetails!.displayName,
        "Image":userDetails!.photoURL,
        "E-Mail":userDetails.email,
        "Id":userDetails.uid,

      };
       await DataBaseMethod().addUserDetails(userInfoMap, userDetails.uid);
      // await DataBaseMethod()
      // .addUserDetails(userInfoMap, userDetails.uid).then((value){
      print('error1');

      print('error1');
      print('error1');
      print('error1');
      print('error1');

      
      WidgetsBinding.instance.addPostFrameCallback((_) {
  if (!context.mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Registered Successfully'),
      backgroundColor: Colors.green,
    ),
  );
});


     

        print('error 2');
         print('error 2');
          print('error 2');
           print('error 2');
            print('error 2');
             print('error 2');
              print('error 2');

        await Future.delayed(Duration(seconds:3)
        );



Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  MyHomePage()

),
);

     };


}
}

