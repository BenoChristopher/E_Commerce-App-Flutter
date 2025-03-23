
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mca_project/auth/database.dart';
import 'package:mca_project/components/textfield.dart';
import 'package:mca_project/pages/homepage.dart';
import 'package:random_string/random_string.dart';

class UploadProduct extends StatefulWidget {
  @override
  State<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDesController = TextEditingController();
  TextEditingController newCategoryController = TextEditingController(); // For adding new categories

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String? selectedCategory;
  bool _isUploading = false; 
  List<String> categories = []; // Dynamic category list

  @override
  void initState() {
    super.initState();
    fetchCategories(); // Load categories from Firestore
  }

  Future<void> fetchCategories() async {
  categories = await DataBaseMethod().getCategories();
  setState(() {});
}


  /// Pick Image from Gallery
  Future<void> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  /// Upload Image to Firebase Storage
  Future<String?> uploadImage(File image) async {
    try {
      String imageId = randomAlphaNumeric(10);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("productImages/$imageId");
      UploadTask uploadTask = firebaseStorageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  /// Upload Product Data
  Future<void> uploadProduct() async {
    if (selectedImage == null || selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please select an image and category!'),
      ));
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      String? imageUrl = await uploadImage(selectedImage!);
      if (imageUrl == null) {
        throw "Image upload failed!";
      }

      String productId = randomAlphaNumeric(10);
      Map<String, dynamic> productInfo = {
        "Image": imageUrl,
        "Name": productNameController.text,
        "Price": productPriceController.text,
        "Category": selectedCategory,
        "Description": productDesController.text,
      };

      await DataBaseMethod().addEvents(productInfo, productId);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text('Product Uploaded Successfully'),
      ));

      // Clear fields after upload
      setState(() {
        productNameController.clear();
        productPriceController.clear();
        productDesController.clear();
        selectedImage = null;
        selectedCategory = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Upload failed: $e'),
      ));
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  /// Add New Category to Firestore
 Future<void> addCategory() async {
  if (newCategoryController.text.trim().isEmpty) return;
  await DataBaseMethod().addCategory(newCategoryController.text.trim());
  fetchCategories(); // Refresh the category list
  Navigator.pop(context);
  newCategoryController.clear();
}


  /// Show Dialog to Add Category
  void showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Category"),
        content: TextField(
          controller: newCategoryController,
          decoration: InputDecoration(hintText: "Enter category name"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          TextButton(onPressed: addCategory, child: Text("Add")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60, left: 23, right: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios_new_rounded)),
                  SizedBox(width: 10),
                  Text(
                    'Upload Product 🕹',
                    style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 40),

              /// Image Picker
              Center(
                child: GestureDetector(
                  onTap: getImage,
                  child: selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(selectedImage!, height: 150, width: 150, fit: BoxFit.cover),
                        )
                      : Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.add_a_photo_outlined),
                        ),
                ),
              ),
              SizedBox(height: 20),
               Text('Enter Product Name', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 6),
              MyTextField(hintText: 'Ex: Shoe', obsecurText: false, controller: productNameController, icon: Icon(Icons.text_fields_outlined)),
              SizedBox(height: 20),

              /// Product Price
              Text('Enter Product Price', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 6),
              MyTextField(hintText: 'Ex: \$400', obsecurText: false, controller: productPriceController, icon: Icon(Icons.attach_money)),
              SizedBox(height: 20),

              /// Category Dropdown
              // Text('Select Product Category', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
              // SizedBox(height: 6),
              // Container(
              //   padding: EdgeInsets.only(left: 10),
              //   decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
              //   child: DropdownButton<String>(
              //     underline: SizedBox(),
              //     isExpanded: true,
              //     items: categories.map((category) => DropdownMenuItem(value: category, child: Text(category, style: GoogleFonts.inter(fontSize: 16)))).toList(),
              //     onChanged: (value) => setState(() => selectedCategory = value),
              //     hint: Text('Select Category', style: GoogleFonts.inter(fontSize: 16)),
              //     value: selectedCategory,
              //   ),
              // ),
              // SizedBox(height: 20),

              /// Product Description
              Text('Enter Product Description', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 6),
              TextField(
                maxLines: 6,
                controller: productDesController,
                decoration: InputDecoration(hintText: 'About the product', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
              ),
              SizedBox(height: 20),


              /// Category Dropdown with Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Product Category', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
                  IconButton(onPressed: showAddCategoryDialog, icon: Icon(Icons.add_circle, color: primecolor)),
                ],
              ),
              SizedBox(height: 6),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
                child: DropdownButton<String>(
                  underline: SizedBox(),
                  isExpanded: true,
                  items: categories.map((category) => DropdownMenuItem(value: category, child: Text(category, style: GoogleFonts.inter(fontSize: 16)))).toList(),
                  onChanged: (value) => setState(() => selectedCategory = value),
                  hint: Text('Select Category', style: GoogleFonts.inter(fontSize: 16)),
                  value: selectedCategory,
                ),
              ),
              SizedBox(height: 20),

              /// Upload Button
              GestureDetector(
                onTap: _isUploading ? null : uploadProduct,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(color: _isUploading ? Colors.grey : primecolor, borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: _isUploading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Upload Product', style: GoogleFonts.inter(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


