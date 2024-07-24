
import 'package:clean_house/utils/colors.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';


class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key,this.controller,this.validator});
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final height=MediaQuery.of(context).size.height;
    return TextFormField(
     autocorrect: false,
    textCapitalization: TextCapitalization.none,
    controller: controller,
    validator:validator ,
    keyboardType: TextInputType.emailAddress,
    style: const TextStyle(
        color:navyBluee,
        fontFamily: "Inter",
        fontSize: 14,
        fontWeight: FontWeight.bold
      ),
         
    decoration:  InputDecoration(
      filled: true,
      fillColor: greyShade,
      border:  OutlineInputBorder(
      borderSide: BorderSide.none, // Remove border
      borderRadius: BorderRadius.circular(6.0), // Adjust border radius if needed
      ),
      
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
      hintText: "E-mail",
      hintStyle: const TextStyle(
        color:greyShade200,
        fontFamily: "Inter",
        fontSize: 14
      )
    ),
        );
  }
}