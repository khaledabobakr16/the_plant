// ignore_for_file: unnecessary_import, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:ui';


import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/local/countries.dart';
import '../../../data/local/crops.dart';
import '../../../utils/colors.dart';
import '../../../utils/image_util.dart';
import 'widgets/button.dart';
import 'widgets/drop_down_txtfield.dart';
import 'widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredicitScreen extends StatefulWidget {
  const PredicitScreen({super.key});

  @override
  State<PredicitScreen> createState() => _PredicitScreenState();
}

class _PredicitScreenState extends State<PredicitScreen> {

  @override
  void initState() {
    super.initState();
    _callApi();

  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController year = TextEditingController();
  final TextEditingController averageRain = TextEditingController();
  final TextEditingController pesticidesTonnes = TextEditingController();
  final TextEditingController avgTemp = TextEditingController();


  String? country = "";
  String? yieldd = "";
  String? predictionRes="";
  // final TextEditingController area = TextEditingController();
  // final TextEditingController item = TextEditingController();
  bool _absorbing =false;
  @override
  Widget build(BuildContext context) {
    
    final height=MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Stack(
        children: [
          const Positioned(left: 0,child:  ImageAsset(imagePath: "assets/images/predict-bubble-2.png",)),
          const Positioned(left: 0,child: ImageAsset(imagePath: "assets/images/predict-bubble-1.png",)),              
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AbsorbPointer(
                absorbing: _absorbing,
                child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                            HiddenDrawerIcon(
                                mainIcon: const Icon(Icons.art_track),
                        ),
                        SizedBox(height: height*0.1),
                      RichText(
                              text: TextSpan(
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    children: const [
                      TextSpan(text: "Fill out this form and get crop yield forecasts "),
                      WidgetSpan(
                        child: Text(
                          "🌿",
                          style: TextStyle(fontSize: 25,color:cBlue,fontWeight: FontWeight.bold), // Adjust emoji size if necessary
                        ),
                      ),
                    ],
                  ),
                ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      TxtField(
                        controller: year,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter vaild Year";
                          }
                          return null;
                        },
                        keybordtype: TextInputType.number,
                        autocorrect: false,
                        textcapitalization: TextCapitalization.none,
                        hinttext: "Year",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      TxtField(
                        controller: averageRain,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter vaild Average Rainfall";
                          }
                          return null;
                        },
                        keybordtype: TextInputType.number,
                        autocorrect: false,
                        textcapitalization: TextCapitalization.none,
                        hinttext: "Average Rainfall(mm/year)",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      TxtField(
                        controller: pesticidesTonnes,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter vaild Quantity of Pesticides";
                          }
                          return null;
                        },
                        keybordtype: TextInputType.number,
                        autocorrect: false,
                        textcapitalization: TextCapitalization.none,
                        hinttext: "Quantity of Pesticides(tons)",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      TxtField(
                        controller: avgTemp,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter vaild Average of Temperature";
                          }
                          return null;
                        },
                        keybordtype: TextInputType.number,
                        autocorrect: false,
                        textcapitalization: TextCapitalization.none,
                        hinttext: "Average of Temperature",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                     DropDownTxtField(
                                onchanged: (value) {
                                if (value != null) { // Ensure value is not null before assigning
                                country = value.value;
                                log(country!);
                                } 
                                },
                                validator: (value) {
                                if (value!.isEmpty) {
                                return "Enter vaild Country";
                                }
                                return null;
                                },
                                hinttext: "Country",

                                dropdownlist: countries.values
                                    .map((e) =>
                                        DropDownValueModel(value: e, name: e))
                                    .toList(),
                              ),
                      // TxtField(
                      //   controller: area,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return "Enter vaild Area";
                      //     }
                      //     return null;
                      //   },
                      //   keybordtype: TextInputType.name,
                      //   autocorrect: false,
                      //   textcapitalization: TextCapitalization.none,
                      //   hinttext: "Area",
                      // ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                       DropDownTxtField(
                                onchanged: (value) {
                              if (value != null) { // Ensure value is not null before assigning
                                yieldd = value.value;
                                log(yieldd!);
                                } 
                                },
                                validator: (value) {
                                if (value!.isEmpty) {
                                return "Enter vaild Yield";
                                }
                                return null;
                                },
                                hinttext: "Yield",
                                dropdownlist: crops.values
                                    .map((e) =>
                                        DropDownValueModel(value: e, name: e))
                                    .toList(),
                              ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Button(
                        color: cBlue,
                        onpressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(()async {
                              await sendData(
                                  area: country,
                                  avgRain: averageRain.text,
                                  pesticidesTonnes: pesticidesTonnes.text,
                                  avgTemp: avgTemp.text,
                                  year: year.text,
                                  item: yieldd);
                             await getData();
                            });
                          }
                        },
                        child: _absorbing==true? const ImageAsset(imagePath: "assets/images/loading.gif",): const Text("Predict",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future sendData(
    {
    String? year,
    String? avgRain,
    String? pesticidesTonnes,
    String? avgTemp,
    String? area,
    String? item,
  }) async {
    setState(() {
    _absorbing=true;
    });
    Map<String, dynamic> requestData = {
      'Year': year,
      'average_rain_fall_mm_per_year': avgRain,
      'pesticides_tonnes': pesticidesTonnes,
      'avg_temp': avgTemp,
      'Area': area,
      "Item": item
    };
    await http.post(
      Uri.parse(
          "https://crop-yield-prediction-6asp.onrender.com/api"), //10.0.2.2:5000 ,http://127.0.0.1:5000/api
      body: json.encode(requestData),
    );
  }

  Future<void> getData() async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://crop-yield-prediction-6asp.onrender.com/api"), //10.0.2.2:5000 ,http://127.0.0.1:5000/api
      );
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body) as Map<String, dynamic>;
        dynamic finalResponse =decoded['prediction'];
        log("Response: $finalResponse");
        double resultPredication=double.parse(removeEdges(finalResponse.toString()))/1000;//convert from Hg/ha to tonnes
        log(resultPredication.toString());
         // ignore: await_only_futures
         predictionRes=await resultPredication.toString();
        showDialog(

            context: context,
            builder: (context) => AlertDialog(

                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Close",style:GoogleFonts.rubik(color:cBlue),)),
                  ],
                  title:  Text("Crop yield Prediction",style:GoogleFonts.inter(color:cBlue,fontWeight:FontWeight.bold),),
                  contentPadding: const EdgeInsets.all(20.0),
                  // ignore: unrelated_type_equality_checks
                  content:resultPredication==""?RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Prediction Result : ',
        style: GoogleFonts.rubik(color: cBlack,fontWeight: FontWeight.bold),
      ),
      TextSpan(
        text: '43.151 ',
        style: GoogleFonts.rubik(color: Colors.red, fontWeight: FontWeight.bold),
      ),
         TextSpan(
        text: 'Tons',
        style: GoogleFonts.rubik(color: cBlack, fontWeight: FontWeight.bold),
      ),
    ],
  ),
): RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Prediction Result : ',
        style: GoogleFonts.rubik(color: cBlack,fontWeight: FontWeight.bold),
      ),
      TextSpan(
        text: '$resultPredication ',
        style: GoogleFonts.rubik(color: cBlue, fontWeight: FontWeight.bold),
      ),
      TextSpan(
        text: 'Tons',
        style: GoogleFonts.rubik(color: cBlack, fontWeight: FontWeight.bold),
      ),
    ],
  ),
),
                ));
      } else {
        log("Failed to get data. Status code: ${response.statusCode}");
         showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Close",style:GoogleFonts.rubik(color:cBlue),))
                  ],
                  title: Text("Internet error",style:GoogleFonts.rubik(color:cBlue),),
                  contentPadding: const EdgeInsets.all(20.0),
                  content:Text("Please check the internet",style:GoogleFonts.rubik(color:cBlack)),
                ));
      }
    } catch (e) {
      log("Error getting data: $e");
       showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child:  Text("Close",style:GoogleFonts.rubik(color:cBlue)))
                  ],
                  title:  Text("Internet error",style:GoogleFonts.rubik(color:cBlue)),
                  contentPadding: const EdgeInsets.all(20.0),
                  content:Text("Please check the internet",style:GoogleFonts.rubik(color:cBlack)),
                ));
    }
    
    setState(() {
       _absorbing=false;
       _addHistoryEntry();
    });
      
  }

    Future<void> _callApi() async {

    try {
      final response = await http.get(Uri.parse('https://crop-yield-prediction-6asp.onrender.com/api'));
      if (response.statusCode == 200) {
        setState(() {
            log(json.decode(response.body)['data']);
        });
      } else {
         log('Failed to load data');
      }
    } catch (e) {
      log('Error: $e');
    }
    
  }
  String removeEdges(String text) {
  if (text.length > 4) {
    return text.substring(2, text.length - 2);
  } else {
    return "Error Please Try Again"; 
  }
}
Future<void> _addHistoryEntry() async {
  final user = FirebaseAuth.instance.currentUser;
  // ignore: prefer_const_declarations
  final databaseURL = "https://graduation-project-560f4-default-rtdb.firebaseio.com/"; // استبدل <YOUR-FIREBASE-APP> بمعرف مشروعك الفعلي
  final url = Uri.parse("$databaseURL/users/${user!.uid}/history.json");
  
  final timestamp = DateTime.now().toIso8601String(); // توليد timestamp حالي

  final data = {
    'timestamp': timestamp, 
    'year': year.text,
    'average_rainfall': averageRain.text,
    'pesticides_quantity': pesticidesTonnes.text,
    'average_temperature': avgTemp.text,
    'country': country,
    'crop_type': yieldd,
    'prediction_result': predictionRes,
  };

  final response = await http.post(url, body: json.encode(data));

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    final newEntryId = responseData['name']; // احتفظ بالمفتاح (الـ ID) الذي تم إرجاعه من Firebase
    // ignore: avoid_print
    print("Data written successfully with ID: $newEntryId");
  } else {
    // ignore: avoid_print
    print("Failed to write data. Status code: ${response.statusCode}");
  }
}
}