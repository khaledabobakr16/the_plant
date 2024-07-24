import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';

import '../../../utils/colors.dart';
import '../../../utils/image_util.dart';
import '../../../widget/history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late List<Map<String, dynamic>> history=[];
  @override
  void initState() {
    super.initState();
    fetchHistoryData();
  }
 Future<void> fetchHistoryData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      // ignore: prefer_const_declarations
      final databaseURL = "https://graduation-project-560f4-default-rtdb.firebaseio.com/";
      final response = await http.get(Uri.parse("$databaseURL/users/${user!.uid}/history.json"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        List<Map<String, dynamic>> tempHistory = [];

        responseData.forEach((key, entry) {
          tempHistory.add({
            'id': key, // Assuming each entry has an ID/key
            'year': entry['year'],
            'average_rainfall': entry['average_rainfall'],
            'pesticides_quantity': entry['pesticides_quantity'],
            'average_temperature': entry['average_temperature'],
            'country': entry['country'],
            'crop_type': entry['crop_type'],
            'prediction_result': entry['prediction_result'],
          });
        });

        setState(() {
          history = tempHistory.reversed.toList();
        });
      } else {
        // ignore: avoid_print
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    final width=MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Stack(
        children: [
        const Positioned(right: 0,child:  ImageAsset(imagePath: "assets/images/bubble-4.png",)),
        const Positioned(right: 0,child: ImageAsset(imagePath: "assets/images/bubble-5.png",)),
        SafeArea(child:Padding(padding:const EdgeInsets.all(20),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          HiddenDrawerIcon(
          mainIcon: const Icon(Icons.art_track),
          ),
          SizedBox(height: height*0.06,),
          Text("History:",style: GoogleFonts.inter(
                      color:cBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),),
          SizedBox(height: height*0.06,),
        history.isNotEmpty?Expanded(
            child: SizedBox(
              child: ListView.separated(itemBuilder: (context, index) {
                return history==[]?const Center(child: CircularProgressIndicator(backgroundColor: cBlue,)):History(
                  averageRainfall: history[index]["average_rainfall"].toString(),
                  year: history[index]["year"].toString(),
                  country:history[index]["country"].toString(),
                  cropYield: history[index]["crop_type"],
                  quantityOfPesticides: history[index]["pesticides_quantity"],
                  predicitonResult: history[index]["prediction_result"],
                );
              }, separatorBuilder: (context, index) {
                return SizedBox(height: height*0.02,);
              }, itemCount: history.length),
            ),
          ): Center(
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height*.2,),
                  Center(child: ImageAsset(imagePath: "assets/images/empty_history.png",height:height*0.1,)),
                  Center(child: Text("The history is empty.",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold,fontSize:16),)),
                 Center(child: Text("You have not made a prediction before",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold,fontSize:16),)),
                ],
              ),
            ),
          ),
        ],
        ),) ,),              
        ],
      ),
    );
  }
}


