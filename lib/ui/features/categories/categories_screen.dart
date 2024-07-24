// ignore: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/colors.dart';
List<String> photos=[
  "assets/images/cleaning.png",
  "assets/images/maid.png",
  "assets/images/nurse.png",
  "assets/images/washer.png",
  "assets/images/design_2.png",
  "assets/images/man-salon.png",
  "assets/images/pet-services.png",
  "assets/images/Beauty-Salon.png",
  "assets/images/Plumber.png",
  "assets/images/Pest-Control.png",
  "assets/images/Ac-Services.png",
  "assets/images/Car-Services.png",
  
];
List<String> title=[
  "Cleaning",
  "Maid",
  "Nurse",
  "Car Wash",
  "Laundry",
  "Man Salon",
  "Pet Services",
  "Beauty Salon",
  "Plumber",
  "Pest Control",
  "Ac Services",
  "Car Services"
];
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: cWhite,
      body:SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
              // ShadowButton(color: cBlue,icon: Icons.arrow_back_ios_new,),
              SizedBox(height: height*.03,),
              Center(child: Text("Categories",style: GoogleFonts.openSans(color:Colors.black,fontWeight:FontWeight.bold,fontSize:24),)),
              SizedBox(height: height*.03,),
               GridView.builder(
                    shrinkWrap: true,
                    itemCount: 12,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (context, index) =>  Padding(
                      padding: const EdgeInsets.only(right:8.0,bottom: 0.0,top: 0),
                      child: Column(
                        children: [
                          Container(height: height*0.099,width: width*0.25,decoration: BoxDecoration(color: cBlue2,borderRadius: BorderRadius.circular(15)),child: Image(image: AssetImage(photos[index]),),),
                          SizedBox(height: height*0.0092,),
                          Text(title[index],style: GoogleFonts.nunitoSans(color:Colors.black,fontSize:12,fontWeight:FontWeight.w600),),
                        ],
                      ),
                    ),
                  ),
            ],),
          ),
        ),
      ) ,
      bottomNavigationBar: Material(
        
  elevation: 5, // Adjust the elevation to control the shadow intensity
  borderRadius: const BorderRadius.horizontal(left: Radius.circular(40),right: Radius.circular(40)),
  child: Container(
    width: double.infinity,
    height: 130,
            decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 255, 255, 255), // Shadow color
                spreadRadius: 0, // Spread radius
                blurRadius: 65, // Blur radius
                offset: Offset(0, 30), // Offset in x and y directions
              ),
            ],
          ),
    child: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(radius: 25,backgroundColor: cBlue,child: Icon(Icons.home,color: cWhite,),),
              CircleAvatar(radius: 25,backgroundColor: cWhite,child: Icon(Icons.favorite,color: greyShade400,),),
              CircleAvatar(radius: 25,backgroundColor: cWhite,child: Icon(Icons.menu_book_sharp,color: greyShade400,),),
              CircleAvatar(radius: 25,backgroundColor: cWhite,child: Icon(CupertinoIcons.chat_bubble_text_fill,color: greyShade400,),),
            ],
          ),
        ],
      ),
    ),
  ),),
    );
  }
}