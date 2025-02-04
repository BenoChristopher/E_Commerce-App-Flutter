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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          

          
          
          backgroundColor: Colors.green,
        content: Text('Registered Successfully',style:TextStyle(color: Colors.white,fontSize:20),),
        ));

Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  MyHomePage()

));

     };


}
}

// }


// signInWithGoogle(BuildContext context) async {
//   try {
//     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    
//     // Ensure user is signed in
//     if (googleSignInAccount == null) {
//       return; // User canceled the sign-in process
//     }

//     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

//     final AuthCredential credential = GoogleAuthProvider.credential(
//       idToken: googleSignInAuthentication.idToken,
//       accessToken: googleSignInAuthentication.accessToken,
//     );

//     UserCredential result = await auth.signInWithCredential(credential);
//     User? userDetails = result.user;

//     if (result != null && userDetails != null) {
//       // Handle user details
//       String userEmail = userDetails.email ?? "Email not available"; // Check if email is null

//       Map<String, dynamic> userInfoMap = {
//         "Name": userDetails.displayName,
//         "Image": userDetails.photoURL,
//         "E-Mail": userEmail,  // Ensure email is present
//         "Id": userDetails.uid,
//       };

//       // Save to the database
//       await DataBaseMethod().addUserDetails(userInfoMap, userDetails.uid).then((value) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             backgroundColor: Colors.green,
//             content: Text('Registered Successfully', style: TextStyle(color: Colors.white, fontSize: 20)),
//           ),
//         );

//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
//       });
//     } else {
//       // If something goes wrong
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.red,
//           content: Text('Login failed', style: TextStyle(color: Colors.white, fontSize: 20)),
//         ),
//       );
//     }
//   } catch (e) {
//     print("Error during Google Sign-In: $e");
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         backgroundColor: Colors.red,
//         content: Text('An error occurred: $e', style: TextStyle(color: Colors.white, fontSize: 20)),
//       ),
//     );
//   }
// }


// }


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mca_project/auth/database.dart';
// import 'package:mca_project/pages/homepage.dart';

// class AuthMethods {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();

//   Future<User?> getCurrentUser() async {
//     return auth.currentUser;
//   }

//   Future<void> signInWithGoogle(BuildContext context) async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

//       if (googleSignInAccount == null) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Google Sign-In cancelled')));
//         return;
//       }

//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken,
//       );

//       UserCredential result = await auth.signInWithCredential(credential);
//       User? userDetails = result.user;

//       if (userDetails != null) {
//         Map<String, dynamic> userInfoMap = {
//           "Name": userDetails.displayName ?? "Unknown",
//           "Image": userDetails.photoURL ?? "",
//           "E-Mail": userDetails.email ?? "No Email",
//           "Id": userDetails.uid,
//         };

//         await DataBaseMethod().addUserDetails(userInfoMap, userDetails.uid);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered Successfully')));

//         // Navigate to homepage
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
//       }
//     } catch (e) {
//       print("Google Sign-In Error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign-In Failed: ${e.toString()}')));
//     }
//   }
// }




// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mca_project/auth/database.dart'; // Adjust the path as needed
// import 'package:mca_project/pages/homepage.dart';

// class Authmethods {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();

//   Future<User?> getCurrrentUser() async {
//     return auth.currentUser;
//   }

//   Future<void> signInWithGoogle(BuildContext context) async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//       if (googleSignInAccount == null) {
//         // User canceled the sign in
//         return;
//       }

//       final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         idToken: googleAuth.idToken,
//         accessToken: googleAuth.accessToken,
//       );

//       UserCredential result = await auth.signInWithCredential(credential);
//       User? userDetails = result.user;

//       if (userDetails != null) {
//         // Prepare a map of user information
//         Map<String, dynamic> userInfoMap = {
//           "Name": userDetails.displayName,
//           "Image": userDetails.photoURL,
//           "E-Mail": userDetails.email,
//           "Id": userDetails.uid,
//         };

//         // Save user details in Firestore
//         await DataBaseMethod().addUserDetails(userInfoMap, userDetails.uid);
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('Registered Successfully')));
        
//         // Navigate to Home Page after successful registration/login
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => MyHomePage()),
//         );
//       }
//     } catch (e) {
//       print("Error in Google Sign-In: $e");
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Error: $e")));
//     }
//   }
// }
