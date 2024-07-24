import 'package:flutter/material.dart';

const Color cWhite = Color(0xffffffff);
const Color cWhite2 = Color(0xffC8C8C8);
const Color cWhite3 = Color(0xffD9ECF8);
const Color cBlue = Color(0xff2DA884);
const Color cBlue2 = Color(0xffDEEFFF);
const Color navyBluee = Color(0xff151940);
const Color navyBluee2 = Color(0xff161540);
const Color cgrey = Color(0xff41455E);
const Color cBlack = Color(0xff677294);
const Color cBlack2 = Color(0xff333333);
const Color greyShade = Color(0xffF5F6FA);
const Color greyShade100 = Color(0xffDEDEDE);
const Color greyShade200 = Color(0xff7F8192);
const Color greyShade300 = Color(0xffE2E5EA);
const Color greyShade400 = Color(0xff858EA9);
const Color blackShade = Color(0xff486484);
const Color cPurple = Color.fromARGB(255, 87, 249, 168);
const Color cYellow = Color(0xffF6D060);
int getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }
  return int.parse(hexColor, radix: 16);
}


