import 'package:clean_house/utils/colors.dart';
import 'package:flutter/material.dart';

class Txt extends StatelessWidget {

  const Txt({super.key,this.color=greyShade200,this.text=" ",this.fontWeight=FontWeight.normal});
  final  String text;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
      final  width=MediaQuery.of(context).size.width;
    return Text(text,
style: TextStyle(
                              color: color,
                              fontSize: width*0.030,
                              fontFamily: "Inter",
                              fontWeight: fontWeight
                            ),
                          );
  }
}