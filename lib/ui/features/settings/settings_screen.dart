// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/colors.dart';
import '../../../utils/image_util.dart';
import '../../helper/app_widgets.dart';
import '../deleteaccount/delete_account_screen.dart';
import '../home/weather_screen.dart';
import 'widgets/settings_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return  Scaffold(
      body: Stack(
        children: [
           const Positioned(left: 0,child:  ImageAsset(imagePath: "assets/images/predict-bubble-2.png",)),
           const Positioned(left: 0,child: ImageAsset(imagePath: "assets/images/predict-bubble-1.png",)),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShadowButton(color: cBlue,icon: Icons.arrow_back_ios_new, onTap: () { 
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>const Home()),);
                     },),
                      Center(child: Text("Settings",style: GoogleFonts.openSans(color:Colors.black,fontSize:24),)),
                      SizedBox(height: height*.2,),
                      Text("Account",style: GoogleFonts.rubik(color:cBlack,fontSize:17),),
                      SettingsButton(onPressed: () {
                      Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                                const AccountDeleteScreen()));
                      },text: "Delete my Account",),
                      
                      SizedBox(height: height*.03,),
                      
                      Text("Terms and Privacy Policy",style: GoogleFonts.rubik(color:cBlack,fontSize:17),),
                      const SettingsButton(text: "Privacy Policy",),
                      SizedBox(height: height*.01,),
                      const SettingsButton(text: "Terms of Use",),
                      
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
        bottomNavigationBar: BottomAppBar(
          
          color: Colors.white,
          shadowColor:  Colors.white,
          surfaceTintColor:  Colors.white,
          elevation: 0,
          child: Container(
            color:Colors.white ,
            child: Center(
              child: Column(
                children: [
                  Text(
                    'The Plant',
                    style: GoogleFonts.rubik( color: cBlue,fontSize:15),
                  ),
                  Text(
                    'Version 1.0.0',
                    style: GoogleFonts.rubik( color: cBlue,fontSize:15),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}