
import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> addresses;

  CheckoutPage({required this.addresses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Delivery Address:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  return Card(
                    child: ListTile(
                      title: Text(address["name"]),
                      subtitle: Text(
                          "${address["address"]}\nPhone: ${address["phone"]}\nPincode: ${address["pincode"]}"),
                      leading: Icon(Icons.location_on, color: Colors.blue),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Place order logic here
              },
              child: Text("Place Order"),
            ),
          ],
        ),
      ),
    );
  }
}
