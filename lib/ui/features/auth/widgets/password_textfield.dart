import 'package:clean_house/utils/colors.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key,this.text="Password",this.controller,this.validator,this.obscureText=true,this.obscureIcon=Icons.visibility_off,this.onPressed});
  final String text;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final IconData? obscureIcon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      obscureText: obscureText!,
      style: const TextStyle(
       color:navyBluee,
       fontFamily: "Inter",
       fontSize: 14,
       fontWeight: FontWeight.bold
    ),
      decoration: InputDecoration(
       filled: true,
       fillColor: greyShade,
       border:  OutlineInputBorder(
       borderSide: BorderSide.none, // Remove border
       borderRadius: BorderRadius.circular(6.0), // Adjust border radius if needed
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
        hintText: text,
        suffixIcon: IconButton(onPressed: onPressed,icon: Icon(obscureIcon,size: 21,color:greyShade200 ,)),
        hintStyle: const TextStyle(
              color:greyShade200,
              fontFamily: "Inter",
              fontSize: 14
        ),
      ),
    );
  }
}