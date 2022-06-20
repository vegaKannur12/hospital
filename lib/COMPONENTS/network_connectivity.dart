import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetConnection {
  static Future<bool> networkConnection(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      final snackBar = SnackBar(
        content: Text('No internet connection'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("Select a date");
      return false;
    }
    return false;
  }
}
