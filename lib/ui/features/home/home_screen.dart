
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/local/constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/image_util.dart';
import '../categories/categories_screen.dart';
List<String> photos=[
  "assets/images/cleaning.png",
  "assets/images/maid.png",
  "assets/images/nurse.png",
  "assets/images/design_2.png",
  "assets/images/man-salon.png",
  "assets/images/washer.png",
];
List<String> title=[
  "Cleaning",
  "Maid",
  "Nurse",
  "Laundry",
  "Man Salon",
  "Car Wash"
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    int currentIndex=0;
  Container buildDot(int index) {
    return Container(
        height: height*.008,
        width: currentIndex == index ? width*.055 : height*.008,
        margin:  EdgeInsets.only(right: width*0.015),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: currentIndex == index ?cBlue:cgrey,
        ),
      );
    }
    return Scaffold(
      backgroundColor: cWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  //  ShadowButton(color: cBlue,icon: Icons.window,),
                  //  ShadowButton(color: cBlue,icon: Icons.notifications,),
                ],),
                SizedBox(height: height*.03,),
                Text("Hi Ali, Which Service",style: GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.bold,fontSize:20),),
                Text("Do you Need ?",style: GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.bold,fontSize:20),),
                SizedBox(height: height*.01,),
                Container(
                  height: height*0.23,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: cBlue,
                    borderRadius: BorderRadius.circular(14.5)
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("Get 30% Off",style: GoogleFonts.poppins(color:cWhite,fontWeight:FontWeight.w900,fontSize:24),),
                          Text("Get discount for every",style: GoogleFonts.poppins(color:cWhite,fontWeight:FontWeight.bold,fontSize:12),),
                          Text("order  only valid for today",style: GoogleFonts.poppins(color:cWhite,fontWeight:FontWeight.bold,fontSize:12),),
                        ],),
                      ),
                      const ImageAsset(imagePath: AssetConstants.design,),
                    ],
                  ),
                ),
                SizedBox(height: height*.01,),
                SizedBox(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3,
                                (index) => buildDot(index))),
                      ),
                SizedBox(height: height*.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("Categories",style: GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.w700,fontSize:18),),
                  InkWell(onTap:() {Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoriesScreen()));},child: Text("See all >",style: GoogleFonts.poppins(color:cBlack,fontWeight:FontWeight.bold,fontSize:12),)),
                ],),
                SizedBox(height: height*.02,),
                SizedBox(
                  height: height*0.3,
                  width: double.infinity,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
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
                ),
                SizedBox(height: height*.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("Popular House Maid",style: GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.w700,fontSize:18),),
                  Text("See all >",style: GoogleFonts.poppins(color:cBlack,fontWeight:FontWeight.bold,fontSize:12),),
                ],),
                SizedBox(height: height*.02,),
                // Card(color: cBlack,elevation: 5,child: Container(height: 15,width: 15,),)
                Stack(
                  children: [
                    Container(
                      height: height * 0.15,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3), // Adjust the opacity and color as needed
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        color:cWhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                    
                          children: [
                            const Image(image: AssetImage("assets/images/design_2.png"),fit: BoxFit.cover,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text("Shruti Kedia",style: GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.w700,fontSize:18),),
                              SizedBox(height: height*.01,),
                              Text("Hi my name is Kedia and I m House maid",style: GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold,fontSize:width*0.025),),
                              SizedBox(
                                height: 20,
                                width: 150,
                                child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: 5,itemBuilder: (context, index) => Icon(Icons.star,color: index==4?greyShade300:cYellow,size: width*0.035,),))
                            ],),
                            
                          ],
                        ),
                      ), // Add your child widget here
                    ),
                    Positioned(top:0,right: 0,child: IconButton(onPressed: (){}, icon:const Icon(Icons.favorite,color: Colors.red,) ))
                  ],
                ),
                SizedBox(height: height*.01,),
                SizedBox(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5,
                                (index) => buildDot(index))),
                      ),
                SizedBox(height: height*.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("Top 4 Laundry in Al Khor",style: GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.w700,fontSize:18),),
                  Text("See all >",style: GoogleFonts.poppins(color:cBlack,fontWeight:FontWeight.bold,fontSize:12),),
                
                ],),
                SizedBox(height: height*.01,),
                                SizedBox(height: height*.02,),
                SizedBox(
                  height: height*0.44,
                  width: double.infinity,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (context, index) =>  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Stack(
                        children: [
                          Container(height: height*0.7,width: width*0.55,decoration: BoxDecoration(color: cBlue2,borderRadius: BorderRadius.circular(15)),child: const Image(image: AssetImage("assets/images/design-2.png"),fit: BoxFit.fill,),),
                        Positioned(
  left: 30,
  bottom: 0,
  child: ElevatedButton(
    onPressed: () {},
    style: ButtonStyle(
      // ignore: deprecated_member_use
      backgroundColor: MaterialStateProperty.all<Color>(navyBluee2), // Change the background color here
      // ignore: deprecated_member_use
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Edit the border radius here
        ),
      ),
    ),
    child: Text(
      "Book",
      style: GoogleFonts.poppins(color: Colors.white),
    ),
  ),
)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Material(
        
  elevation: 5, // Adjust the elevation to control the shadow intensity
  // ignore: prefer_const_constructors
  borderRadius: BorderRadius.horizontal(left: Radius.circular(40),right: Radius.circular(40)),
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
        mainAxisAlignment: MainAxisAlignment.start,
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
  ),)
    );
  }

}