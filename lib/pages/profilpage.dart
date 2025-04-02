import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/userprovider.dart';

class MyProfile extends StatefulWidget {
  

  const MyProfile({super.key, });

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    super.initState();

    // ✅ Load addresses when profile page is opened
    Future.microtask(() {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.loadAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
      
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : null,
                child: user?.photoURL == null
                    ? Icon(Icons.person, size: 50, color: Colors.grey[700])
                    : null,
              ),
            ),

            SizedBox(height: 10),

            // Name
            Text(
              userProvider.userName.isNotEmpty
                  ? userProvider.userName
                  : "Guest User",
              style: GoogleFonts.blinker(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 5),

            // Email
            Text(
              user?.email ?? "No Email",
              style: GoogleFonts.blinker(fontSize: 16, color: Colors.grey[700]),
            ),

            SizedBox(height: 15),

            // Address Section with Edit Option
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Address:",
                  style: GoogleFonts.blinker(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    if (userProvider.addresses.isNotEmpty) {
                      _editAddress(context, userProvider);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("No address to edit!")),
                      );
                    }
                  },
                ),
              ],
            ),

            userProvider.addresses.isNotEmpty
                ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    maxLines: 3,
                      userProvider.addresses[0]["address"],
                      style: GoogleFonts.blinker(fontSize: 16, color: Colors.grey[700],),
                    ),
                )
                : Center(
                    child: CircularProgressIndicator(), // 🔄 Show loader if data is not ready
                  ),

            SizedBox(height: 20),

            // Sign Out Button
            ElevatedButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, "/login");
              },
              icon: Icon(Icons.logout, color: Colors.white),
              label: Text("Sign Out", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 **Edit Address Dialog**
  void _editAddress(BuildContext context, UserProvider userProvider) {
    final TextEditingController _addressController = TextEditingController();
    _addressController.text = userProvider.addresses.isNotEmpty
        ? userProvider.addresses[0]["address"]
        : "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Address"),
          content: TextField(
            controller: _addressController,
            decoration: InputDecoration(hintText: "Enter new address"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_addressController.text.isNotEmpty) {
                  String addressId = userProvider.addresses[0]["id"];
                  await userProvider.updateAddress({
                    "id": addressId,
                    "name": userProvider.addresses[0]["name"],
                    "address": _addressController.text,
                    "phone": userProvider.addresses[0]["phone"],
                    "pincode": userProvider.addresses[0]["pincode"],
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
