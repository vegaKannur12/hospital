import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/network_connectivity.dart';
import 'package:hospital/MODEL/getRegistration_model.dart';
import 'package:hospital/MODEL/registrationModel.dart';
import 'package:hospital/SCREEN/login.dart';
import 'package:hospital/db_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends ChangeNotifier {
  List<Map<String, dynamic>> companyList = [];
  bool isLoading = false;
  String? cid;
  String? fp;
  String? sof;
  String? userType;
  String? cname;
  List<CD>? c_d;
  var map;
  Future<GetRegistrationData?> postRegistration(
      String company_code, BuildContext context) async {
    // NetConnection.networkConnection(context).then((value) async {
    //   await HospitalAppDb.instance.deleteFromTableCommonQuery('menuTable', "");
    //   if (value == true) {
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_registration.php");
      Map body = {
        'company_code': company_code,
      };
      print("compny----${company_code}");
      isLoading = true;
      notifyListeners();
      http.Response response = await http.post(
        url,
        body: body,
      );

      print("body ${body}");
      var map = jsonDecode(response.body);
      print("map ${map}");
      // print("response ${response}");
      GetRegistrationData regModel = GetRegistrationData.fromJson(map);
      userType = regModel.type;
      sof = regModel.sof;
      print("sof----${sof}");
      if (sof == "1") {
        /////////////// insert into local db /////////////////////
        late CD dataDetails;
        String? fp = regModel.fp;
        String? os = regModel.os;
        regModel.c_d![0].cid;
        cid = regModel.cid;
        print(cid);
        cname = regModel.c_d![0].cnme;
        print(cname);

        notifyListeners();
        for (var item in regModel.c_d!) {
          c_d!.add(item);
        }
        print(cid);
        var res = await OrderAppDB.instance.insertRegistrationDetails(regModel);

        print("inserted ${res}");
        isLoading = false;
        // notifyListeners();
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString("company_id", company_code);
        // prefs.setString("cid", cid!);
        // prefs.setString("os", os!);

        getCompanyData();
       
        verifyRegistration(cid!, fp!, context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StaffLogin()),
        );
      }
      /////////////////////////////////////////////////////
      // if (sof == "0" || company_code.length < 10) {
      //   CustomSnackbar snackbar = CustomSnackbar();
      //   snackbar.showSnackbar(context, "Invalid Company Key");
      // }

      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    // }
    // });
  }

  //////////////////////////////////////////
  getCompanyData() async {
    try {
      isLoading = true;
      // notifyListeners();
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? cid = prefs.getString("cid");
      print('cidnew---$cid');
      var res = await OrderAppDB.instance.selectCompany("cid='${cid}'");
      print("res companyList----${res}");
      for (var item in res) {
        companyList.add(item);
      }
      print("companyList ----${companyList}");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  /////////////////// verify registration//////////////
  Future<Registration?> verifyRegistration(
      String company_code, String fp, BuildContext context) async {
    var res;
    print("company_code---fp-${company_code}---${fp}");

    try {
      Uri url = Uri.parse("http://146.190.8.166/API/verify_registration.php");
      Map body = {
        'company_code': cid,
        'fingerprint': fp,
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
