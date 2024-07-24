// ignore_for_file: unnecessary_import


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/colors.dart';
import '../../../helper/app_widgets.dart';
import 'formfield_edit.dart';
import 'image_profile.dart';

class LoadingProfile extends StatefulWidget {
  const LoadingProfile({super.key});

  @override
  State<LoadingProfile> createState() => _LoadingProfileState();
}

class _LoadingProfileState extends State<LoadingProfile> {
  @override
  Widget build(BuildContext context) {
  final height=MediaQuery.of(context).size.height;
   // ignore: unused_local_variable
   final width=MediaQuery.of(context).size.width;
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShadowButton(color: cBlue,icon: Icons.arrow_back_ios_new, onTap: () { 
                      
                     },),
                      Center(child: Text("Edit profile",style: GoogleFonts.openSans(color:Colors.black,fontSize:24),)),
                     SizedBox(height: height*.1,),
                     Center(child:   Shimmer.fromColors(
                     baseColor: cWhite,
                     highlightColor: cBlue2,child: const ImageProfile(image: "", radiusImage:60,))),
                     SizedBox(height: height*.1,),
                     Text("Full Name :",style: GoogleFonts.openSans(color:cBlack,fontWeight:FontWeight.bold,fontSize:15),),
                     Shimmer.fromColors( 
                     baseColor: cWhite,
                     highlightColor: cBlue2,child: FormFieldEditInfo(initialValue:"" ,hintText: "",)),
                   
                     SizedBox(height: height*.01,),
                     Text("E-mail :",style: GoogleFonts.openSans(color:cBlack,fontWeight:FontWeight.bold,fontSize:15),),
                    Shimmer.fromColors(
                     baseColor: cWhite,
                     highlightColor: cBlue2,child: FormFieldEditInfo(initialValue:"" ,hintText: "",)),
                    SizedBox(height: height*.01,),
                    Text("Password :",style: GoogleFonts.openSans(color:cBlack,fontWeight:FontWeight.bold,fontSize:15),),
                    Shimmer.fromColors( 
                     baseColor: cWhite,
                     highlightColor: cBlue2,child: FormFieldEditInfo(initialValue:"" ,hintText: "",)),
                     SizedBox(height: height*.1,),
                    MaterialButton(
                    height: 50,
                    minWidth: double.infinity,
                    color: cBlue,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: (){},
                    child: Text("Save Changes",style: GoogleFonts.inter(color:cWhite,fontWeight:FontWeight.bold),),
                  ),
                  ],
                );
  }
}