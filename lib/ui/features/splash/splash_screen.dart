

// ignore_for_file: unused_local_variable


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/image_util.dart';
import '../auth/login/login_screen.dart';
import '../home/weather_screen.dart';
import '../onboarding/onboarding_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    handlrData(context);
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
        return  Scaffold(
        backgroundColor: cBlue,
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                SizedBox(height:height /3,),
                Center(child: ImageAsset(imagePath: "assets/images/logo.png",height: height*.15,)),
                Center(child: Text("The Plant",style: GoogleFonts.rubik(color:cWhite,fontSize:22,fontWeight:FontWeight.bold),)),
               ],
              ),
          );
     
    
  }

Future<void> handlrData(context) async {
    await Future.delayed(const Duration(seconds: 5));
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => initScreen == 0 || initScreen == null
//                 ? const OnBoardingScreen()
//                 : const LoginScreen())
// );
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) =>  FutureBuilder(
//                   future: FirebaseAuth.instance.authStateChanges().first,
//                    builder: (context, AsyncSnapshot<User?> snapshot)
//       {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//         return  const CircularProgressIndicator(backgroundColor: cBlue,);
//         }else
//         {
//            if (snapshot.hasData && snapshot.data != null) {
//             // User is already logged in, navigate to home screen.
//             return const Home();
//         }
//         else{
//            return const LoginScreen();
//         }
//       }
//       }

//     ))
// );
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => initScreen == 0 || initScreen == null
                ? const OnBoardingScreen()
                : FutureBuilder(
                  future: FirebaseAuth.instance.authStateChanges().first,
                   builder: (context, AsyncSnapshot<User?> snapshot)
      {
        if (snapshot.connectionState == ConnectionState.waiting) {
        return  const CircularProgressIndicator(backgroundColor: cBlue,);
        }else
        {
           if (snapshot.hasData && snapshot.data != null) {
            // User is already logged in, navigate to home screen.
            return const Home();
        }
        else{
           return const LoginScreen();
        }
      }
      }

    ))
);
  }
}

class LanguageOnboardingScreen {
  const LanguageOnboardingScreen();
}
