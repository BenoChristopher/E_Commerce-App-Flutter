import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DataBaseMethod{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  

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

  Future<Stream<QuerySnapshot>> getAllProduct()async{
    return await FirebaseFirestore.instance.collection("Event").snapshots();
  }


  

  //============================================//
  //ADD CATEGORIES


Future<void> addCategory(String categoryName) async {
    try {
      await _firestore.collection("categories").add({"name": categoryName});
    } catch (e) {
      print("Error adding category: $e");
    }
  }

  /// Fetch All Categories from Firestore
  Future<List<String>> getCategories() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection("categories").get();
      return snapshot.docs.map((doc) => doc["name"] as String).toList();
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }
  
  
  
} 

