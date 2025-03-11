import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mca_project/auth/database.dart';
import 'package:mca_project/components/textfield.dart';
import 'package:mca_project/pages/homepage.dart';
import 'package:random_string/random_string.dart';



class Uploadproduct extends StatefulWidget {

  
  Uploadproduct({super.key});

  @override
  State<Uploadproduct> createState() => _UploadproductState();
}

class _UploadproductState extends State<Uploadproduct> {
  //void Function(dynamic)? onChanged;
  TextEditingController productnamecontroller = TextEditingController();
  TextEditingController productpricecontroller = TextEditingController();
  TextEditingController productdescontroller = TextEditingController();

  final List categories =['Shoe','Shirt','Pant','Watch','Bag','Glasses'
];
final ImagePicker _picker = ImagePicker();
File ?selectedImage;

Future getImage() async{
  var image =await _picker.pickImage(source: ImageSource.gallery);
  selectedImage = File(image!.path);
  setState(() {
    
  });

}

String ?value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView
      (
        child: Container(
          padding: EdgeInsets.only(top: 60,left: 23,right: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
               Row(
                 children: [
                  GestureDetector(
                    onTap: (){},
                    child: Icon(Icons.arrow_back_ios_new_rounded)),
                  SizedBox(width: MediaQuery.of(context).size.width/40),
        
                   Text(
                      'Upload Product 🕹',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                   ),
                 ],
               ),
                SizedBox(height: 40),
                selectedImage != null ? Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(selectedImage!,  height: 150,
                      width: 150,),
                  ),
                ):
               Center(
                 child: GestureDetector(
                  onTap:(){
                     getImage();
                  },
                   child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2.0),
                    borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.add_a_photo_outlined),
                   ),
                 ),
               ),
                SizedBox(height: 20),
               Text(
                      'Enter Product Name',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        
                      ),
               ),
                SizedBox(height: 6),
               
               Container(
                width: MediaQuery.of(context).size.width,
              
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8)),
                child: MyTextField(hintText: 'Ex:Shoe', 
                obsecurText: false,
                controller: productnamecontroller,
                icon: Icon(Icons.text_fields_outlined)),
                
              
               ),SizedBox(height: 20),
               Text(
                      'Enter Product Price',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        
                      ),
               ),
                SizedBox(height: 6),
               
               Container(
                width: MediaQuery.of(context).size.width,
              
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: MyTextField(
                  hintText: 'Ex:\$400', obsecurText:
                 false, controller: productpricecontroller,
                  icon: Icon(Icons.text_fields_outlined)),
                
              
               ),
               
                 
                SizedBox(height: 20),
               Text(
                      'Enter Product Price',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        
                      ),
               ),
                SizedBox(height: 6),
                
               
               Container(
                padding: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height,
              
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  
                  borderRadius: BorderRadius.circular(8),),
                child:DropdownButton(
                  underline: SizedBox(),
                  items: categories.map((item) =>DropdownMenuItem(
                    
        
                  value: item,
                  
                  child: Text(item,style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black,
                      ),),),).toList(), onChanged: (value){
                        setState(() {
                          this.value = value.toString();
                        });
                      },
                      hint: Text('Select Category',style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black,
                        
                      ),
                      ),
                      
                      
                    
                      value: value,
                      ),
                      
              
               ),SizedBox(height: 20),
                  Text(
                      'Enter Product Description',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        
                      ),
               ),
                SizedBox(height: 6),
               
               Container(
                width: MediaQuery.of(context).size.width,
              
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: TextField(
                  maxLines: 6,
                  controller: productdescontroller,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'About the product',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    //prefixIcon: Icon(Icons.text_fields_outlined),
                    //prefix: Icon(Icons.text_fields_outlined),
                   prefixIconColor: Colors.grey.shade600,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
               
              
               ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: ()async{
                    // String addId = randomAlphaNumeric(10);
                    // Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("blogImages").child(addId);
        
                    // final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
                    
        
                    // var downloadUrl = await(await task).ref.getDownloadURL();
        
                  String id =randomAlphaNumeric(10);
        
                    Map<String,dynamic> userInfo ={
        
                      "Image": "",
                      "Name":productnamecontroller.text,
                      "Price":productpricecontroller.text,
                      "Category":value,
                      "Description":productdescontroller.text,
        
        
                    };
                    await DataBaseMethod().addEvents(userInfo, id).then((value){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                         backgroundColor: Colors.green,
                      
                        content: Text('Product Uploaded')));
        
                        setState(() {
                          productnamecontroller.clear();
                          productpricecontroller.clear();
                          productdescontroller.clear();
                          selectedImage = null;
                        });
                      
                    });
        
        
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: primecolor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Upload Product',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
}
}