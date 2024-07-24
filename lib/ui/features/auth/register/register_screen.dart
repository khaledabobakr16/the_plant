// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:clean_house/ui/features/auth/login/login_screen.dart';
import 'package:clean_house/ui/features/auth/login/widgets/fast_login_button.dart';
import 'package:clean_house/ui/features/auth/register/widgets/text.dart';
import 'package:clean_house/ui/features/auth/widgets/button.dart';
import 'package:clean_house/ui/features/auth/widgets/or_line.dart';
import 'package:clean_house/ui/features/auth/widgets/password_textfield.dart';
import 'package:clean_house/ui/features/auth/widgets/email_textfield.dart';
import 'package:clean_house/ui/helper/app_widgets.dart';
import 'package:clean_house/utils/colors.dart';
import 'package:clean_house/utils/image_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/weather_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   FirebaseAuth auth = FirebaseAuth.instance;
   GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final TextEditingController fullName = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController password= TextEditingController();
    final TextEditingController confirmPassword= TextEditingController();
   bool? isLoading;
   bool? checkAgree=false;
   bool isVisibiltyPassword=true;
   bool isVisibiltyConfirmPassword=true;
   @override
  void initState() {
    super.initState();
    isLoading=false;
    checkAgree=false;
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;

    return  Scaffold(
      backgroundColor: cWhite,
      body: Stack(
        children: [
           const Positioned(right: 0,child:  ImageAsset(imagePath: "assets/images/bubble-4.png",)),
              const Positioned(right: 0,child: ImageAsset(imagePath: "assets/images/bubble-5.png",)),
              const Positioned(bottom:0,right: 0,child: ImageAsset(imagePath: "assets/images/bubble-3.png",)),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
              padding: EdgeInsets.symmetric(vertical: height/13,horizontal: width/20),
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
                       SizedBox(height: height*.08,),
                      Text("Register",style: GoogleFonts.allerta(color: navyBluee,fontSize: 44,fontWeight:FontWeight.w500)),
                      SizedBox(height: height*.03,),
                      Row(children: [
                          Expanded(child: FastLoginButton(text: "GOOGLE",onPressed:signUpWithGoogle,)),
                          SizedBox(width: width*.02,),
                          Expanded(child: FastLoginButton(text: "Apple ID",)),
                        ],),
                        SizedBox(height: height*.03,),
                        const OrLine(),
                         SizedBox(height: height*.03,),
                        TextFormField(
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        controller: fullName,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please enter your full name';
                          }
                          // Regular expression to check if the input contains any numbers
                          final nameRegex = RegExp(r'[0-9]');
                          if (nameRegex.hasMatch(value)) {
                           return 'Full name cannot contain numbers';
                          }
                          return null;
                        },
                        style: const TextStyle(
                        color:navyBluee,
                        fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                            ),
                            decoration:  InputDecoration(
                            filled: true,
                            fillColor: greyShade,
                            border:  OutlineInputBorder(
                            borderSide: BorderSide.none, // Remove border
                            borderRadius: BorderRadius.circular(6.0), // Adjust border radius if needed
                            ),
                            // ignore: prefer_const_constructors
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
                            hintText: "Full Name",
                            hintStyle:  const TextStyle(
                            color:greyShade200,
                            fontFamily: "Inter",
                            fontSize: 14),),),
                        SizedBox(height: height*.01,),
                         EmailTextField(controller:email,validator: (value){
                         if (value!.isEmpty) {
                          return 'Please enter an email';
                        }
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email example@example.com';
                        }
                         return null;
                        },),
                        SizedBox(height: height*.01,),
                        PasswordTextField(
                          obscureText: isVisibiltyPassword,
                          obscureIcon:isVisibiltyPassword==false?Icons.visibility_off:Icons.visibility_outlined,
                          onPressed: (){
                          setState(() {
                              isVisibiltyPassword==true?isVisibiltyPassword=false:isVisibiltyPassword=true;
                          });
                          },
                          controller: password,
                          validator:(value){
                          
                          if(value!.isEmpty)
                          {
                            return "Please enter your password";
                          }
                          if (value.length < 6) {
                             return 'Your password needs to be at least 6 characters';
                          }
                        // Password validation for strong password
                         final passwordRegex = RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
                         if (!passwordRegex.hasMatch(value)) {
                              return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
                          }
                         return null;
                        } ,),
                        SizedBox(height: height*.01,),
                        PasswordTextField(
                           obscureText: isVisibiltyConfirmPassword,
                          obscureIcon:isVisibiltyConfirmPassword==false?Icons.visibility_off:Icons.visibility_outlined,
                          onPressed: (){
                            setState(() {
                              
                              isVisibiltyConfirmPassword==true?isVisibiltyConfirmPassword=false:isVisibiltyConfirmPassword=true;
                            });
                          },
                          text: "Confirm Password",controller: confirmPassword,validator: (value){
                          
                          if(value!.isEmpty)
                          {
                            return "Please confirm your password";
                          }
                          
                          if(value!=password.text)
                          {
                            return "Passwords do not match";
                          }
                          return null;
                        },),
                        Row(
                                  children: [
                                    Checkbox(
                                        value:checkAgree,
                                        
                                        activeColor:
                                            cBlue,
                                            
                                        onChanged: (value) {
                                        setState(() {
                                        checkAgree=value;
                                        });
                                        }),
                                    const Txt(text: "I’ve read and agree to the",),
                                    const Txt(text: " terms",color: cBlue,fontWeight: FontWeight.bold,),
                                    const Txt(text: " of",),
                                    const Txt(text: " privacy policy",color:cBlue,fontWeight:FontWeight.bold)
                                  ],
                                ),
                                SizedBox(height: height*.03,),
                                Button(onTap: () { 
                                  signUp(email: email.text, password: password.text, fullname: fullName.text);
                                 },
                                child: isLoading==true?const ImageAsset(imagePath: "assets/images/loading.gif",): const Text("Register",
                                  style:   TextStyle(
                                  color: cWhite,fontFamily: "Rubik",fontSize: 18,
                                ),)),
                              
                        height>=740?SizedBox(height: height/8,):SizedBox(height: height/50,)
                      ],
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

