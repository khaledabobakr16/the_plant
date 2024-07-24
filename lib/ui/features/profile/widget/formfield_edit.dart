// ignore_for_file: must_be_immutable

// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class FormFieldEditInfo extends StatelessWidget {
   FormFieldEditInfo(
    {
      super.key,
      this.suffixIcon,
      this.obscureIcon,
      this.hintText,
      this.obscure=false,
      this.enabled=false,
      this.initialValue,
      this.onpressed,
      this.onpressedObscure,
      this.colorIcon,
      this.validator,
      this.onChanged,
    });
   final IconData? suffixIcon;
   final IconData? obscureIcon;
   final String? hintText;
   final  String? initialValue;
   final bool? obscure;
   final bool? enabled;
   void Function()? onpressed;
   void Function()? onpressedObscure;
   final Color? colorIcon;
  String? Function(String?)? validator;
   final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    // final height=MediaQuery.of(context).size.height;
    return Container(
      // height: height*.055,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: greyShade,
      ),
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Row(children: [
              
              Expanded(
                child: TextFormField(
                  validator:validator ,
                onChanged: onChanged!,
                // controller: controller!,
                initialValue: initialValue,
                enabled: enabled!,
                obscureText: obscure!,
                style:  const TextStyle(
                    color:Colors.black45,
                    fontFamily: "Inter",
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),  
                decoration:  InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color:greyShade200,
                    fontFamily: "Inter",
                    fontSize: 14,
                  )
                ),
              )),

              IconButton(onPressed:onpressedObscure, icon:Icon(obscureIcon,color:Colors.black45),),
              IconButton(onPressed:onpressed, icon:Icon(suffixIcon,color:colorIcon),),
            ],
            ),
        ),
      ),
    );
  }
}