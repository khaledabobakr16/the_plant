import 'package:clean_house/ui/features/auth/otp/widgets/pinput.dart';
import 'package:clean_house/ui/helper/app_widgets.dart';
import 'package:clean_house/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: cWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height/10,horizontal: width/20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const ShadowButton(),
                SizedBox(height: height*.05,),
                Text("Verify Code",style: GoogleFonts.allerta(color: navyBluee,fontSize: 44,fontWeight:FontWeight.w500)),
                SizedBox(height: height*.03,),
                Text("Check your SMS inbox, we have sent" , style: GoogleFonts.inter(color: navyBluee,fontSize:width*0.05),),
                 RichText(
                text: TextSpan(
                text: "you the code at ",
                style:  GoogleFonts.inter(color: navyBluee,fontSize: width * 0.05,), // Default style
                children: [
                TextSpan(
                  text: "+974 6621 9400",
                  style: GoogleFonts.inter(
                  color: navyBluee, // Navy blue color
                  fontSize: width * 0.05,
                  fontWeight:FontWeight.bold
              ),
            ),
          ],
        ),
            ),
                SizedBox(height: height*.03,),
                const Center(child:  PinPutBottomCursor()),
                SizedBox(height: height*.03,),
                 Row(children: [
                  Text("Didn’t receive a code? ",style: GoogleFonts.inter(
                    fontSize:width*.03
                  ),),
                   TextWithLine(text: "Resend Code",color: cBlue,fontSize:width*.03,fontWeight:FontWeight.bold)
                ],)
            ],),
          ),
        ),
      ),
    );
  }
}