// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/colors.dart';

class FnameAndImgLoading extends StatelessWidget {
  const FnameAndImgLoading({super.key});

  @override
  Widget build(BuildContext context) {
      final height=MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    final width=MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
        baseColor: cBlue,
       highlightColor: cBlue2,
      child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height*0.02,),
                   Center(child: CircleAvatar(
                    backgroundColor: Colors.grey.shade100,
                    backgroundImage:const NetworkImage("",),
                    radius: 35,
                  )),
                  SizedBox(height: height*0.02,),
                  Text("",style: GoogleFonts.rubik(color:cWhite),),
                ],
       ),
    );
  }
}