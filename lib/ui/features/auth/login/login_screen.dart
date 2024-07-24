// ignore_for_file: unused_local_variable

import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart'; // Import the Cupertino icons
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/image_util.dart';
import '../../../helper/app_widgets.dart';
import '../../home/weather_screen.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../register/register_screen.dart';
import '../widgets/button.dart';
import '../widgets/email_textfield.dart';
import '../widgets/or_line.dart';
import '../widgets/password_textfield.dart';
import 'widgets/fast_login_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisibilty=true;
   FirebaseAuth auth = FirebaseAuth.instance;
   bool? isLoading;
   GlobalKey<FormState> formKey = GlobalKey<FormState>();

   @override
  void initState() {

    super.initState();
     isLoading=false;
  }
  final TextEditingController email = TextEditingController();
  final TextEditingController password= TextEditingController();
   
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;

    return  Scaffold(
      body: Stack(
        children: [
          const ImageAsset(imagePath: "assets/images/bubble-2.png",),
          const Positioned(right: 0,child: ImageAsset(imagePath: "assets/images/bubble-1.png",)),
          const Positioned(bottom:0,right: 0,child: ImageAsset(imagePath: "assets/images/bubble-3.png",)),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height/5,horizontal: width/20),
                child: AbsorbPointer(
                  absorbing: isLoading!,
                  child: AbsorbPointer(
                    absorbing: isLoading!,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        // const Center(child:  Text("C-P-F",style: TextStyle(color: cBlue,fontSize: 64,fontFamily: "AlexBrush"),)),
                        // SizedBox(height: height*.03,),
                        const Text("Log In",style: TextStyle(color: navyBluee,fontSize: 44,fontFamily: "Allerta",fontWeight: FontWeight.w500),),
                        SizedBox(height: height*.03,),
                        Row(children: [
                          Expanded(child: FastLoginButton(text: "GOOGLE",onPressed: logInWithGoogle,)),
                          SizedBox(width: width*.02,),
                          Expanded(child: FastLoginButton(text: "Apple ID",onPressed: ()async{
                             setState(() async{
                      // await GoogleSignIn().currentUser!.clearAuthCache();
                      //       await GoogleSignIn().signOut();
                      //       await GoogleSignIn().disconnect();
                      //       await FirebaseAuth.instance.signOut();
                    });
                          },)),
                        ],),
                        SizedBox(height: height*.03,),
                        const OrLine(),
                        SizedBox(height: height*.03,),
                        EmailTextField(
                          controller:email,validator: (value){
                          if(value!.isEmpty)
                          {
                            return 'Please enter your email';
                          }
                          return null;
                        },),
                        SizedBox(height: height*.01,),
                        PasswordTextField(
                          obscureText:isVisibilty ,
                          obscureIcon: isVisibilty==false?Icons.visibility_off:Icons.visibility_outlined,
                          onPressed: () {
                            setState(() {
                              if(isVisibilty==true)
                              {
                                isVisibilty=false;
                              }
                              else
                              {
                                isVisibilty=true;
                              }
                            });
                          }, 
                          // ignore: body_might_complete_normally_nullable
                          controller: password,validator: (value){
                          if(value!.isEmpty)
                          {
                            return "Please enter your password";
                          }
                        },),
                        // SizedBox(height: height*.0,)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          TextButton(onPressed: (){
                            Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ForgotPasswordScreen()));
                          }, child: const TextWithLine(text: "Forgot Password?",color:cBlue,))
                        ],),
                        SizedBox(height: height*.01,),
                        Button(child: isLoading==true?const ImageAsset(imagePath: "assets/images/loading.gif",): const Text("Login",
                          style:   TextStyle(
                          color: cWhite,fontFamily: "Rubik",fontSize: 18,
                        ),),
                         onTap: (){
                          login(email.text,password.text);
                         },),
                        SizedBox(height: height*.01,),
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegisterScreen()));
                        }, child: const Text("Don’t have an account?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Inter",fontSize: 14),)),
                        TextButton(
                          onPressed: (){
                             Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegisterScreen()));
                          },
                          child: const Row(children:  [
                             Text("REGISTER ",style: TextStyle(color: cBlue,fontWeight: FontWeight.bold,fontFamily: "Inter",fontSize: 14,letterSpacing: 2.55),),
                             Icon(CupertinoIcons.arrow_right,size: 18,color: cBlue,)
                          ],),
                        ),
                      height>=844?SizedBox(height: height/13,):SizedBox(height: height/50,)
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
void login(String email,String password) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading=true;
      });
      try {
        // ignore: duplicate_ignore
        // ignore: unused_local_variable
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pushAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
            (route) => false);
                  setState(() {
        isLoading=false;
      });
      } catch (e) {
        log(e.toString());
        setState(() {
        isLoading=false;
          });
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 223, 83, 83),
          duration: Duration(milliseconds: 800),
          content: Center(
            child: Text("Email or Password is incorrect",
                style: TextStyle(color: Colors.white)),
          ),
        ));
      }
    }
  }
Future<void> logInWithGoogle() async {

  try{
 // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
        final UserCredential authResult =
          await auth.signInWithCredential(credential);
   CollectionReference users = FirebaseFirestore.instance.collection('users');
  if(authResult.additionalUserInfo!.isNewUser)
  {
     // ignore: await_only_futures
     FirebaseFirestore users= await FirebaseFirestore.instance;
     users.collection('users').doc(authResult.user!.uid)
     .set({
               'email': googleUser!.email, // John Doe
               'fullname': googleUser.displayName, // Stokes and Sons
               'id': authResult.user!.uid,
               'image':(authResult.additionalUserInfo!.profile!['picture']),
               'password':"",
             });
          log(users.databaseId);
          log("this user Not registered before and now registered for it");
  }
  else{
    log("this user is found");
  }
  log("scusses");
 }catch(e)
 {
  log(e.toString());
 }
 

}

}