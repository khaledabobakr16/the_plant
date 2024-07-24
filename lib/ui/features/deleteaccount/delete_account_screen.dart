import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/colors.dart';
import '../../../utils/image_util.dart';
import '../auth/login/login_screen.dart';
import '../auth/widgets/button.dart';
import '../settings/settings_screen.dart';

class AccountDeleteScreen extends StatefulWidget {
  const AccountDeleteScreen({super.key});

  @override
  State<AccountDeleteScreen> createState() => _AccountDeleteScreenState();
}

class _AccountDeleteScreenState extends State<AccountDeleteScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;

  bool _isLoading=false;

  TextEditingController email= TextEditingController();

  Future<void> _deleteAccount(BuildContext context) async {
     if (formKey.currentState!.validate()){
    setState((){
    _isLoading=true;
    });
  try {
    // Check if the user is signed in
    if (_auth.currentUser != null&&_auth.currentUser!.email==email.text) {
      // Delete the user
      await _auth.currentUser!.delete();
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).delete();
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: cBlue,
          duration: Duration(seconds: 3),
          content: Center(
            child: Text("The account has been successfully deleted",
                style: TextStyle(color: Colors.white)),
          ),
        ));
       // ignore: use_build_context_synchronously
       Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
    } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor:  Color.fromARGB(255, 223, 83, 83),
          duration: Duration(seconds: 3),
          content: Center(
            child: Text("Please enter your email",
                style: TextStyle(color: Colors.white)),
          ),
        ));
    setState((){
    _isLoading=false;
    });
    }
    
    // If deletion is successful, navigate to the login screen
   
  } catch (e) {
     // ignore: use_build_context_synchronously
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor:  Color.fromARGB(255, 223, 83, 83),
          duration: Duration(seconds: 3),
          content: Center(
            child: Text("Failed to delete account,Try again!",
                style: TextStyle(color: Colors.white)),
          ),
        ));
     setState((){
    _isLoading=false;
    });
    // You can show an error message or dialog here
  }
 }
}

  @override
  Widget build(BuildContext context) {
   final height=MediaQuery.of(context).size.height;
   // ignore: unused_local_variable
   final width=MediaQuery.of(context).size.width;
    return AbsorbPointer(
      absorbing: _isLoading,
      child: Scaffold(
        backgroundColor: cWhite,
        appBar: AppBar(
          leading: IconButton(icon: const Icon(CupertinoIcons.back,color: cWhite,), onPressed: () { 
            Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                               const SettingsScreen()));
           },),
          backgroundColor:cBlue,
          elevation: 3,
          title: Text('Delete Account',style:GoogleFonts.rubik(color:cWhite,fontSize:18,fontWeight:FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
           key: formKey,   
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*.015,),
                  const Center(child: Icon(Icons.warning_amber,color:Colors.red,size: 100,)),
                  SizedBox(height: height*.03,),
                  Text("Deleting your account will:",style:GoogleFonts.rubik(fontWeight:FontWeight.bold,color:Colors.black),),
                  SizedBox(height: height*.01,),
                  Text("• Delete your account information",style:GoogleFonts.rubik(color:Colors.black)),
                  Text("• Delete your profile photo",style:GoogleFonts.rubik(color:Colors.black)),
                  Text("• Delete your location",style:GoogleFonts.rubik(color:Colors.black)),
                  Text("• Delete your history",style:GoogleFonts.rubik(color:Colors.black)),
              SizedBox(height: height*.03,),
               Text("E-mail :",style: GoogleFonts.openSans(color:cBlack,fontWeight:FontWeight.bold,fontSize:15),),
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
               hintStyle:const TextStyle(
                 color:greyShade200,
                 fontFamily: "Inter",
                 fontSize: 14,
               )
                         ),
                     ),
                SizedBox(height: height*.1,),
                Button(onTap: () { 
                  _deleteAccount(context);
                },
                child: _isLoading==true?const ImageAsset(imagePath: "assets/images/loading.gif",): const Text("Delete My Account",
                style:   TextStyle(
                color: cWhite,fontFamily: "Rubik",fontSize: 18,
                ),)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}