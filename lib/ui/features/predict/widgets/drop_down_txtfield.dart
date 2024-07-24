import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class DropDownTxtField extends StatelessWidget {
  const DropDownTxtField({
    super.key,
    this.hinttext,
    this.icon,
    required this.dropdownlist,
    this.onchanged,
    this.validator,
    this.controller
  });
  final String? Function(String?)? validator;
  final String? hinttext;
  final List<DropDownValueModel> dropdownlist;
  final Icon? icon;
  final void Function(dynamic)? onchanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      controller: controller,
      clearOption: false,
      enableSearch: true,
      readOnly: true,
      validator: validator,
      onChanged: onchanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textFieldDecoration: InputDecoration(
          errorMaxLines: 100,
             focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10.0),
            borderSide:
                const BorderSide(color: cBlue)
              ),
          hintText: hinttext,
          hintStyle: const TextStyle(
          color: cBlack,
        ),
          prefixIcon: icon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 7, 115, 186)))),
      dropDownList: dropdownlist,
    );
  }
}
