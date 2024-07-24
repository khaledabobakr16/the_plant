// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/colors.dart';
import '../../../utils/image_util.dart';
import '../../../widget/history.dart';
import '../history/history_screen.dart';
import '../predict/predict_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_screen.dart';
import '../splash/splash_screen.dart';
import '../webview/webviewapp.dart';
import 'loading_home_screen.dart';
import 'widgets/fname_img_loading.dart';

 
// ignore: non_constant_identifier_names
List<Widget>Screens=const [
  Home(),
  PredicitScreen(),
  HistoryScreen()
];

List<dynamic>pageIcon=[
  Icons.home,
  Icons.add,
  Icons.history
];
List<String>pageTite=[
  "Home",
  "Prediction",
  "History"
];
List<String>cities=[
  'Ismailia',
  'Giza',
  'Alexandria',
  'Mansoura'
];
dynamic response;
Position? _currentPosition;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Map<String, dynamic>> history=[];
  dynamic page=0;
  String baseUrl="";
   CollectionReference users = FirebaseFirestore.instance.collection('users');
   UserCredential? userCredential;
  Future<Map<String, dynamic>> fetchWeatherData({String city=""}) async {

    if(city==""){
      String coordinates="lat=${_currentPosition?.latitude ?? "cairo"}&lon=${_currentPosition?.longitude ?? "cairo"}";
      if(coordinates=="lat=cairo&lon=cairo")
      {
        coordinates="q=cairo";
      }
      response = (await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=cairo&appid=b55e8a8c485fab5454debfa45eb272c4')));

    }
    else{
       response = (await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=b55e8a8c485fab5454debfa45eb272c4')));
    }
    

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      
      throw Exception('Failed to load weather data');
      
    }

  }

  @override
  void initState() {
    super.initState();
     _getCurrentPosition();
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
        log("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return  HiddenDrawer(
      drawerBlurRadius: 1,
      drawerWidth: MediaQuery.of(context).size.width * .4,
      drawer:HiddenDrawerMenu(
        drawerDecoration:const  BoxDecoration(
          color: cBlue,
        ),
        menuActiveColor: cBlue,
        menuColor: cBlue,
        menu: <DrawerMenu>[
        DrawerMenu(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                   page==1? SvgPicture.asset("assets/images/ai-5.svg",height: 25, color: Colors.black) :Icon(pageIcon[page],color: Colors.black,),
                    SizedBox(width: width*0.02,),
                    Text(pageTite[page],style:GoogleFonts.rubik(color:Colors.black,fontWeight:FontWeight.bold)),
                  ],
                ),
              ),
              onPressed: () {
                // ignore: avoid_print
                print("Menu 1");
              }),
          DrawerMenu(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.person,color: Colors.black,),
                    SizedBox(width: width*0.02,),
                    Text("Profile",style:GoogleFonts.rubik(color:Colors.black,fontWeight:FontWeight.bold)),
                  ],
                ),
              ),
              onPressed: () {
               Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileScreen()));
              }),
          DrawerMenu(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.settings,color:Colors.black),
                    SizedBox(width: width*0.02,),
                    Text("Settings",style:GoogleFonts.rubik(color:Colors.black,fontWeight:FontWeight.bold)),
                  ],
                ),
              ),
              onPressed: () {
                 Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               const SettingsScreen()));
              }),
                  DrawerMenu(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.support_agent_outlined ,color:Colors.black),
                    SizedBox(width: width*0.02,),
                    Text("Contact Us",style:GoogleFonts.rubik(color:Colors.black,fontWeight:FontWeight.bold)),
                  ],
                ),
              ),
              onPressed: () {
                               Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               const WebViewApp()));
               
              }),
        ],
        header: SafeArea(
          child: FutureBuilder(
            future: getCurrentUserUid(),
                    builder: (BuildContext context, AsyncSnapshot<String> uidSnapshot) {
           if (uidSnapshot.connectionState == ConnectionState.waiting) {
             return const FnameAndImgLoading();
           }
           if (uidSnapshot.hasError) {
             return const Center(child: Text("Something went wrong"));
           }
           if (!uidSnapshot.hasData || uidSnapshot.data == null) {
             return const Center(child: Text("No user logged in."));
           }
           String uid = uidSnapshot.data!;
            return FutureBuilder<DocumentSnapshot>(
             future: users.doc(uid).get(),
             builder:
                      (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            
             if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
                      }
            
                      if (snapshot.hasData && !snapshot.data!.exists) {
                      return const Center(child: Text("Document does not exist"));
                      }
            
                      if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                      return Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               SizedBox(height: height*0.02,),
                Center(child: CircleAvatar(
                 backgroundColor: Colors.grey.shade100,
                 backgroundImage: data["image"]==null?null: NetworkImage(data["image"],),
                 radius: 35,
                 child:  data["image"]==null? const Icon(CupertinoIcons.person,color: Colors.black,):null,
               )),
               SizedBox(height: height*0.02,),
               Text("${data["fullname"] ?? "No Name"}",style: GoogleFonts.rubik(color:cWhite),),
             ],
                      );
                      }
            
                    return const FnameAndImgLoading();
                  },
                );
                }),
        ),
        footer: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: ()async{
            await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => 
                 const SplashScreen()));
            },
            child: Row(
              children: [
                const Icon(Icons.logout_outlined,color:Colors.black),
                Text("Logout",style: GoogleFonts.rubik(color:Colors.black)),
              ],
            ),
          ),
        ),
      ),
     child: Scaffold(
          bottomNavigationBar:  CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: cBlue,
          color: cBlue,
          animationDuration: const Duration(milliseconds: 300),
          items:  <Widget>[
            const Icon(Icons.home, size: 26, color: Colors.white),
            SvgPicture.asset("assets/images/ai-5.svg",height: 40, color: Colors.white),
            const Icon(Icons.history, size: 26, color: Colors.white),
            // Icon(Icons.notifications, size: 26, color: Colors.white),
            // Icon(Icons.person, size: 26, color: Colors.white),
          ],
          onTap: (index) {
              page = index;
            setState(() {
             fetchHistoryData();
          });
          },
                  ),
        body: page==2? const HistoryScreen():page==1? const PredicitScreen(): SingleChildScrollView(
              child: Stack(
                children: [
                const Positioned(right: 0,child:  ImageAsset(imagePath: "assets/images/bubble-4.png",)),
                const Positioned(right: 0,child: ImageAsset(imagePath: "assets/images/bubble-5.png",)),              
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  HiddenDrawerIcon(
                              mainIcon: const Icon(Icons.menu),
                            ),
                        SizedBox(height: height*0.08,),
                        FutureBuilder(
                          future: fetchWeatherData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const LoadingHomeScreen();
                            } else if (snapshot.hasError) {
                              return const LoadingHomeScreen();
                            } else {
                              final weatherData = snapshot.data;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [  
                                  Center(
                                    child: Card(
                                      color: cBlue,
                                      elevation: 4,
                                      child: SizedBox(width: double.infinity,child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Text(("${weatherData!['name']}").toUpperCase(),style: GoogleFonts.allerta(color:cWhite,fontWeight:FontWeight.w600,fontSize:width*0.045),),
                                          Text(DateFormat().add_MMMMEEEEd().format(DateTime.now()),style: GoogleFonts.allerta(color:cWhite,fontWeight:FontWeight.w100,fontSize:width*0.045),),
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
                                                      '${weatherData['weather'][0]['description']}',
                                                      style: GoogleFonts.allerta(color:cWhite,fontWeight:FontWeight.w600,fontSize:width*0.035),
                                                  ),  
                                                Text(
                                                    '${(weatherData['main']['temp']- 273.15).round().toString()} \u2103',
                                                     style: GoogleFonts.allerta(color:cWhite,fontWeight:FontWeight.w600,fontSize:width*0.065),
                                                    ),       
                                                Text(
                                                    'min: ${(weatherData['main']['temp_min']- 273.15).round().toString()} \u2103 / max: ${(weatherData['main']['temp_max']- 273.15).round().toString()} \u2103',
                                                     style: GoogleFonts.allerta(color:cWhite,fontWeight:FontWeight.w300,fontSize:width*0.035),
                                                    ),                          
                                              ],),
                                              Column(children: [
                                                LottieBuilder.asset("assets/assets/anims/cloudy.json",),
                                                Text(
                                                    'Wind Speed: ${weatherData['wind']['speed']} m/s',
                                                     style: GoogleFonts.allerta(color:cWhite,fontWeight:FontWeight.w300,fontSize:width*0.025),
                                                    ),
                                              ],)
                                            ],),
                                          ),
                                        ],),
                                      ),),
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
                                       return FutureBuilder(
                                      future: fetchWeatherData(city: cities[index]), // Fetch weather data for the city
                                      builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return  Shimmer.fromColors(
                                      baseColor: cWhite,
                                      highlightColor: cBlue2,
                                      child: Card(
                                      elevation: 4,
                                      child: Container(
                                      color: Colors.white,
                                      child: const Padding(
                                      padding:  EdgeInsets.all(25.0),
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
                                    ); // Show loading indicator while data is being fetched
                                      } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                    Map<String, dynamic> weatherData = snapshot.data as Map<String, dynamic>;
                                    return Card(
                                    elevation: 4,
                                    child: Container(
                                    color: Colors.white,
                                    child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                    Expanded(
                                    child: Text(
                                    cities[index],
                                    style: const TextStyle(
                                    color: cBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${(weatherData['main']['temp'] - 273.15).round().toString()} \u2103',
                                  style: const TextStyle(
                                    color:cBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(child: LottieBuilder.asset("assets/assets/anims/cloudy.json")),
                              Expanded(
                                child: Text(
                                  '${weatherData['weather'][0]['description']}',
                                  style: const TextStyle(
                                    color:cBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                        );
                                      }
                                    },
                                  );
                                      },
                                                           separatorBuilder: (context, index) {
                                                          return const SizedBox(width: 2);
                              },
                              itemCount: cities.length,
                              ),
                                ),
                                SizedBox(height: height*.02,),
                                Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                   Text("Recent history",style:  GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.bold),),
                                    InkWell(onTap:(){
                                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => 
                                  const HistoryScreen()));
                                    } ,child: Text("See all >",style:  GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.w300),)),
                                  ],),
                                history.isNotEmpty? History(
                                 averageRainfall: history[0]["average_rainfall"].toString(),
                                  year: history[0]["year"].toString(),
                                  country:history[0]["country"].toString(),
                                  cropYield: history[0]["crop_type"],
                                  quantityOfPesticides: history[0]["pesticides_quantity"],
                                  predicitonResult: history[0]["prediction_result"],
                                )
                      :Card(
                      elevation: 4,
                      child: Container(
                      width: double.infinity,
                      color: cWhite,
                      child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                           Center(child: ImageAsset(imagePath: "assets/images/empty_history.png",height:height*0.065,)),
                          Center(child: Text("The history is empty.",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold,fontSize:14),)),
                        Center(child: Text("You have not made a prediction before",style:  GoogleFonts.rubik(color:cBlack,fontWeight:FontWeight.bold,fontSize:14),)),
                      ],
                         ),
                        ),
                       ),
                       )
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      
      ));
    // );

  }
   Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
    log('${ _currentPosition!.latitude},${_currentPosition!.longitude}');
  }

    Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          backgroundColor: cYellow,
          content: Text(
              'Location services are disabled. Please enable the services',style: GoogleFonts.inter(color:cWhite,fontWeight:FontWeight.bold),)));
        //        response = (await http.get(Uri.parse(
        // 'https://api.openweathermap.org/data/2.5/weather?q=ismailia&appid=b55e8a8c485fab5454debfa45eb272c4')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              backgroundColor: cYellow,
              content: Text('Location permissions are denied',style: GoogleFonts.inter(color:cWhite,fontWeight:FontWeight.bold),)));
        return false;
      }
      //  response = (await http.get(Uri.parse(
      //   'https://api.openweathermap.org/data/2.5/weather?q=ismailia&appid=b55e8a8c485fab5454debfa45eb272c4')));
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(

         SnackBar(
          backgroundColor: cYellow,
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.',style: GoogleFonts.inter(color:cWhite,fontWeight:FontWeight.bold),)));
      return false;
    }
    return true;
  }
  
  Future<String> getCurrentUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    return '';
  }
}




