import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/network_connectivity.dart';
import 'package:hospital/MODEL/branch_model.dart';
import 'package:hospital/MODEL/chartData_model.dart';
import 'package:hospital/MODEL/getRegistration_model.dart';
import 'package:hospital/MODEL/registrationModel.dart';
import 'package:hospital/SCREEN/login.dart';
import 'package:hospital/SCREEN/tabbarinbody.dart';
import 'package:hospital/db_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends ChangeNotifier {
  // List<Map<String, dynamic>> collectionData = [];
  // List<Map<String, dynamic>> countData = [];
  // List<Map<String, dynamic>> visitData = [];
  // List<Map<String, dynamic>> departmentData = [];
  // List<Map<String, dynamic>> servicegroupData = [];
  bool isLoading = false;
  String? cid;
  String? fp;
  String? sof;
  String? userType;
  String? cname;
  String? title;
  String? from_date;
  String? till_date;
  String? branch_id;
  List<CD> c_d = [];
  List<Map<String, dynamic>> collectData = [];

  List<Map<String, dynamic>> branchList = [];
  List<Map<String, dynamic>> allData = [];
  List<CD> companyList = [];
  List<Map<String, dynamic>> collectionChart = [];
  var map;
  Future<GetRegistrationData?> postRegistration(
      String company_code, BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      //   await HospitalAppDb.instance.deleteFromTableCommonQuery('menuTable', "");
      if (value == true) {
        try {
          Uri url =
              Uri.parse("http://trafiqerp.in/order/fj/get_registration.php");
          Map body = {
            'company_code': company_code,
          };
          // print("compny----${company_code}");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );

          // print("body ${body}");
          var map = jsonDecode(response.body);
          // print("map ${map}");
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
            regModel.cid;
            cid = regModel.cid;
            // print(cid);
            cname = regModel.c_d![0].cnme;
            // print(cname);
            // print(regModel.c_d!.length);
            // notifyListeners();
            for (var item in regModel.c_d!) {
              // print("inside for length  ${regModel.c_d!.length}");
              c_d.add(item);
            }
            print("c_d list $c_d");
            var res =
                await OrderAppDB.instance.insertRegistrationDetails(regModel);

            // print("inserted ${res}");
            notifyListeners();

            print("cidrett---$cid");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("cid", cid!);

            
            // prefs.setString("os", os!);
            getCompanyData();
            verifyRegistration(cid!, fp!, context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          }

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  //////////////////////////////////////////
  getCompanyData() async {
    try {
      isLoading = true;
      // notifyListeners();
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? cid = prefs.getString("cid");
      // print('cidnew---$cid');
      var res = await OrderAppDB.instance.selectCompany("cid='${cid}'");
      // print("res companyList----${res}");
      for (var item in res) {
        companyList.add(item);
      }
      // print("companyList ----${companyList}");
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

      // print("body ${body}");
      var map = jsonDecode(response.body);
      // print("map verify ${map}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  ///////////////////chart data///////////////////////
  Future<ChartData?> chartDataSet() async {
    var res;
    // print("company_code---fp-${company_code}---${fp}");
    try {
      Uri url = Uri.parse("http://146.190.8.166/API/reports.php");
      // Map body = {
      //   'from_date': from_date,
      //   'till_date': till_date,
      //   'branch_id': branch_id,
      // };

      http.Response response = await http.post(
        url,
        // body: jsonEncode(body),
      );

      var map = jsonDecode(response.body);
      print("map ${map}");

      collectData.clear();
      print("map chart data ${map}");
<<<<<<< HEAD

      ChartData chartModel = ChartData.fromJson(map);
      print("chartModel  ${chartModel}");
         
      CollectionData dataDetails;
      // // print("collection data  ${dataDetails.title}");
      // title = chartModel.collectionData![0].title;
      // print("title   ${title}");
      // print("collection data length ${chartModel.collectionData!.length}");

      for (var item in chartModel.collectionData!) {
        print("inside for length  ${chartModel.toJson()}");
=======
      for (var item in map["collection_data"]) {
        print("inside for length  ${item}");
>>>>>>> b406eb02365d37499eb2d030bb79ef1f019f11ab
        collectData.add(item);
      }
      print("collectData ${collectData}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////////////////////
  getBranchList() async {
    try {
      branchList.clear();
      Uri url = Uri.parse("http://146.190.8.166/API/branch_list.php");
      http.Response response = await http.post(
        url,
        // body: body,
      );

      var map = jsonDecode(response.body);
      print("map.........$map");

      for (var item in map) {
        branchList.add(item);
      }

      print("branchList ${branchList}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
