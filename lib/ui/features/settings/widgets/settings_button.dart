
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/colors.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key,this.text,this.onPressed});
  final String? text;
  final Function()?onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0),), backgroundColor: greyShade100,),
              onPressed: onPressed, child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ Text(text!,style: GoogleFonts.inter(color:Colors.black45,fontWeight:FontWeight.bold,fontSize:16),),const Icon(Icons.arrow_forward_ios_rounded,size: 18,color:Colors.black45),
          ],),
  ));
  }
}