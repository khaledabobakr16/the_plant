import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class History extends StatelessWidget {
  const History(
  {
     super.key,
     this.year,
     this.averageRainfall,
     this.country,
     this.cropYield,
     this.quantityOfPesticides,
     this.predicitonResult,
  });
  final String?year;
  final String?averageRainfall;
  final String?quantityOfPesticides;
  final String?country;
  final String?cropYield;
  final String? predicitonResult;
  @override
  Widget build(BuildContext context) {
    return  Card(
    elevation: 4,
    child: Container(
    width: double.infinity,
    color: cWhite,
    child: Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     Text("Year : ${year!}",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold)),
     Text("Average Rainfall : ${averageRainfall!} mm/year",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold)),
     Text("Quantity of Pesticides : ${quantityOfPesticides!} tonnes",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold)),
     Text("Country : ${country!}",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold)),
     Text("Crop Type : ${cropYield!}",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold)),
     Center(child: Text("Prediciton Result : ${predicitonResult!} Tons",style:  GoogleFonts.rubik(color:cBlue,fontWeight:FontWeight.bold))),
    ],
   ),
  ),
 ),
 );
  }
}