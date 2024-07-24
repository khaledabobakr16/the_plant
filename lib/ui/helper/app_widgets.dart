
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class TextWithLine extends StatelessWidget {
  final String text;
  final Color color;
  final double lineWidth;
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;
  const TextWithLine({super.key, required this.text,this.color=Colors.black,this.lineWidth=1.0,this.fontSize=12,this.fontFamily="Inter",this.fontWeight=FontWeight.normal}) ;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration:  BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: color, // You can set any color here
            width:lineWidth, // Customize the width of the line
          ),
        ),
      ),
      child: Text(
        text,
        style:  TextStyle(
          fontSize: fontSize, // Customize the font size
          fontFamily: fontFamily,
          color: color,
          fontWeight:fontWeight,
        ),
      ),
    );
  }
}

class ShadowButton extends StatelessWidget {
  const ShadowButton({super.key,this.icon=Icons.arrow_back,this.color=Colors.black,required this.onTap});
  final IconData icon;
  final Color color;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFF6F889D), // Shadow color
                spreadRadius: 0, // Spread radius
                blurRadius: 65, // Blur radius
                offset: Offset(0, 30), // Offset in x and y directions
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: cWhite, // Button color
              padding: const EdgeInsets.all(15), // Padding around the button content
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Border radius
              ),
            // Shape of the button
            ),
            onPressed: onTap,
            child: Icon(
              icon,
              color: color, 
              size: 22,// Icon color
               // Size of the icon
            ),
          ),
   );
  }
}