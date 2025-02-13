import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mca_project/components/textfield.dart';
import 'package:mca_project/pages/homepage.dart';



class Uploadproduct extends StatefulWidget {

  
  Uploadproduct({super.key});

  @override
  State<Uploadproduct> createState() => _UploadproductState();
}

class _UploadproductState extends State<Uploadproduct> {
  //void Function(dynamic)? onChanged;
  TextEditingController productcontroller = TextEditingController();

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

      body: Container(
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
              selectedImage != null ? Image.file(selectedImage!,  height: 100,
                width: 100,):
             GestureDetector(
              onTap:(){
                 getImage();
              },
               child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2.0),
                borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.add_a_photo_outlined),
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
              child: MyTextField(hintText: 'Ex:Shoe', obsecurText: false,
               controller: productcontroller,
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
               false, controller: productcontroller,
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
                controller: productcontroller,
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
              Container(
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
          ],
        ),
      ),
    );
}
}