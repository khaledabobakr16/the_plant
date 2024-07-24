import 'package:clean_house/utils/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color backGroundColor;
  final Color textColor;
  final String fontFamily;
  final Widget? child;
  final double fontSize;
  final Function() onTap;
   const Button({super.key,required this.onTap,this.backGroundColor=cBlue,this.textColor=cWhite,this.fontFamily="Rubik",this.fontSize=18,required this.child});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    // final width=MediaQuery.of(context).size.width;
    return  SizedBox(
      height: height*0.055,
      width: double.infinity,
      child: MaterialButton(
      color: backGroundColor,
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),),
        child:child,
   ),
);
  }
}