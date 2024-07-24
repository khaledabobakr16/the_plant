// ignore_for_file: unnecessary_import, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/image_util.dart';
import '../../../helper/app_widgets.dart';
import '../login/login_screen.dart';
import '../widgets/button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool? isLoading;
  TextEditingController email=TextEditingController();
 
  void resetPassword(String email) async {
    if (formKey.currentState!.validate()){
    setState((){
      isLoading=true;
    });
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
      // Email is registered, send password reset email
      await _auth.sendPasswordResetEmail(email: email);
      log("Password reset email sent to $email");
       ScaffoldMessenger.of(context).showSnackBar(  SnackBar(
          backgroundColor:cBlue,
          duration:const   Duration(milliseconds: 800),
          content:  Center(
            child: Text("Password reset email sent to $email",
            style: const TextStyle(color: Colors.white)),
          ),
        ));
  } catch (e) {
    // An error occurred while sending password reset email
     ScaffoldMessenger.of(context).showSnackBar(  const SnackBar(
          backgroundColor:  Color.fromARGB(255, 223, 83, 83),
          duration: Duration(milliseconds: 800),
          content: Center(
            child: Text("An error occurred while sending password reset email",
            style: TextStyle(color: Colors.white)),
          ),
          
        ));
  }
  setState(() {
    isLoading=false;
  });
  }
}
 @override
  void initState() {
 
    super.initState();
    isLoading=false;
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          const ImageAsset(imagePath: "assets/images/bubble-2.png",),
          const Positioned(right: 0,child: ImageAsset(imagePath: "assets/images/bubble-1.png",)),
          // const Positioned(bottom:0,right: 0,child: ImageAsset(imagePath: "assets/images/bubble-3.png",)),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height/13,horizontal: width/20),
                child: AbsorbPointer(
                  absorbing: isLoading!,
                  child: AbsorbPointer(
                    absorbing: isLoading!,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                    ShadowButton(onTap: () { 
                                 Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()));
                         },),
            SizedBox(height: height*.090,),
            const Text("Reset Password",style: TextStyle(color: navyBluee,fontSize: 30,fontFamily: "Allerta",fontWeight: FontWeight.w500),),
            SizedBox(height: height*.06,),
            Text("Please enter your email address.You will receive a link to create a new password via email.",style: GoogleFonts.inter(color:cBlack,fontWeight:FontWeight.bold,fontSize:16),),
             SizedBox(height: height*.02,),
            TextFormField(
              
              controller: email,
            style: const TextStyle(
                color:cBlack,
                fontFamily: "Inter",
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),  
              validator: (value){
            if (value!.isEmpty) {
             return 'Please enter an email';
             }
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) {
            return 'Please enter a valid email example@example.com';
              }
               return null;
            },
            decoration:  InputDecoration(
              filled: true,
      fillColor: greyShade,
      border:  OutlineInputBorder(
      borderSide: BorderSide.none, // Remove border
      borderRadius: BorderRadius.circular(6.0), // Adjust border radius if needed
      ),

              hintText: "Email",
              hintStyle:  const TextStyle(
                color:greyShade200,
                fontFamily: "Inter",
                fontSize: 14,
              )
            ),
                    ),
              SizedBox(height: height*.04,),
                      Button(
                      onTap:(){
                          resetPassword(email.text);
                      },
                      child:isLoading==true?const ImageAsset(imagePath: "assets/images/loading.gif",): Text("Reset password",style: GoogleFonts.inter(color:cWhite,fontWeight:FontWeight.bold),),
                      ),
                      ],),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}