import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class TxtField extends StatelessWidget {
  const TxtField({
    super.key,
    this.keybordtype,
    this.autocorrect = true,
    this.hinttext,
    this.prefixicon,
    this.suffixicon,
    this.textcapitalization,
    this.obscuretext = false,
    this.controller,
    this.validator,
    this.lettersSize,
  });
  final TextInputType? keybordtype;
  final bool? autocorrect;
  final String? hinttext;
  final TextCapitalization? textcapitalization;
  final Icon? prefixicon;
  final Widget? suffixicon;
  final bool? obscuretext;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? lettersSize;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keybordtype,
      autocorrect: autocorrect!,
      textCapitalization: TextCapitalization.none,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscuretext!,
      maxLength: lettersSize,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10.0),
            borderSide:
                const BorderSide(color: cBlue)
              ),
        hintText: hinttext,
        //hintMaxLines: lettersSize,
        errorMaxLines: 100,
        hintStyle: const TextStyle(
          color: cBlack,
        ),
        prefixIcon: prefixicon,
        prefixIconColor: cBlue,
        suffixIcon: suffixicon,
        suffixIconColor: cBlue,
        
        border: OutlineInputBorder(
        
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                const BorderSide(color: cBlue)
                ),
      ),
    );
  }
}
