import 'package:clean_house/utils/colors.dart';
import 'package:flutter/material.dart';

class OrLine extends StatelessWidget {
  const OrLine({super.key});

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return  Row(
      children:  [
              Expanded(child: Divider(color: blackShade,endIndent:width*0.026 ,indent: width/5,thickness: 0,)),
              const Text("or",style:  TextStyle(color: blackShade,fontSize: 14,fontFamily: "Actor",fontWeight:FontWeight.w600 ),),
              Expanded(child: Divider(color: blackShade,endIndent: width/5,indent:width*0.026,thickness: 0,),),
   ]);
  }
}