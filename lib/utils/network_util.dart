import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';


import 'common_utils.dart';



class NetworkCheck {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    // ignore: unrelated_type_equality_checks
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    // ignore: unrelated_type_equality_checks
    } else if (connectivityResult == ConnectivityResult.vpn) {
      return true;
    }
    return false;
  }

  static Future<bool> isOnline({bool showError = true}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    log("connectivityResult :$connectivityResult");
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    // ignore: unrelated_type_equality_checks
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    // ignore: unrelated_type_equality_checks
    } else if (connectivityResult == ConnectivityResult.vpn) {
      return true;
    }
    if (showError) createSnackBar("Please Check Internet Connection");
    return false;
  }

  dynamic checkInternet(Function func) {
    check().then((internet) {
      if (internet) {
        func(true);
      } else {
        func(false);
      }
    });
  }
}
