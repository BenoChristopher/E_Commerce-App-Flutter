
import 'package:flutter/material.dart';
import 'package:mca_project/components/textfield.dart';
import 'package:mca_project/pages/checkoutpage.dart';
import 'package:provider/provider.dart';
import '../provider/userprovider.dart';

class MyAddressPage extends StatefulWidget {
  @override
  _MyAddressPageState createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  int? _selectedIndex; // 🔹 Stores selected address index

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<UserProvider>(context, listen: false).loadAddresses();
    });
  }

  void addAddress() {
    if (_nameController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _pincodeController.text.isNotEmpty) {
      
      final newAddress = {
        "name": _nameController.text,
        "address": _addressController.text,
        "phone": _phoneController.text,
        "pincode": _pincodeController.text,
      };

      Provider.of<UserProvider>(context, listen: false).addAddress(newAddress);

      _nameController.clear();
      _addressController.clear();
      _phoneController.clear();
      _pincodeController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
    }
  }

  void proceedToCheckout() {
    final addresses = Provider.of<UserProvider>(context, listen: false).addresses;

    if (addresses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please add at least one address to proceed")),
      );
      return;
    }

    if (_selectedIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an address to proceed")),
      );
      return;
    }

    final selectedAddress = addresses[_selectedIndex!]; // ✅ Pass selected address only

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckoutPage(addresses: [selectedAddress])),
    );
  }

  void editAddress(BuildContext context, int index, Map<String, dynamic> address) {
  _nameController.text = address["name"];
  _addressController.text = address["address"];
  _phoneController.text = address["phone"];
  _pincodeController.text = address["pincode"];

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Edit Address"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextField(controller: _nameController, hintText: "Full Name", obsecurText: false, icon: Icon(Icons.person)),
          SizedBox(height: 10),
          MyTextField(controller: _addressController, hintText: "Address", obsecurText: false, icon: Icon(Icons.home)),
          SizedBox(height: 10),
          MyTextField(controller: _phoneController, hintText: "Phone Number", obsecurText: false, icon: Icon(Icons.phone)),
          SizedBox(height: 10),
          MyTextField(controller: _pincodeController, hintText: "Pincode", obsecurText: false, icon: Icon(Icons.key_rounded)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            // ✅ Ensure the ID exists and is correctly assigned
            final updatedAddress = {
              "id": address.containsKey("id") ? address["id"] : index.toString(), // Ensure a valid ID
              "name": _nameController.text,
              "address": _addressController.text,
              "phone": _phoneController.text,
              "pincode": _pincodeController.text,
            };

            Provider.of<UserProvider>(context, listen: false).updateAddress(updatedAddress);

            Navigator.pop(context); // Close the dialog
          },
          child: Text("Save"),
        ),
      ],
    ),
  );
}


//   void editAddress(BuildContext context, int index, Map<String, dynamic> address) {
//     _nameController.text = address["name"];
//     _addressController.text = address["address"];
//     _phoneController.text = address["phone"];
//     _pincodeController.text = address["pincode"];

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Edit Address"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             MyTextField(controller: _nameController, hintText: "Full Name", obsecurText: false, icon: Icon(Icons.person)),
//             SizedBox(height: 10),
//             MyTextField(controller: _addressController, hintText: "Address", obsecurText: false, icon: Icon(Icons.home)),
//             SizedBox(height: 10),
//             MyTextField(controller: _phoneController, hintText: "Phone Number", obsecurText: false, icon: Icon(Icons.phone)),
//             SizedBox(height: 10),
//             MyTextField(controller: _pincodeController, hintText: "Pincode", obsecurText: false, icon: Icon(Icons.key_rounded)),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context), 
//             child: Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final updatedAddress = {
//   "id": address["id"] ?? index, // Ensure an ID exists
//   "name": _nameController.text,
//   "address": _addressController.text,
//   "phone": _phoneController.text,
//   "pincode": _pincodeController.text,
// };

//               Provider.of<UserProvider>(context, listen: false).updateAddress(updatedAddress);

//               Navigator.pop(context); // Close the dialog
//             },
//             child: Text("Save"),
//           ),
//         ],
//       ),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final addresses = userProvider.addresses;

    return Scaffold(
      appBar: AppBar(title: Text("Select Address")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            MyTextField(controller: _nameController, hintText: "Full Name", obsecurText: false, icon: Icon(Icons.person)),
            SizedBox(height: 19),
            MyTextField(controller: _addressController, hintText: "Address", obsecurText: false, icon: Icon(Icons.home)),
            SizedBox(height: 19),
            MyTextField(controller: _phoneController, hintText: "Phone Number", obsecurText: false, icon: Icon(Icons.phone)),
            SizedBox(height: 19),
            MyTextField(controller: _pincodeController, hintText: "Pincode", obsecurText: false, icon: Icon(Icons.key_rounded)),

            SizedBox(height: 25),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: addAddress,
              child: Text("Add Address", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),

            SizedBox(height: 20),

            Expanded(
              child: addresses.isEmpty
                  ? Center(child: Text("No addresses added yet"))
                  : ListView.builder(
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        final address = addresses[index];
                        return Card(
                          elevation: 2.0,
                          margin: EdgeInsets.only(bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.home, color: Colors.blue), // 🏡 Home Icon
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(address["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text("${address["address"]}", maxLines: 4),
                                      Text("Phone: ${address["phone"]}"),
                                      Text("Pincode: ${address["pincode"]}"),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          MaterialButton(
                                            onPressed: () => editAddress(context, index, address), 
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit, color: Colors.blue),
                                                Text('Edit', style: TextStyle(color: Colors.blue)),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              Provider.of<UserProvider>(context, listen: false).removeAddress(address["id"]);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Radio(
                                  value: index,
                                  groupValue: _selectedIndex,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedIndex = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),

            ElevatedButton(
              onPressed: proceedToCheckout,
              child: Text("Proceed to Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}


