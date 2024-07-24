// ignore_for_file: sized_box_for_whitespace, prefer_is_empty


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../controller/home_controller.dart';
import '../data/local/constants.dart';
import '../data/models/current_weather_data.dart';
import '../utils/colors.dart';


class MyList extends GetView<HomeController> {
  const MyList({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) =>
            const VerticalDivider(
              color: Colors.transparent,
              width: 5,
            ),
        itemCount: controller.dataList!.length,
        itemBuilder: (context, index) {
          CurrentWeatherData? data;
          (controller.dataList!.length > 0)
              ? data = controller.dataList![index]
              : data = null;
          return Container(
            width: 140,
            height: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      (data != null)
                          ? '${data.name}'
                          : '',
                         style: GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.bold),
                      // style: Theme.of(context)
                      //     .textTheme
                      //     .caption!
                      //     .copyWith(
                      //   fontSize: 18,
                      //   fontWeight: FontWeight.bold,
                      //   color: Colors.black45,
                      //   fontFamily: 'flutterfonts',
                      // ),
                    ),
                    Text(
                      (data != null)
                          ? '${(data.main!.temp !- 273.15).round().toString()}\u2103'
                          : '',
                         style: GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.bold),
                      // style: Theme.of(context)
                      //     .textTheme
                      //     .caption!
                      //     .copyWith(
                      //   fontSize: 18,
                      //   fontWeight: FontWeight.bold,
                      //   color: Colors.black45,
                      //   fontFamily: 'flutterfonts',
                      // ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: LottieBuilder.asset(
                          AssetConstants.cloudyAnim),
                    ),
                    Text(
                      (data != null)
                          ? '${data.weather![0].description}'
                          : '',
                        style: GoogleFonts.rubik(color:cBlack2,fontWeight:FontWeight.bold),
                      // style: Theme.of(context)
                      //     .textTheme
                      //     .caption!
                      //     .copyWith(
                      //   color: Colors.black45,
                      //   fontFamily: 'flutterfonts',
                      //   fontSize: 14,
                      // ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