void signUp({required String email, required String password,required String fullname }) async {
    if (formKey.currentState!.validate()) {
       setState(() {
        isLoading=true;
      });
      if(checkAgree==true)
      {
      try {
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
     // ignore: await_only_futures
     FirebaseFirestore users= await FirebaseFirestore.instance;
     users.collection('users').doc(userCredential.user!.uid)
     .set({
               'email': email, // John Doe
               'fullname': fullname, // Stokes and Sons
               'id': userCredential.user!.uid,
               'image':"https://firebasestorage.googleapis.com/v0/b/graduation-project-560f4.appspot.com/o/Person.jpg?alt=media&token=b04f01b0-b5f2-4fe5-9f14-9edf2297c9fd",
               'password':password,
             });
         
            Navigator.pushAndRemoveUntil(
          
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
            (route) => false);
        // If sign up is successful, you can navigate to another screen
        // or do other actions like showing a success message.
        // For example:
        // Navigator.pushReplacementNamed(context, '/home');
    
      } catch (e) {
        log(e.toString());
    
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          backgroundColor: const Color.fromARGB(255, 223, 83, 83),
          duration: const Duration(milliseconds: 800),
          content: Center(
            child: Text(e.toString(),
                style: const TextStyle(color: Colors.white)),
          ),
        ));
         setState(() {
        isLoading=false;
          });
      }
    }else
    {
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
          backgroundColor: Color.fromARGB(255, 223, 83, 83),
          duration:  Duration(milliseconds: 800),
          content:  Center(
            child: Text("You must agree to the terms of privacy policy",
                style: TextStyle(color: Colors.white)),
          ),
          
        ));
         setState(() {
        isLoading=false;
          });
    }
    }
  }
   Future<void> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =await auth.signInWithCredential(credential);


  if(authResult.additionalUserInfo!.isNewUser){
         // ignore: unused_local_variable
         final User? user = authResult.user;
         // ignore: await_only_futures
         FirebaseFirestore users= await FirebaseFirestore.instance;
         await users.collection('users').doc(authResult.user!.uid)
         .set({
               'email': googleUser.email, // John Doe
               'fullname': googleUser.displayName, // Stokes and Sons
               'id': authResult.user!.uid,
               'image':(authResult.additionalUserInfo!.profile!['picture']),
               'password':"",
          });
      log(authResult.additionalUserInfo!.isNewUser.toString());   
      log("This User is New user");
      log("scucsessfull");
       Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Home()));
      }else{
        //        log("This User is not New User");
        // await GoogleSignIn().currentUser?.clearAuthCache();
        // await GoogleSignIn().signOut();
        // // await GoogleSignIn().disconnect();
        // await FirebaseAuth.instance.signOut();
 
      }    
     
    } catch (error) {
      log(error.toString());
    }
  }
}
