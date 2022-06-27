import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/globalurl.dart';
import 'package:hospital/COMPONENTS/network_connectivity.dart';
import 'package:hospital/MODEL/chartData_model.dart';
import 'package:hospital/MODEL/getRegistration_model.dart';
import 'package:hospital/MODEL/multichart_model.dart';
import 'package:hospital/MODEL/registrationModel.dart';
import 'package:hospital/SCREEN/2_dashboard.dart';
import 'package:hospital/db_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends ChangeNotifier {
  bool isLoading = false;
  List<num> num_list = [];
  List colorList = [];
  List colorListcount = [];
  num? sum;
  String? cid;
  // MultiChart? chart;
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
  var jsonEnMulti;
  List<Map<String, dynamic>> multiCollection = [];
  List<Map<String, dynamic>> multiDta = [];
  List<Map<String, dynamic>> multidepart = [];
  List<Map<String, dynamic>> multiservice = [];
  List<Map<String, dynamic>> multisetData = [];
  List<String> coldata = [];
  List<Map<String, dynamic>> rowData = [];
  List multiid = [];
  List<Map<String, dynamic>> multiCollection2 = [];
  List<Map<String, dynamic>> multiCollection3 = [];
  List<Map<String, dynamic>> countData = [];
  List<Map<String, dynamic>> departmentData = [];
  List<Map<String, dynamic>> servicegroupData = [];

  List<Map<String, dynamic>> branchList = [];
  List<Map<String, dynamic>> allData = [];
  List branchid = [];
  List<CD> companyList = [];
  List<Map<String, dynamic>> collectionChart = [];
  String urlgolabl = Globaldata.apiglobal;
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

          var map = jsonDecode(response.body);

          GetRegistrationData regModel = GetRegistrationData.fromJson(map);
          userType = regModel.type;
          sof = regModel.sof;
          print("sof----${sof}");
          if (sof == "1" && company_code.length >= 12) {
            /////////////// insert into local db /////////////////////
            late CD dataDetails;
            String? fp = regModel.fp;
            String? os = regModel.os;
            regModel.cid;
            cid = regModel.cid;
            // print(cid);
            cname = regModel.c_d![0].cnme;
            for (var item in regModel.c_d!) {
              c_d.add(item);
            }
            print("c_d list $c_d");
            var res =
                await OrderAppDB.instance.insertRegistrationDetails(regModel);
            notifyListeners();
            isLoading = false;
            print("cidrett---$cid");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("cid", cid!);
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

  /////////////////// verify registration//////////////
  Future<Registration?> verifyRegistration(
      String company_code, String fp, BuildContext context) async {
    var res;
    print("company_code---fp-${company_code}---${fp}");

    try {
      Uri url = Uri.parse("$urlgolabl/verify_registration.php");
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

      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  /////////////////////////sum////////////////////////
  calculate_sum(List<num> list) {
    num sum = 0;
    list.forEach((num e) {
      sum = sum + e;
    });
    print(sum);
    return sum;
  }

  ///////////////////chart data///////////////////////
  Future<ChartData?> chartDataSet(String branch_id, String from_date,
      String till_date, BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        var res;
        // print("company_code---fp-${company_code}---${fp}");
        try {
          Uri url = Uri.parse("$urlgolabl/reports.php");
          Map body = {
            'branch_id': branch_id,
            'from_date': from_date,
            'till_date': till_date,
          };

          http.Response response = await http.post(
            url,
            body: body,
          );
          print("body ${body}");

          var map = jsonDecode(response.body);
          print("map today ${map}");

          collectData.clear();
          countData.clear();
          departmentData.clear();
          servicegroupData.clear();
          colorList.clear();
          print("map chart data ${map}");
          for (var item in map["collection_data"]) {
            print("inside for length  ${item}");
            collectData.add(item);
            num_list.add(item["measure"]);
            colorList.add(item["color_code"]);
          }
          print("color list.....$colorList");

          sum = calculate_sum(num_list);
          for (var item in collectData) {
            print("item----$item");
            num percent = item["measure"] / sum;
            item["per"] = percent;
            // collectData.add({"per":0});
          }

          num_list.clear();

          print("coll--$collectData");
          // print("num_list---$sum");
          colorListcount.clear();
          for (var item in map["count_data"]) {
            countData.add(item);
            num_list.add(item["measure"]);
            colorListcount.add(item["color_code"]);
          }
          print("colorlist count $countData");
          sum = calculate_sum(num_list);
          for (var item in countData) {
            print("item----$item");
            num percent = item["measure"] / sum;
            item["per"] = percent;
            // collectData.add({"per":0});
          }
          num_list.clear();
          print("collectData ${countData}");

          for (var item in map["department_data"]) {
            departmentData.add(item);
            num_list.add(item["measure"]);
          }
          print("department wise data $departmentData");
          sum = calculate_sum(num_list);
          for (var item in departmentData) {
            print("item----$item");
            num percent = item["measure"] / sum;
            item["per"] = percent;
            // collectData.add({"per":0});
          }
          print("departmentData ${departmentData}");
          num_list.clear();
          for (var item in map["servicegroup_data"]) {
            servicegroupData.add(item);
            num_list.add(item["measure"]);
          }
          sum = calculate_sum(num_list);
          for (var item in servicegroupData) {
            print("item----$item");
            num percent = item["measure"] / sum;
            item["per"] = percent;
            // collectData.add({"per":0});
          }
          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  ////////////////////////////////////
  getBranchList() async {
    try {
      branchList.clear();
      Uri url = Uri.parse("$urlgolabl/branch_list.php");
      http.Response response = await http.post(
        url,
        // body: body,
      );

      var map = jsonDecode(response.body);
      print("map.........$map");
      branchid.clear();
      for (var item in map) {
        branchList.add(item);
        branchid.add(item['brnach_id']);
      }

      print("branchList ${branchid}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }
  // //////////////////////////////////////////

  Future<MultiChart?> multiChartDataSet(String from_date, String till_date,
      String branch_id, String period) async {
    var res;

    try {
      Uri url = Uri.parse("$urlgolabl/multi_graph.php");
      Map body = {
        'from_date': from_date,
        'till_date': till_date,
        'branch_id': branch_id,
        'period': period,
      };

      http.Response response = await http.post(
        url,
        body: body,
      );
      var map = json.decode(response.body);
      print("map............  ${map}");

      for (var item in map["collection"]) {
        print("inside for length  ${item}");
        multiCollection.add(item);
        // multiDta.add(item['data'][0]);
      }
      multiDta.clear();
      for (var item in map["visit_data"]) {
        print("inside for length  ${item}");
        // multiCollection.add(item);
        multiDta.add(item);
      }
      print("multiCollection ${multiDta}");
      multidepart.clear();
      for (var item in map["department_data"]) {
        print("inside for length  ${item}");
        // multiCollection.add(item);
        multidepart.add(item);
      }
      print("multidepart ${multidepart}");
      multiservice.clear();
      for (var item in map["servicegroup_data"]) {
        print("inside for length  ${item}");
        // multiCollection.add(item);
        multiservice.add(item);
      }
      print("multiservice ${multiservice}");

      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
