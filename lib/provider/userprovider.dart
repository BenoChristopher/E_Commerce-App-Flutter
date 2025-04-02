

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

  List<Map<String, dynamic>> _addresses = [];

  List<Map<String, dynamic>> get addresses => _addresses;

  String _phoneNumber = "";

String get phoneNumber => _phoneNumber;


  void setUsername(String username) {
    _userName = username;
    notifyListeners();
  }

  String get userId {
    return _auth.currentUser?.uid ?? "";
  }

  UserProvider() {
    if (userId.isNotEmpty) {
      loadCart(); // Load cart items on startup
    }
  }

  /// 🔥 **Load Cart from Firestore**
  Future<void> loadCart() async {
    if (userId.isEmpty) return;

    try {
      QuerySnapshot snapshot = await _firestore
          .collection("users")
          .doc(userId)
          .collection("cart")
          .get();

      _cart = snapshot.docs.map((doc) {
        return {
          "id": doc.id,
          "name": doc["name"],
          "price": doc["price"],
          "image": doc["image"],
          "size": doc["size"],
          "quantity": doc["quantity"],
          "totalPrice": doc["totalPrice"],
        };
      }).toList();

      notifyListeners();
    } catch (e) {
      print("Error loading cart: $e");
    }
  }

  /// 🔥 **Add Item to Cart**
  Future<void> addCart(Map<String, dynamic> product) async {
    if (userId.isEmpty) return;

    try {
      String docId = _firestore
          .collection("users")
          .doc(userId)
          .collection("cart")
          .doc()
          .id;

      Map<String, dynamic> cartItem = {
        "id": docId,
        "name": product["name"],
        "price": product["price"],
        "image": product["image"],
        "size": product["size"],
        "quantity": product["quantity"],
        "totalPrice": product["totalPrice"]
      };

      await _firestore
          .collection("users")
          .doc(userId)
          .collection("cart")
          .doc(docId)
          .set(cartItem);

      _cart.add(cartItem);
      notifyListeners();
    } catch (e) {
      print("Error adding to cart: $e");
    }
  }

  /// 🔥 **Remove Item from Cart**
  Future<void> removeFromCart(String itemId, int index) async {
    if (userId.isEmpty) return;

    try {
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("cart")
          .doc(itemId)
          .delete();

      _cart.removeAt(index);
      notifyListeners();
    } catch (e) {
      print("Error removing item from cart: $e");
    }
  }
  Future<void> loadAddresses() async {
    if (userId.isEmpty) return;

    try {
      QuerySnapshot snapshot = await _firestore
          .collection("users")
          .doc(userId)
          .collection("addresses")
          .get();

      _addresses = snapshot.docs.map((doc) {
        return {
          "id": doc.id,
          "name": doc["name"],
          "address": doc["address"],
          "phone": doc["phone"],
          "pincode": doc["pincode"],
        };
      }).toList();

      notifyListeners();
    } catch (e) {
      print("Error loading addresses: $e");
    }
  }

  /// Add address to Firestore
  Future<void> addAddress(Map<String, String> newAddress) async {
    if (userId.isEmpty) return;

    try {
      DocumentReference docRef = await _firestore
          .collection("users")
          .doc(userId)
          .collection("addresses")
          .add(newAddress);

      _addresses.add({...newAddress, "id": docRef.id});
      notifyListeners();
    } catch (e) {
      print("Error adding address: $e");
    }
  }

  Future<void> updateAddress(Map<String, dynamic> updatedAddress) async {
  if (userId.isEmpty) return;

  try {
    // 🔥 Update Firestore
    await _firestore
        .collection("users")
        .doc(userId)
        .collection("addresses")
        .doc(updatedAddress["id"])
        .update({
      "name": updatedAddress["name"],
      "address": updatedAddress["address"],
      "phone": updatedAddress["phone"],
      "pincode": updatedAddress["pincode"],
    });

    // 🔄 Update local list
    final index = _addresses.indexWhere((addr) => addr["id"] == updatedAddress["id"]);
    if (index != -1) {
      _addresses[index] = updatedAddress;
      notifyListeners(); // Refresh UI
    } else {
      print("Address ID not found!");
    }
  } catch (e) {
    print("Error updating address: $e");
  }
}







  /// Remove address from Firestore
  Future<void> removeAddress(String addressId) async {
    if (userId.isEmpty) return;

    try {
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("addresses")
          .doc(addressId)
          .delete();

      _addresses.removeWhere((address) => address["id"] == addressId);
      notifyListeners();
    } catch (e) {
      print("Error deleting address: $e");
    }
  }

  
}

  


