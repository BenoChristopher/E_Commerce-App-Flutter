
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _userName = "";
  List<Map<String, dynamic>> _cart = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get userName => _userName;
  List<Map<String, dynamic>> get cart => _cart;

  void setUsername(String username) {
    _userName = username;
    notifyListeners();
  }

  String get userId {
    return _auth.currentUser?.uid ?? "";
  }

 
  UserProvider() {
    if (userId.isNotEmpty) {
      loadCart(); 
    }
  }

  


  Future<void> addCart(Map<String, dynamic> product) async {
  if (userId.isEmpty) return;

  try {
    String docId = _firestore.collection("users").doc(userId).collection("cart").doc().id;

    Map<String, dynamic> cartItem = {
      "id": docId,
      "name": product["name"],
      "price": product["price"],
      "image": product["image"],
      "size": product["size"], // ✅ Save size in Firestore
      "quantity": product["quantity"],
      "totalPrice": product["totalPrice"]
    };

    await _firestore.collection("users").doc(userId).collection("cart").doc(docId).set(cartItem);

    _cart.add(cartItem);
    notifyListeners();
  } catch (e) {
    print("Error adding to cart: $e");
  }
}


 
  Future<void> removeFromCart(String docId, int index) async {
    if (userId.isEmpty || docId.isEmpty) return;

    try {
      await _firestore.collection("users").doc(userId).collection("cart").doc(docId).delete();

     
      _cart.removeAt(index);
      notifyListeners();
    } catch (e) {
      print("Error deleting cart item: $e");
    }
  }

  Future<void> loadCart() async {
  if (userId.isEmpty) return;

  try {
    final snapshot = await _firestore.collection("users").doc(userId).collection("cart").get();

    _cart = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        "id": doc.id,
        "name": data["name"] ?? "Unknown Product",
        "price": data["price"] ?? "0.0",
        "image": data["image"] ?? "",
        "size": data["size"] ?? "S",
        "quantity": data["quantity"] ?? 1, 
        "totalPrice": data["totalPrice"] ?? "0.0"
      };
    }).toList();

    notifyListeners();
  } catch (e) {
    print("Error loading cart: $e");
  }
}


  // Future<void> loadCart() async {
  //   if (userId.isEmpty) return;

  //   try {
  //     final snapshot = await _firestore.collection("users").doc(userId).collection("cart").get();

  //     _cart = snapshot.docs.map((doc) {
  //       final data = doc.data();
  //       return {
  //         "id": doc.id,
  //         "name": data["name"] ?? "Unknown Product",
  //         "price": data["price"] ?? "0.0",
  //         "image": data["image"] ?? "",
  //         "quantity": data["quantity"] ?? 1, 
  //         "totalPrice": data["totalPrice"] ?? "0.0"
  //       };
  //     }).toList();

  //     notifyListeners();
  //   } catch (e) {
  //     print("Error loading cart: $e");
  //   }
  // }
}
