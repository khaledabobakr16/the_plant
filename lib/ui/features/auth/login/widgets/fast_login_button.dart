import 'package:flutter/material.dart';
import '../../../../../utils/colors.dart';

// ignore: must_be_immutable
class FastLoginButton extends StatelessWidget {
   FastLoginButton({super.key,this.text,this.onPressed});
   String? text;
   final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    // final width=MediaQuery.of(context).size.width;
    return  Container(
      height: height*0.06,
      decoration: BoxDecoration(
        color: greyShade,
        borderRadius: BorderRadius.circular(6)
      ),
      child: MaterialButton(onPressed: onPressed,
      child: Center(child: Text(text!,style: const TextStyle(color: navyBluee,fontSize: 14,fontFamily: "Inter",fontWeight: FontWeight.w600),))),
    );
  }
}