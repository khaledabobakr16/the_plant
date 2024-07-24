
import 'package:clean_house/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
class LoadingHomeScreen extends StatelessWidget {
  const LoadingHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [  
                              Center(
                                child: Shimmer.fromColors(
                                  baseColor: cBlue,
                                  highlightColor: cBlue2,
                                  child: Card(
                                    color: cBlue,
                                    elevation: 4,
                                    // ignore: sized_box_for_whitespace
                                    child: Container(width: double.infinity,child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        Text(("").toUpperCase(),style: GoogleFonts.allerta(color:cWhite,fontWeight:FontWeight.w600,fontSize:width*0.045),),
                                        Text("",style: GoogleFonts.allerta(color:cWhite,fontWeight:FontWeight.w100,fontSize:width*0.045),),
                                        SizedBox(height: height*0.02,),
                                        const Divider(color: cWhite,height: 2,),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                            Column(
                                              children: [
                                               Text(
                                                    '',
                                                    style: GoogleFonts.allerta(color:cWhite,fontWeight:FontWeight.w600,fontSize:width*0.035),
                                                ),  
                                              Text(
                                                  '',
                                                   style: GoogleFonts.allerta(color:cWhite,fontWeight:FontWeight.w600,fontSize:width*0.065),
                                                  ),       
                                              Text(
                                                  '',
                                                   style: GoogleFonts.allerta(color:cWhite,fontWeight:FontWeight.w300,fontSize:width*0.035),
                                                  ),                          
                                            ],),
                                            Column(children: [
                                              // LottieBuilder.asset("assets/assets/anims/cloudy.json",),
                                              Text(
                                                  '',
                                                   style: GoogleFonts.allerta(color:cWhite,fontWeight:FontWeight.w300,fontSize:width*0.025),
                                                  ),
                                            ],)
                                          ],),
                                        ),
                                      ],),
                                    ),),
                                  ),
                                ),
                              ),
                              SizedBox(height: height*.02,),
                              Text("Others City",style: GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.bold),),
                              SizedBox(height: height*.01,),
                              SizedBox(
                                height: height / 5,
                                width: double.infinity,
                                child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
     
                                return Shimmer.fromColors(
                                  baseColor: cWhite,
                                  highlightColor: cBlue2,
                                  child: Card(
                                  elevation: 4,
                                  child: Container(
                                  color: Colors.white,
                                  child: const Padding(
                                  padding: EdgeInsets.all(25.0),
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  Expanded(
                                  child: Text(
                                  "",
                                  style: TextStyle(
                                  color: cBlack,
                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                '          ',
                                                                style: TextStyle(
                                  color:cBlack,
                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                            // Expanded(child: LottieBuilder.asset("assets/assets/anims/cloudy.json")),
                                                            Expanded(
                                                              child: Text(
                                                                '',
                                                                style: TextStyle(
                                  color:cBlack,
                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                      ),
                                );
                                  },
                                
                              
                              
                               
                                                       separatorBuilder: (context, index) {
                                                      return const SizedBox(width: 2);
                          },
                          itemCount: 4,
                          ),
                            ),
                            SizedBox(height: height*.02,),
                            Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                               Text("Recent history",style:  GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.bold),),
                                Text("See all >",style:  GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.w300),),
                              ],),
                              Shimmer.fromColors(
                                baseColor: cWhite,
                                highlightColor: cBlue2,
                                child: Card(
                                  elevation: 4,
                                  child: Container(
                                    width: double.infinity,
                                    color: cWhite,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold)),
                                          Text("",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold)),
                                          Text("",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold)),
                                          Text("",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold)),
                                          Text("",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold)),
                                          Center(child: Text("",style:  GoogleFonts.rubik(color:cBlue,fontWeight:FontWeight.bold))),
                                        ],
                                      ),
                                    ),
                                ),),
                              )
                            ],
                          );
  }
}