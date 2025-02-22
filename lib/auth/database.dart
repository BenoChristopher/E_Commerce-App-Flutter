import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DataBaseMethod{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future addUserDetails(Map<String,dynamic> userInfoMap, String id) async{

  //   return await FirebaseFirestore.instance.
  //   collection("users").
  //   doc(id).set(userInfoMap);
  // }

  Future<void> addUserDetails(Map<String, dynamic> userInfoMap, String uid) async {
    try {
      await _firestore.collection("users").doc(uid).set(userInfoMap);
    } catch (e) {
      print("Error saving user details: $e");
    }
  }

  
  Future addEvents (Map<String,dynamic> userInfoMap, String id) async{

    return await FirebaseFirestore.instance.
    collection("Event").
    doc(id).set(userInfoMap);
  }
  
  
}

