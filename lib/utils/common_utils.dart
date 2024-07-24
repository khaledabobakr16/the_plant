import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../ui/helper/global_variables.dart';

void createSnackBar(String message) {                                                                               
  final snackBar =  SnackBar(content:  Text(message),                                                         
  backgroundColor: Colors.red);                                                                                                                             
  ScaffoldMessenger.of(GlobalVariables.currentContext!).showSnackBar(snackBar);                                                              
  }                                                                                                                   


//package_info_plus:
Future<String> getAppId() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.packageName;
}



