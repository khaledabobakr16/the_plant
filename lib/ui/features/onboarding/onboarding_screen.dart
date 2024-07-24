


import 'package:flutter/material.dart';
import '../../../data/local/onboarding_contents.dart';
import '../../../generated/l10n.dart';
import '../../../utils/colors.dart';
import '../../../utils/image_util.dart';
import '../auth/login/login_screen.dart';
import 'onboarding_provider.dart';
import 'package:provider/provider.dart';


class OnBoardingScreen extends StatelessWidget {
const OnBoardingScreen({super.key});

@override
Widget build(BuildContext context) {
  final height=MediaQuery.of(context).size.height;
  final width=MediaQuery.of(context).size.width;
  Container buildDot(int index) {
    return Container(
        height: height*.008,
        width:context.watch<OnboardingProvider>().currentIndex == index ? width*.055 : height*.008,
        margin:  EdgeInsets.only(right: width*0.015),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: context.watch<OnboardingProvider>().currentIndex == index ?cBlue:cgrey,
        ),
      );
    }
return Scaffold(
      backgroundColor: cWhite,
      body:PageView.builder(
        controller: context.read<OnboardingProvider>().controller,
        onPageChanged: (int index) {
          context.read<OnboardingProvider>().changeIndex(index);
        },
        itemCount: onboardingcontents.length,
        itemBuilder: (_, i) {
          return Column(
            children: [
              ImageAsset(imagePath: onboardingcontents[i].image!,),
              SizedBox(height: height*0.025,),
              Text(onboardingcontents[i].title!,
                  style: const TextStyle(
                      color: cBlue,
                      fontSize: 32,
                      fontFamily: "Poly"
                      ),
                      ),
              SizedBox(height: height*0.040,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SizedBox(
                  child: Text(onboardingcontents[i].discription!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: cBlack,
                          fontSize: 16,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold
                        ),),
                ),
              ),
          const Spacer(),
          SizedBox(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(onboardingcontents.length,
              (index) => buildDot(index))),
                ),
          SizedBox(height: height*0.010,),
        Container(
      height: height*0.070,
      width: double.infinity,
      margin:  EdgeInsets.only(left: width*.090,right: width*.090,top: height*.05),
      child: MaterialButton(
      color: cBlue,
        onPressed: () {
          if (context.read<OnboardingProvider>().currentIndex ==
              onboardingcontents.length - 1) {
           Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const LoginScreen()));
          }
              
          context.read<OnboardingProvider>().controller.nextPage(
              duration: const Duration(milliseconds: 90),
              curve: Curves.bounceIn);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text( context.watch<OnboardingProvider>().currentIndex<1?S.of(context).getstarted:S.of(context).next,
          style: const TextStyle(
              color: cWhite,fontFamily: "Rubik",fontSize: 18,fontWeight: FontWeight.bold,
              ),
        ),
      ),
                ),
                
      TextButton(onPressed: (){
      Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const LoginScreen()));
                }, child: Text( S.of(context).skip,
          style: const TextStyle(
              color: cBlack, fontWeight: FontWeight.bold,fontFamily: "Rubik",fontSize: 14
              ),
        ),),
        SizedBox(height: height*0.02)
            ],
          );
        },
      ),
    );
  }
}
