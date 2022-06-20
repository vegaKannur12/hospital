import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/network_connectivity.dart';
import 'package:hospital/MODEL/getRegistration_model.dart';
import 'package:hospital/MODEL/registrationModel.dart';
import 'package:hospital/SCREEN/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends ChangeNotifier {
  bool isLoading = false;
  String? cid;
  String? fp;
  var map;
  Future<GetRegistration?> postRegistration(
      String company_code, BuildContext context) async {
    try {
      Uri url = Uri.parse("http://146.190.8.166/API/get_registration.php");
      Map body = {
        'company_code': 'ARSYWPQUDT',
      };
      print("compny----${company_code}");
      // isLoading = true;
      // notifyListeners();
      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
      );

      print("body ${body}");
      print("response ${response.body}");
      var map = jsonDecode(response.body); 
      print("map ${map}");
      GetRegistration regModel = GetRegistration.fromJson(map);
      print("cid ${regModel.cid}");

      cid = regModel.cid;
      fp = regModel.fp;
      verifyRegistration(cid!, fp!, context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StaffLogin()),
      );
      // print("regModel${regModel}");

      // cid = regModel.cid;
      // sof = regModel.sof;
      // print("sof----${sof}");

      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  /////////////////// verify registration//////////////
  Future<Registration?> verifyRegistration(
      String company_code, String fp, BuildContext context) async {
    var res;
    print("company_code---fp-${company_code}---${fp}");

    try {
      Uri url = Uri.parse("http://146.190.8.166/API/verify_registration.php");
      Map body = {
        'company_code': 'ARSYWPQUDT',
        'fingerprint': 'UV3U7XC2WX6Y7QG',
      };

      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
      );

      print("body ${body}");
      var map = jsonDecode(response.body);
      print("map verify ${map}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
